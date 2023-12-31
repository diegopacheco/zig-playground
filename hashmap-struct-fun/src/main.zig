const std = @import("std");
const print = std.debug.print;

const Person = struct {
    allocator: std.mem.Allocator,
    id: usize,
    name: []u8,
    email: []u8,

    fn new(allocator: std.mem.Allocator, id: usize, name: []const u8, email: []const u8) !Person {
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

    fn has(self: *PersonDAO, id: usize) bool {
        if (self.map.contains(id)) {
            return true;
        }
        return false;
    }

    fn count(self: *PersonDAO) usize {
        return self.map.count();
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var dao = PersonDAO.new(allocator);
    defer dao.deinit();

    var diego = try Person.new(allocator, 1, "Diego", "diego@diego.diego.com");
    defer diego.deinit();
    _ = try dao.put(diego);

    var andrew = try Person.new(allocator, 2, "Andrew", "andrew@andrew.zig.com");
    defer andrew.deinit();
    _ = try dao.put(andrew);

    if (dao.get(1)) |person| {
        print("Got person id:{d}, name:{s} email:{s} \n", .{ person.id, person.name, person.email });
        print("DAO has user 1 ? {any}\n", .{dao.has(1)});
    }
    print("DAO has {d} people \n", .{dao.count()});

    _ = dao.remove(2);
    print("DAO has Andrew? {any}\n", .{dao.has(2)});
    print("DAO has {d} size \n", .{dao.count()});
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
