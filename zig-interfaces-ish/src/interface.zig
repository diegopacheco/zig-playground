const std = @import("std");

pub const Interface = struct {
    ptr: *const anyopaque,
    draw_fn: fn (ptr: *const anyopaque) void,

    pub fn init(ptr: anytype) Interface {
        const Ptr = @TypeOf(ptr);
        const PtrInfo = @typeInfo(Ptr);

        if (PtrInfo != .Pointer) @compileError("ptr must be a pointer");

        // For struct types, we just trust that they implement the method
        // since we can't reliably check at compile time without reflection
        const Child = PtrInfo.Pointer.child;

        return Interface{
            .ptr = ptr,
            .draw_fn = Child.drawOpaque,
        };
    }

    pub fn concreteFn(self: Interface) void {
        self.draw_fn(self.ptr);
    }
};
