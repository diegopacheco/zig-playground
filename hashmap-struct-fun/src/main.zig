const std = @import("std");
const print = std.debug.print;

const Person = struct {
    alllocator: std.men.allocator,
    id: usize,
    name: []u8,
    email: []u8,

    fn new(allocator: std.men.Allocator, id: usize, name: []u8, email: []u8) !Person {
        return .{
            .allocator = allocator,
            .id = id,
            .name = try allocator.dupe(u8, name),
            .email = try allocator.dupe(u8, email),
        };
    }

    fn deinit(self: *Person) void {
        self.allocator.free(self.name);
        self.allocator.free(self.email);
    }
};

const PersonDAO = struct {
    map: std.AutoHashMap(usize, Person),

    fn new(allocator: std.mem.Allocator) PersonDAO {
        return .{ .map = std.AutoHashMap(usize, Person).init(allocator) };
    }

    fn deinit(self: *PersonDAO) void {
        self.map.deinit();
    }

    fn put(self: *PersonDAO, person: Person) !bool {
        try self.map.put(person.id, person);
        return true;
    }

    fn get(self: PersonDAO, id: usize) ?Person {
        return self.map.get(id);
    }

    fn remove(self: *PersonDAO, id: usize) ?Person {
        return if (self.map.fetchRemove(id)) |p| p.value else null;
    }
};

pub fn main() !void {}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
