const std = @import("std");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const Response = struct {
        headers: struct {
            Host: []const u8,
            @"User-Agent": []const u8,
        },
    };
    const input =
        \\ {
        \\ "headers": {
        \\   "Accept": "application/vnd.github.v3+json",
        \\   "Host": "httpbin.org",
        \\   "User-Agent": "my http client",
        \\   "X-Amzn-Trace-Id": "Root=1-632f00bb-04724a8831e8b65c47175bba"
        \\ } }
    ;
    var stream = std.json.TokenStream.init(input);
    const resp = try std.json.parse(Response, &stream, .{
        .allocator = allocator,
        .ignore_unknown_fields = true,
    });
    std.log.info("Host: {s}", .{resp.headers.Host});
    std.log.info("User-Agent: {s}", .{resp.headers.@"User-Agent"});
}
