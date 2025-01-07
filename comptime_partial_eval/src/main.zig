const std = @import("std");

const MyStruct = struct {
    a: i64 = 0,
    b: i64 = 0,
    c: i64 = 0,

    fn sumFields(self: @This()) i64 {
        var sum: i64 = 0;
        inline for (comptime std.meta.fieldNames(@This())) |field_name| {
            sum += @field(self, field_name);
        }
        return sum;
    }
};

pub fn main() !void {
    const my_struct = MyStruct{ .a = 1, .b = 2, .c = 3 };
    const sum = MyStruct.sumFields(my_struct);
    std.debug.print("Sum of fields: {}\n", .{sum});
}

test "simple test - all fields, total 6" {
    const my_struct = MyStruct{ .a = 1, .b = 2, .c = 3 };
    const sum = MyStruct.sumFields(my_struct);
    try std.testing.expectEqual(@as(i64, 6), sum);
}

test "simple test - two fields, total 3" {
    const my_struct = MyStruct{ .a = 1, .b = 2 };
    const sum = MyStruct.sumFields(my_struct);
    try std.testing.expectEqual(@as(i64, 3), sum);
}
