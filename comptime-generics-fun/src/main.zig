const std = @import("std");

// A comptime parameter means that:
// At the callsite, the value must be known at compile-time, 
// or it is a compile error.
// In the function definition, the value is known at compile-time.
pub fn main() anyerror!void {
    const result = max(bool, false, true) == true;
    std.log.info("comptime max(bool,false,true) == {}", .{result});
}

fn max(comptime T: type, a: T, b: T) T {
    if (T == bool) {
        return a or b;
    } else if (a > b) {
        return a;
    } else {
        return b;
    }
}

