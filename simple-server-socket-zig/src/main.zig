const std = @import("std");
const print = std.debug.print;
const net = std.net;

const addr = net.Address.initIp4(.{ 127, 0, 0, 1 }, 7496);
pub fn main() !void {
    const options = net.StreamServer.Options{};
    const server = net.StreamServer.init(options);

    _ = try server.listen(addr);
    print("Socket Server listening on port: {s}\n", .{addr});

    while (true) {
        const client = try server.accept();
        const client_addr = client.address;
        const stream = client.stream;

        var buffer: [258]u8 = undefined;
        _ = try stream.read(&buffer);
        _ = try stream.write("Hey from the server");

        print("Socket client addr is: {s}\n", .{client_addr});
        print("Request buffer is: {s}\n", .{buffer});
    }
}
