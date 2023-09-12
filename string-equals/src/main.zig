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

    //
    // compare byte by byte (std.mem.eql)
    //
    //
    // Zig does not have strings, just array and slices of bytes
    // []const u8 is how you create a byte[] which will be a "string"
    //
    pub fn equals(self: Person,other: Person) bool {
        return 
               self.id == other.id and 
               std.mem.eql(u8, self.name, other.name) and
               std.mem.eql(u8, self.email, other.email);
    }

};

fn check(p1:Person,p2:Person) void {
    print("p1 type is {any}", .{@TypeOf(p1)});
    print("p2 type is {any}", .{@TypeOf(p2)});
    if (p1.equals(p2)) {
        print("Yes! Same spider man \n",.{});
    }else{
        print("Nooo! Different spider man. different multiverse \n",.{});
    }
}

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
    
    const venon = Person{
        .id = 1,
        .name = "Venon",
        .email = "spider@man.com"
    };

    check(spiderA, spiderB);
    check(spiderA, venon);    

}