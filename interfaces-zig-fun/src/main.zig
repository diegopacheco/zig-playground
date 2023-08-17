const std = @import("std");

const Dog = struct {
    // Fields
    barkFn: fn (self: *const Dog, volume: u32) void,

    // Methods
    pub fn bark(self: *const Dog, volume: u32) void {
        self.barkFn(self, volume);
    }
};

const Retriever = struct {
    // Fields
    dog: Dog = Dog{ .barkFn = bark },

    // Methods
    fn bark(dog: *const Dog, volume: u32) void {
        _ = volume;
        _ = dog;
        std.log.info("Wolf Wolf !\n", .{});
    }
};

const Pinscher = struct {
    // Fields
    dog: Dog = Dog{ .barkFn = bark },

    // Methods
    fn bark(dog: *const Dog, volume: u32) void {
        _ = volume;
        _ = dog;
        std.log.info("I will kill you mofo!\n", .{});
    }
};

pub fn main() !void {
    comptime var dogs = [_]Dog{ (Pinscher{}).dog, (Retriever{}).dog };
    for (dogs) |dog| {
        dog.bark(50);
    }
}
