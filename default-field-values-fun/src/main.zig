const std = @import("std");

const StdPerson = struct {
    id: i32,
    name: []const u8,
    profession: []const u8 = "Software Engineer",

    pub fn print(self: StdPerson) !void {
        std.debug.print("Person id [{d}]\n", .{self.id});
        std.debug.print("Person name [{s}]\n", .{self.name});
        std.debug.print("Person profession [{s}]\n", .{self.profession});
    }
};

pub fn main() !void {
    const Person = StdPerson{
        .id = 2,
        .name = "John Doe",
    };
    try Person.print();
}
