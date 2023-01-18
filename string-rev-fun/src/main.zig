const std = @import("std");

pub fn main() !void {
    var original = "hello".*;
    std.debug.print("String {s}\n",.{original});
    std.debug.print("Debug {any}\n",.{original});

    // gets the string literal as slice
    var reversed = rev(&original,original.len);

    // hello == olleh
    std.debug.print("Reversed {s}\n",.{reversed});
    std.debug.print("Reversed {any}\n",.{reversed});
}

// size need to be know at compile time - thats why comptime
fn rev(str: []u8,comptime size:usize) []u8 {
    // how to initialize an array with zeros
    var result = [_]u8{0} ** size;

    var indexStr:u8 = size - 1;
    var i: usize = 0;
    while(i <= str.len - 1): (i += 1) {
        std.debug.print(">> DEBUG: index {} indexStr {} char {} \n",.{i,indexStr,str[i]});
        result[i] = str[indexStr];
        if (i==str.len-1){
            break;
        }
        indexStr -= 1;
    }
    return &result;
}

test "simple test" {
    try std.testing.expectEqual(@as(i32, 42), 42);
}
