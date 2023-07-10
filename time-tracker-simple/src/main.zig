const std = @import("std");

pub fn main() !void {
    const time_in_hours: i32 = 15;
    const items_to_be_done: i32 = 30;
    const result = items_to_be_done / time_in_hours;

    std.debug.print("To finish all: {d} user stories in {d} hours\n\r", .{ items_to_be_done, time_in_hours });
    std.debug.print("Pace need to be: {d}/hour \n\r", .{result});
}
