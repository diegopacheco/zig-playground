const std = @import("std");
const testing = std.testing;
const mem = std.mem;

const Place = struct { lat: f64, long: f64 };

test "json parse" {
    const test_allocator = std.testing.allocator;
    const parsed = try std.json.parseFromSlice(
        Place,
        test_allocator,
        \\{ "lat": 40.684540, "long": -74.401422 }
    ,
        .{},
    );
    defer parsed.deinit();

    const place = parsed.value;

    try testing.expect(place.lat == 40.684540);
    try testing.expect(place.long == -74.401422);
}

fn floatsEqual(a: f64, b: f64, epsilon: f64) bool {
    return @abs(a - b) < epsilon;
}

test "json parse with strings" {
    const User = struct { name: []u8, age: u16 };
    const test_allocator = std.testing.allocator;

    const parsed = try std.json.parseFromSlice(
        User,
        test_allocator,
        \\{ "name": "Joe", "age": 25 }
    ,
        .{},
    );
    defer parsed.deinit();

    const user = parsed.value;

    try testing.expect(mem.eql(u8, user.name, "Joe"));
    try testing.expect(user.age == 25);
}
