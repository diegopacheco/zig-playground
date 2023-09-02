const std = @import("std");

const InvalidNumberError = error {
    GenericError
};

fn getNumerOrError(i:i32) !i32 {
    if (171 == i) {
       return InvalidNumberError.GenericError;     
    }
    return i;
}

pub fn main() !void {
    std.debug.print("is 171 okay? \n", .{});
    _ = getNumerOrError(171) catch |err| {
        std.debug.print("Error {}", .{err});
    };
}
