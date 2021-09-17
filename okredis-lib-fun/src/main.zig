const std = @import("std");
const okredis = @import("./zig-okredis/src/okredis.zig");
const SET = okredis.commands.strings.SET;
const OrErr = okredis.types.OrErr;
const Client = okredis.Client;

pub fn main() !void {
    const addr = try std.net.Address.parseIp4("127.0.0.1", 6379);
    var connection = try std.net.tcpConnectToAddress(addr);
    
    var client: Client = undefined;
    try client.init(connection);
    defer client.close();

    // Basic interface
    try client.send(void, .{ "SET", "key", "42" });
    const reply = try client.send(i64, .{ "GET", "key" });
    if (reply != 42) @panic("out of towels");

    // Command builder interface
    const cmd = SET.init("key", "43", .NoExpire, .IfAlreadyExisting);
    const otherReply = try client.send(OrErr(void), cmd);
    switch (otherReply) {
        .Nil => @panic("command should not have returned nil"),
        .Err => @panic("command should not have returned an error"),
        .Ok => std.debug.warn("{*}",.{"success!"}),
    }
}
