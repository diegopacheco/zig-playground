const std = @import("std");

const Point = struct {
    x: f64,
    y: f64,

    fn distance(self: Point, other: Point) f64 {
        const dx = self.x - other.x;
        const dy = self.y - other.y;
        return @sqrt(dx * dx + dy * dy);
    }

    fn translate(self: *Point, dx: f64, dy: f64) void {
        self.x += dx;
        self.y += dy;
    }
};

pub fn main() void {
    var a = Point{ .x = 0, .y = 0 };
    const b = Point{ .x = 3, .y = 4 };
    std.debug.print("dist a..b = {d}\n", .{a.distance(b)});
    a.translate(1, 1);
    std.debug.print("after move a=({d},{d}) dist={d}\n", .{ a.x, a.y, a.distance(b) });
}
