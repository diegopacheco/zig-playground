const std = @import("std");

fn genericMath(value:anytype) @TypeOf(value) {
    if (i32 == @TypeOf(value)){
        return value + 1;
    }
    if (i64 == @TypeOf(value)){
        return value + 2;
    }
    return value * 2;
}

pub fn main() !void {
    var x:i32 = 10;
    var y:i64 = 20;
    var z:u8 = 30;

    std.debug.print("result is {} \n", .{genericMath(x)});
    std.debug.print("result is {} \n", .{genericMath(y)});
    std.debug.print("result is {} \n", .{genericMath(z)});
}
