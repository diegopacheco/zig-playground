const std = @import("std");

pub fn main() anyerror!void {
    std.log.info("All your codebase are belong to us.", .{});
}

const expect = @import("std").testing.expect;
const mem = @import("std").mem;
test "string literals" {
    const bytes = "hello";
    try expect(@TypeOf(bytes) == *const [5:0]u8);
    try expect(bytes.len == 5);
    try expect(bytes[1] == 'e');
    try expect(bytes[5] == 0);
    try expect('e' == '\x65');
    try expect('\u{1f4a9}' == 128169);
    try expect('💯' == 128175);
    try expect(mem.eql(u8, "hello", "h\x65llo"));
    try expect("\xff"[0] == 0xff); // non-UTF-8 strings are possible with \xNN notation.
}
