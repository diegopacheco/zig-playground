const std = @import("std");

pub fn GenericMyStruct(comptime T: type) type {
    return struct {
        a: T,
        b: T,
        c: T,

        fn sumFields(my_struct: GenericMyStruct(T)) T {
            var sum: T = 0;
            const fields = comptime std.meta.fieldNames(GenericMyStruct(T));
            inline for (fields) |field_name| {
                sum += @field(my_struct, field_name);
            }
            return sum;
        }
    };
}

pub fn main() void {
    const my_struct: GenericMyStruct(i64) = .{
        .a = 1,
        .b = 2,
        .c = 3,
    };
    std.debug.print("structs's sum is {d}.\n", .{my_struct.sumFields()});
}

test "sum should be 6" {
    const my_struct: GenericMyStruct(i64) = .{
        .a = 1,
        .b = 2,
        .c = 3,
    };
    try std.testing.expectEqual(@as(i64, 6), my_struct.sumFields());
}
