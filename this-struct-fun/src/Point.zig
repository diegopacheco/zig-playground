x: f32,
y: f32 = 0,

const Point = @This();

pub fn default() Point {
    return .{ .x = 0, .y = 0 };
}

pub fn new(x: f32, y: f32) Point {
    return .{ .x = x, .y = y };
}

pub fn distance(self: Point, other: Point) f32 {
    const diffx = other.x - self.x;
    const diffy = other.y - self.y;
    return @sqrt(diffx * diffx + diffy * diffy);
}
