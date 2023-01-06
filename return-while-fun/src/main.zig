const std = @import("std");

fn isRange(start:usize, end:usize, target:usize) bool {
    var i = start;
    return while (i<end):(i+=1){
        if (i==target){
            break true;
        }
    }else false;
}

pub fn main() !void {
    const result:bool = isRange(0,100,32);
    std.debug.print("Is {} in ragnge with {} and {} ? == {}.\n", .{32,0,100,result});
}

test "simple test" {
    try std.testing.expectEqual(@as(i32, 42), 42);
}
