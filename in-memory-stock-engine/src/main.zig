const std = @import("std");
const engine = @import("engine.zig");
const generators = @import("generators.zig");
const predicates = @import("predicates.zig");
const event = @import("event.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    std.debug.print(">> Benchmarks: CAP 100 rules\n", .{});
    try benchmarkCap(allocator, 10, 100);
    try benchmarkCap(allocator, 100, 100);
    try benchmarkCap(allocator, 1_000, 100);
    try benchmarkCap(allocator, 10_000, 100);
    try benchmarkCap(allocator, 100_000, 100);
    try benchmarkCap(allocator, 1_000_000, 100);
    try benchmarkCap(allocator, 10_000_000, 100);

    std.debug.print(">> Benchmarks: NO CAP (rules x events)\n", .{});
    try benchmark(allocator, 10);
    try benchmark(allocator, 100);
    try benchmark(allocator, 1_000);
    try benchmark(allocator, 10_000);
    try benchmark(allocator, 100_000);
}

fn benchmark(allocator: std.mem.Allocator, amount: usize) !void {
    try benchmarkCap(allocator, amount, amount);
}

fn benchmarkCap(allocator: std.mem.Allocator, amount_events: usize, amount_rules: usize) !void {
    const seed = @as(u64, @intCast(std.time.timestamp()));

    var predicates_generator = generators.UserPredicatesGenerator.init(allocator, seed);
    var predicates_list = try predicates_generator.generate(amount_rules);
    defer {
        for (predicates_list.items) |pred| {
            const ptr: *const anyopaque = pred.ptr;
            const typed_ptr: *const predicates.Equal = @alignCast(@ptrCast(ptr));
            allocator.destroy(typed_ptr);
        }
        predicates_list.deinit(allocator);
    }

    var event_generator = generators.NasdaqEventGenerator.init(allocator, seed + 1);
    var events = try event_generator.generate(amount_events);
    defer {
        for (events.items) |evt| {
            const ptr: *const anyopaque = evt.ptr;
            const typed_ptr: *const event.StockUp = @alignCast(@ptrCast(ptr));
            allocator.destroy(typed_ptr);
        }
        events.deinit(allocator);
    }

    const matcher = engine.InMemoryMatcher.init(allocator, predicates_list);

    const start = std.time.nanoTimestamp();
    var matches = try matcher.run(events);
    defer matches.deinit(allocator);
    const end = std.time.nanoTimestamp();

    const duration_ms = @divFloor(end - start, 1_000_000);

    std.debug.print("Matching {} events / {} predicates resulted in: [{}] match in {} ms\n", .{
        amount_events,
        amount_rules,
        matches.items.len,
        duration_ms,
    });
}
