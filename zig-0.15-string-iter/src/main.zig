const std = @import("std");

pub fn main() void {
    const csv = "alice,30,engineer;bob,25,designer;carol,40,manager";
    var rows = std.mem.splitScalar(u8, csv, ';');
    while (rows.next()) |row| {
        var cols = std.mem.splitScalar(u8, row, ',');
        const name = cols.next() orelse "?";
        const age = cols.next() orelse "?";
        const role = cols.next() orelse "?";
        std.debug.print("name={s} age={s} role={s}\n", .{ name, age, role });
    }
}
