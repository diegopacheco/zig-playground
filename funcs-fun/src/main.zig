const std = @import("std");

pub fn main() anyerror!void {
    
    const print = std.debug.print;
    const result = sum(2,3);
    print("Result from sum({},{}) == {}\n", .{2,3,result});

}

fn sum(a:i64,b:i64) i64 {
    const result = a+b;
    return result;
}
