const std = @import("std");

pub fn main() anyerror!void {
    std.log.info("All your codebase are belong to us.", .{});
}

const expect = @import("std").testing.expect;
test "comments" {
    // Comments in Zig start with "//" and end at the next LF byte (end of line).
    // The below line is a comment, and won't be executed.
    //expect(false);
    const x = true;  // another comment
    try expect(x);
}