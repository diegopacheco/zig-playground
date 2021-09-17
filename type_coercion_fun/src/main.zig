const std = @import("std");

pub fn main() anyerror!void {

    var a:u8 = 1;
    var b:u16 = a;
    std.log.info("Type Coercion on vars a:u8={} b:u16={}", .{
        a,
        b
    });
    convertOnCall(a);

    var c = @as(u16, a);
    std.log.info("Type Coercion works with @as() {}", .{c});
}

fn convertOnCall(b: u16) void {
    std.log.info("Type Coercion works in function {} ", .{b});
}
