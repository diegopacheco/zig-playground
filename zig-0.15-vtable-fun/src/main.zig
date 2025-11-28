const std = @import("std");

const Animal = struct {
    vtable: *const VTable,

    const VTable = struct {
        speak: *const fn (*const Animal) void,
        move: *const fn (*const Animal) void,
    };

    fn speak(self: *const Animal) void {
        self.vtable.speak(self);
    }

    fn move(self: *const Animal) void {
        self.vtable.move(self);
    }
};

const Dog = struct {
    animal: Animal,
    name: []const u8,

    fn init(name: []const u8) Dog {
        return .{
            .animal = .{ .vtable = &vtable },
            .name = name,
        };
    }

    fn speak(animal: *const Animal) void {
        const self: *const Dog = @fieldParentPtr("animal", animal);
        std.debug.print("{s} says: Woof!\n", .{self.name});
    }

    fn move(animal: *const Animal) void {
        const self: *const Dog = @fieldParentPtr("animal", animal);
        std.debug.print("{s} runs on four legs\n", .{self.name});
    }

    const vtable = Animal.VTable{
        .speak = speak,
        .move = move,
    };
};

const Cat = struct {
    animal: Animal,
    name: []const u8,

    fn init(name: []const u8) Cat {
        return .{
            .animal = .{ .vtable = &vtable },
            .name = name,
        };
    }

    fn speak(animal: *const Animal) void {
        const self: *const Cat = @fieldParentPtr("animal", animal);
        std.debug.print("{s} says: Meow!\n", .{self.name});
    }

    fn move(animal: *const Animal) void {
        const self: *const Cat = @fieldParentPtr("animal", animal);
        std.debug.print("{s} walks silently\n", .{self.name});
    }

    const vtable = Animal.VTable{
        .speak = speak,
        .move = move,
    };
};

pub fn main() void {
    const dog = Dog.init("Rex");
    const cat = Cat.init("Whiskers");

    const animals = [_]*const Animal{
        &dog.animal,
        &cat.animal,
    };

    for (animals) |animal| {
        animal.speak();
        animal.move();
        std.debug.print("\n", .{});
    }
}
