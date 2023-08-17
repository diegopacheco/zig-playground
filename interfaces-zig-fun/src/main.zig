const std = @import("std");

const Cat = struct {
    anger_level: usize,

    pub fn talk(self: Cat) void {
        std.debug.print("Cat: meow! (anger lvl {})", .{self.anger_level});
    }
};

const Dog = struct {
    name: []const u8,

    pub fn talk(self: Dog) void {
        std.debug.print("{s} the dog: bark!", .{self.name});
    }
};

const Animal = union(enum) {
    cat: Cat,
    dog: Dog,

    pub fn talk(self: Animal) void {
        switch (self) {
            .cat => |cat| cat.talk(),
            .dog => |dog| dog.talk(),
        }
    }
};

pub fn main() !void {
    var animals = [_]Dog{Dog{ .name = "Dogy" }};
    for (animals) |animal| {
        animal.talk();
    }
}
