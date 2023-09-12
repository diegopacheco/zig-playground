const std = @import("std");
const print = std.debug.print;

const Person = struct {
    id: u64,
    name: []const u8,
    email: []const u8,

    pub fn new(id: u64, name: []const u8,email: []const u8) Person {
        return .{
            .id = id,
            .name = name,
            .email = email
        };
    }

    pub fn equals(self:main.Person,other:Person) bool {
        return std.mem.eql(main.Person, self, other);
    }

};

pub fn main() !void {

    const spiderA = Person{
        .id = 1,
        .name = "Petter",
        .email = "spider@man.com"
    };

    const spiderB = Person{
        .id = 1,
        .name = "Petter",
        .email = "spider@man.com"
    };

    print("Person type is {any}", .{@TypeOf(spiderA)});

    if (spiderA.equals(spiderB)) {
        print("Same spider man",.{});
    }else{
        print("Different spider man. different multiverse",.{});
    }

}