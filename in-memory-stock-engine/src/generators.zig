const std = @import("std");
const event = @import("event.zig");
const predicates = @import("predicates.zig");

pub const Randomizer = struct {
    rng: std.Random,

    pub fn init(seed: u64) Randomizer {
        var prng = std.Random.DefaultPrng.init(seed);
        return Randomizer{
            .rng = prng.random(),
        };
    }

    pub fn value(self: *Randomizer) f64 {
        return self.rng.float(f64) * (9000.0 - 10.0) + 10.0;
    }

    pub fn symbol(self: *Randomizer) []const u8 {
        const symbols = [_][]const u8{
            "XOM", "GE", "TM", "PG", "GOOG", "ING", "AAPL", "META", "NFLX", "AMZN", "XOM",
        };
        const result = self.rng.intRangeAtMost(usize, 0, 8);
        return symbols[result];
    }
};

pub const NasdaqEventGenerator = struct {
    randomizer: Randomizer,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, seed: u64) NasdaqEventGenerator {
        return NasdaqEventGenerator{
            .randomizer = Randomizer.init(seed),
            .allocator = allocator,
        };
    }

    pub fn generate(self: *NasdaqEventGenerator, amount: usize) !std.ArrayList(event.Event) {
        var events: std.ArrayList(event.Event) = .empty;
        errdefer events.deinit(self.allocator);

        var i: usize = 0;
        while (i < amount) : (i += 1) {
            const evt = try self.create();
            try events.append(self.allocator, evt);
        }

        return events;
    }

    fn create(self: *NasdaqEventGenerator) !event.Event {
        const result = self.randomizer.rng.intRangeAtMost(u8, 1, 2);
        const sym = self.randomizer.symbol();
        const val = self.randomizer.value();

        if (result == 1) {
            const stock_up = try self.allocator.create(event.StockUp);
            stock_up.* = event.StockUp.new(sym, val);
            return event.Event.init(stock_up);
        } else {
            const stock_down = try self.allocator.create(event.StockDown);
            stock_down.* = event.StockDown.new(sym, val);
            return event.Event.init(stock_down);
        }
    }
};

pub const UserPredicatesGenerator = struct {
    randomizer: Randomizer,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, seed: u64) UserPredicatesGenerator {
        return UserPredicatesGenerator{
            .randomizer = Randomizer.init(seed),
            .allocator = allocator,
        };
    }

    pub fn generate(self: *UserPredicatesGenerator, amount: usize) !std.ArrayList(predicates.Predicate) {
        var preds: std.ArrayList(predicates.Predicate) = .empty;
        errdefer preds.deinit(self.allocator);

        var i: usize = 0;
        while (i < amount) : (i += 1) {
            const pred = try self.create();
            try preds.append(self.allocator, pred);
        }

        return preds;
    }

    fn create(self: *UserPredicatesGenerator) !predicates.Predicate {
        const result = self.randomizer.rng.intRangeAtMost(u8, 1, 3);
        const sym = self.randomizer.symbol();
        const val = self.randomizer.value();

        if (result == 1) {
            const equal = try self.allocator.create(predicates.Equal);
            equal.* = predicates.Equal.new(sym, val);
            return predicates.Predicate.init(equal);
        } else if (result == 2) {
            const less_than = try self.allocator.create(predicates.LessThan);
            less_than.* = predicates.LessThan.new(sym, val);
            return predicates.Predicate.init(less_than);
        } else {
            const greater_than = try self.allocator.create(predicates.GreaterThan);
            greater_than.* = predicates.GreaterThan.new(sym, val);
            return predicates.Predicate.init(greater_than);
        }
    }
};
