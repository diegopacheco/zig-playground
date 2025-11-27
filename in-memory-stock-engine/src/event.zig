const std = @import("std");

pub const Event = struct {
    ptr: *const anyopaque,
    vtable: *const VTable,

    const VTable = struct {
        symbol: *const fn (ptr: *const anyopaque) []const u8,
        value: *const fn (ptr: *const anyopaque) f64,
    };

    pub fn symbol(self: Event) []const u8 {
        return self.vtable.symbol(self.ptr);
    }

    pub fn value(self: Event) f64 {
        return self.vtable.value(self.ptr);
    }

    pub fn init(pointer: anytype) Event {
        const Ptr = @TypeOf(pointer);

        const gen = struct {
            fn symbolImpl(ptr: *const anyopaque) []const u8 {
                const self: Ptr = @alignCast(@ptrCast(@constCast(ptr)));
                return self.symbol();
            }

            fn valueImpl(ptr: *const anyopaque) f64 {
                const self: Ptr = @alignCast(@ptrCast(@constCast(ptr)));
                return self.value();
            }

            const vtable = VTable{
                .symbol = symbolImpl,
                .value = valueImpl,
            };
        };

        return .{
            .ptr = pointer,
            .vtable = &gen.vtable,
        };
    }
};

pub const StockUp = struct {
    stock_value: f64,
    stock_symbol: []const u8,

    pub fn new(stock_symbol: []const u8, stock_value: f64) StockUp {
        return StockUp{
            .stock_value = stock_value,
            .stock_symbol = stock_symbol,
        };
    }

    pub fn symbol(self: *const StockUp) []const u8 {
        return self.stock_symbol;
    }

    pub fn value(self: *const StockUp) f64 {
        return self.stock_value;
    }
};

pub const StockDown = struct {
    stock_value: f64,
    stock_symbol: []const u8,

    pub fn new(stock_symbol: []const u8, stock_value: f64) StockDown {
        return StockDown{
            .stock_value = stock_value,
            .stock_symbol = stock_symbol,
        };
    }

    pub fn symbol(self: *const StockDown) []const u8 {
        return self.stock_symbol;
    }

    pub fn value(self: *const StockDown) f64 {
        return self.stock_value;
    }
};
