const std = @import("std");
const network = @import("network.zig");

const buffer_size = 1024;
pub fn main() !void {
    try network.init();
    defer network.deinit();

    const port_number = try std.fmt.parseInt(u16, "8080", 10);
    var sock = try network.Socket.create(.ipv4, .tcp);
    defer sock.close();

    try sock.bindToPort(port_number);
    std.debug.print("Server running on http://127.0.0.1:8080/ \n", .{});

    try sock.listen();
    while (true) {
        var client = try sock.accept();
        defer client.close();

        std.debug.print("Client connected from {}.\n", .{
            try client.getLocalEndPoint(),
        });

        runEchoClient(client) catch |err| {
            std.debug.print("Client disconnected with msg {s}.\n", .{
                @errorName(err),
            });
            continue;
        };
        std.debug.print("Client disconnected.\n", .{});
    }
}

fn runEchoClient(client: network.Socket) !void {
    while (true) {
        var buffer: [buffer_size]u8 = undefined;

        const len = try client.receive(&buffer);
        if (len == 0)
            break;
        // we ignore the amount of data sent.
        _ = try client.send(buffer[0..len]);
    }
}
