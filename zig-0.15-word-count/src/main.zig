const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const text = "the quick brown fox jumps over the lazy dog the fox is quick";
    var counts = std.StringHashMap(u32).init(allocator);
    defer counts.deinit();

    var it = std.mem.tokenizeScalar(u8, text, ' ');
    while (it.next()) |word| {
        const gop = try counts.getOrPut(word);
        if (!gop.found_existing) gop.value_ptr.* = 0;
        gop.value_ptr.* += 1;
    }

    var entries = counts.iterator();
    while (entries.next()) |e| {
        std.debug.print("{s} = {d}\n", .{ e.key_ptr.*, e.value_ptr.* });
    }
}
