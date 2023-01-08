const std = @import("std");
const expect = std.testing.expect;
const eql = std.testing.eql;

pub fn main() !void {
    const text = "robust, optimal, reusable, maintainable, ";
    var iter = std.mem.split(u8, text, ", ");
    var next = iter.next().?;
    std.debug.print("item: {s}",.{next});     
}

test "split iterator" {
    const text = "robust, optimal, reusable, maintainable, ";
    var iter = std.mem.split(u8, text, ", ");
    try expect(eql(u8, iter.next().?, "robust"));
    try expect(eql(u8, iter.next().?, "optimal"));
    try expect(eql(u8, iter.next().?, "reusable"));
    try expect(eql(u8, iter.next().?, "maintainable"));
    try expect(eql(u8, iter.next().?, ""));
    try expect(iter.next() == null);
}
