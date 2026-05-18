const std = @import("std");

const Perm = struct {
    const READ: u8 = 1 << 0;
    const WRITE: u8 = 1 << 1;
    const EXEC: u8 = 1 << 2;
};

fn render(mask: u8) void {
    const r: u8 = if (mask & Perm.READ != 0) 'r' else '-';
    const w: u8 = if (mask & Perm.WRITE != 0) 'w' else '-';
    const x: u8 = if (mask & Perm.EXEC != 0) 'x' else '-';
    std.debug.print("{c}{c}{c}\n", .{ r, w, x });
}

pub fn main() void {
    render(Perm.READ);
    render(Perm.READ | Perm.WRITE);
    render(Perm.READ | Perm.WRITE | Perm.EXEC);
    render(Perm.EXEC);
}
