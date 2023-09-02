const std = @import("std");

const BadNumberError = error{GenericError};

fn validateNumber(num: i32) !i32 {
    if (171 == num) {
        return BadNumberError.GenericError;
    }
    return num;
}

fn validate(n: i32) void {
    if (validateNumber(n)) |value| {
        std.debug.print("{d} is ok \n", .{value});
    } else |err| {
        std.debug.print("{} is not ok. Oopsy Daisy {} \n", .{ n, err });
    }
}

pub fn main() !void {
    validate(42);
    validate(171);
}
