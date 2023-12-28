const std = @import("std");
const printb = std.fmt.bufPrint;
const print = std.debug.print;

pub fn main() !void {
    var jd = Person{
        .id = 120,
        .name = "John Doe",
        .email = "johndoe@jd.jd",
    };
    const jd_impl = jd.tostring();
    try printToString(jd_impl);
}

fn printToString(s: ToString) !void {
    var buf: [256]u8 = undefined;
    const str = try s.toString(&buf);
    print("ToString {s} \n", .{str});
}

pub const ToString = struct {
    ptr: *anyopaque,
    toStringFn: *const fn (*anyopaque, []u8) anyerror![]u8,

    pub fn toString(self: ToString, buf: []u8) anyerror![]u8 {
        return self.toStringFn(self.ptr, buf);
    }
};

pub const Person = struct {
    id: u64,
    name: []const u8,
    email: []const u8,

    pub fn toString(ptr: *anyopaque, buf: []u8) ![]u8 {
        var self: *Person = @ptrCast(@alignCast(ptr));
        return printb(buf, "Person(id: {[id]d}, name: {[name]s}, email: {[email]s})", self.*);
    }

    pub fn tostring(self: *Person) ToString {
        return .{
            .ptr = self,
            .toStringFn = Person.toString,
        };
    }
};
