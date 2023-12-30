extern fn print(i32) void;

export fn add(a: i32, b: i32) i32 {
    const result = a + b;
    print(result);
    return result;
}

pub fn main() !void {}
