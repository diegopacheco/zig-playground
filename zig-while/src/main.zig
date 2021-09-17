const std    = @import("std");
const expect = @import("std").testing.expect;

pub fn main() anyerror!void {

    const print = std.debug.print;

    var i: usize = 0;
    while (i < 10) {
        i += 1;
        print("i == {}\n", .{i});
    }

    try expect(i == 10);
    print("Result while is {}\n", .{i});

}