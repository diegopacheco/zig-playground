const std = @import("std");
const zbench = @import("zbench");

fn benchmarkMyFunction(b: *zbench.Benchmark) void {
    _ = b;
    var i = 0;
    while (i <= 3000) {
        i += 1;
    }
}

pub fn main() !void {
    var allocator = std.heap.page_allocator;
    var b = try zbench.Benchmark.init("benchmarkMyFunction", &allocator);
    try zbench.run(benchmarkMyFunction, &b);
}
