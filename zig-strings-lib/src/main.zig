const std = @import("std");
const String = @import("zig_string").String;

pub fn main() !void {

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    var myString = String.init(arena.allocator());
    defer myString.deinit();

    try myString.concat("🔥 Hello!");
    _ = myString.pop();
    try myString.concat(", World 🔥");
    
    if (myString.cmp("🔥 Hello, World 🔥")){
        std.debug.print("OK = {s}\n", .{myString.str()});
    }else{
        std.debug.print("Oopsy Daisy  = {s}\n", .{myString.str()});
    }
    
}
