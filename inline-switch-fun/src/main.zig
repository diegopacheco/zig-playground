const std = @import("std");

const Struct1 = struct { a: u32, b: ?u32 };

pub fn main() !void {
    const result = try isFieldOptional(Struct1, 0);
    std.debug.print("result is {!} \n", .{result});
}

fn isFieldOptional(comptime T: type, field_index: usize) !bool {
    const fields = @typeInfo(T).Struct.fields;
    return switch (field_index) {
        inline 0...fields.len - 1 => |idx| @typeInfo(fields[idx].type) == .Optional,
        else => return error.IndexOutOfBounds,
    };
}
