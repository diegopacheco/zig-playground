const std = @import("std");
const interface = @import("interface.zig");

const Square = struct {
    side_length: i32,

    pub fn drawOpaque(ptr: *const anyopaque) void {
        const self: *const Square = @ptrCast(@alignCast(ptr));
        std.debug.print("Drawing square with side length {d}\n", .{self.side_length});
    }
};

const Circle = struct {
    side_length: i32,

    pub fn drawOpaque(ptr: *const anyopaque) void {
        const self: *const Circle = @ptrCast(@alignCast(ptr));
        std.debug.print("Drawing circle with side length {d}\n", .{self.side_length});
    }
};

fn draw(itf: interface.Interface) void {
    itf.concreteFn();
}

pub fn main() !void {
    const square = Square{ .side_length = 5 };
    const circle = Circle{ .side_length = 10 };

    const squareInterface = interface.Interface.init(&square);
    const circleInterface = interface.Interface.init(&circle);

    draw(squareInterface);
    draw(circleInterface);
}
