const std = @import("std");
const event = @import("event.zig");

pub const Predicate = struct {
    ptr: *const anyopaque,
    vtable: *const VTable,

    const VTable = struct {
        matches: *const fn (ptr: *const anyopaque, e: event.Event) bool,
    };

    pub fn matches(self: Predicate, e: event.Event) bool {
        return self.vtable.matches(self.ptr, e);
    }

    pub fn init(pointer: anytype) Predicate {
        const Ptr = @TypeOf(pointer);

        const gen = struct {
            fn matchesImpl(ptr: *const anyopaque, e: event.Event) bool {
                const self: Ptr = @alignCast(@ptrCast(@constCast(ptr)));
                return self.matches(e);
            }

            const vtable = VTable{
                .matches = matchesImpl,
            };
        };

        return .{
            .ptr = pointer,
            .vtable = &gen.vtable,
        };
    }
};

pub const Equal = struct {
    pred_value: f64,
    pred_symbol: []const u8,

    pub fn new(pred_symbol: []const u8, pred_value: f64) Equal {
        return Equal{
            .pred_value = pred_value,
            .pred_symbol = pred_symbol,
        };
    }

    pub fn matches(self: *const Equal, e: event.Event) bool {
        if (!std.mem.eql(u8, self.pred_symbol, e.symbol())) {
            return false;
        }
        return self.pred_value == e.value();
    }
};

pub const GreaterThan = struct {
    pred_symbol: []const u8,
    pred_value: f64,

    pub fn new(pred_symbol: []const u8, pred_value: f64) GreaterThan {
        return GreaterThan{
            .pred_symbol = pred_symbol,
            .pred_value = pred_value,
        };
    }

    pub fn matches(self: *const GreaterThan, e: event.Event) bool {
        if (!std.mem.eql(u8, self.pred_symbol, e.symbol())) {
            return false;
        }
        return e.value() >= self.pred_value;
    }
};

pub const LessThan = struct {
    pred_symbol: []const u8,
    pred_value: f64,

    pub fn new(pred_symbol: []const u8, pred_value: f64) LessThan {
        return LessThan{
            .pred_symbol = pred_symbol,
            .pred_value = pred_value,
        };
    }

    pub fn matches(self: *const LessThan, e: event.Event) bool {
        if (!std.mem.eql(u8, self.pred_symbol, e.symbol())) {
            return false;
        }
        return e.value() <= self.pred_value;
    }
};
