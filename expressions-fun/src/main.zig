const std = @import("std");

pub fn main() !void {
    
    const items = [_]u32{10,20,30};
    const result = for (items) |value| {
        if (20==value and isEven(value)){
            break value;
        }
    } else 0;    
    std.debug.print("result on for expression == {}\n", .{result});

    var x = result;
    x = switch (x) {
        0, 10 => x,
        20, 100 => @divExact(x, 10),
        else => x,
    };
    std.debug.print("x on switch expression == {}\n", .{x});
}

fn isEven(number:usize) bool{
    return if (number%2==0){
        return true;
    } else false;
}

