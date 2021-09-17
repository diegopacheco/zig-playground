const std    = @import("std");
const expect = @import("std").testing.expect;

pub fn main() anyerror!void {
    var array = [_]i32{ 1, 2, 3, 4 };   
    var known_at_runtime_zero:usize = 0;
    const slice = array[known_at_runtime_zero..array.len];
    try expect(&slice[0] == &array[0]);
    try expect(slice.len == array.len);

    const print = std.debug.print;
    for (array) |_, i| {
        print("Slice value[{}] == {}!\n", .{i, slice[i]});
    }

}
