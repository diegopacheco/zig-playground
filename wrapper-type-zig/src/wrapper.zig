const std = @import("std");
const linfo = std.log.info;

pub fn Wrapper(comptime T: type) type {
    return struct {
        value: T,
        const Self = @This();

        pub fn init(value: T) void {
            return .{ .value = value };
        }

        pub fn get_value(self: *Self) T {
            return self.value;
        }

        pub fn print(self: *Self) void {
            linfo("Wrapper type [{}] value: [{}] \n", .{ @TypeOf(self), self.value });
        }
    };
}
