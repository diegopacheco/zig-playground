const std = @import("std");
const event = @import("event.zig");
const predicates = @import("predicates.zig");

pub const MaterializedMatch = struct {
    match_time: i64,

    pub fn new() MaterializedMatch {
        return MaterializedMatch{
            .match_time = std.time.timestamp(),
        };
    }
};

pub const InMemoryMatcher = struct {
    predicates_list: std.ArrayList(predicates.Predicate),
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, preds: std.ArrayList(predicates.Predicate)) InMemoryMatcher {
        return InMemoryMatcher{
            .predicates_list = preds,
            .allocator = allocator,
        };
    }

    pub fn run(self: *const InMemoryMatcher, events: std.ArrayList(event.Event)) !std.ArrayList(MaterializedMatch) {
        var materialized_matches: std.ArrayList(MaterializedMatch) = .empty;
        errdefer materialized_matches.deinit(self.allocator);

        for (events.items) |evt| {
            for (self.predicates_list.items) |pred| {
                if (pred.matches(evt)) {
                    try materialized_matches.append(self.allocator, MaterializedMatch.new());
                }
            }
        }

        return materialized_matches;
    }
};
