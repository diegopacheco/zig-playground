const std = @import("std");
const zbench = @import("zbench");

fn benchmarkMyFunction(b: *zbench.Benchmark) void {
    var i: u64 = 0;
    while (i <= 3000) {
        i += 1;
    }
    b.incrementOperations(1);
}

pub fn main() !void {
    var allocator = std.heap.page_allocator;
    var resultsAlloc = std.ArrayList(zbench.BenchmarkResult).init(allocator);
    var b = try zbench.Benchmark.init("benchmarkMyFunction", &allocator);
    var benchmarkResults = zbench.BenchmarkResults{
        .results = resultsAlloc,
    };

    try zbench.run(benchmarkMyFunction, &b, &benchmarkResults);
}
