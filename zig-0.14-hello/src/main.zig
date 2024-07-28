const std = @import("std");

pub fn Person(comptime T: type) type {
    return struct {
        allocator: *std.mem.Allocator,
        name: []const u8,
        age: T,
        friends: []const []const u8,

        const Self = @This();

        pub fn init(allocator: *std.mem.Allocator, name: []const u8, age: T) !*Self {
            const self = try allocator.create(Self);
            self.* = Self{
                .allocator = allocator,
                .name = name,
                .age = age,
                .friends = &[_][]const u8{},
            };
            return self;
        }

        pub fn addFriend(self: *Self, friend: []const u8) !void {
            const mutable_friends = @constCast(self.friends);
            var new_friends = try self.allocator.realloc(mutable_friends, self.friends.len + 1);
            new_friends[self.friends.len] = friend;
            self.friends = new_friends;
        }

        pub fn deinit(self: *Self) void {
            self.allocator.free(self.friends);
            self.allocator.destroy(self);
        }
    };
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var person = try Person(u32).init(@constCast(&allocator), "John Doe", 48);
    defer person.deinit();

    try person.addFriend("Alice");
    try person.addFriend("Bob");

    std.debug.print("Name: {s}, Age: {d}, Friends: {s}, {s}\n", .{ person.name, person.age, person.friends[0], person.friends[1] });
}
