const std = @import("std");

const Color = enum {
    red,
    green,
    blue,
    yellow,

    fn hex(self: Color) u24 {
        return switch (self) {
            .red => 0xff0000,
            .green => 0x00ff00,
            .blue => 0x0000ff,
            .yellow => 0xffff00,
        };
    }
};

pub fn main() void {
    inline for (@typeInfo(Color).@"enum".fields) |f| {
        const c: Color = @enumFromInt(f.value);
        std.debug.print("{s} -> #{x:0>6}\n", .{ @tagName(c), c.hex() });
    }
}
