const std = @import("std");
const json = std.json;
const AllocWhen = json.AllocWhen;
const ValueTree = json.ValueTree;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    const allocator = arena.allocator();

    const Response = struct {
        headers: struct {
            Host: []const u8,
            // error: MissingField
            // User_Agent: []const u8,
        },
    };

    var parser = std.json.Parser.init(allocator, AllocWhen.alloc_if_needed);
    defer parser.deinit();

    const input =
        \\ {
        \\ "headers": {
        \\   "Accept": "application/vnd.github.v3+json",
        \\   "Host": "httpbin.org",
        \\   "User-Agent": "my http client",
        \\   "X-Amzn-Trace-Id": "Root=1-632f00bb-04724a8831e8b65c47175bba"
        \\ } }
    ;
    var value = std.json.parseFromSlice(Response, allocator, input, .{});
    try std.debug.print("{any}", .{value});
}
