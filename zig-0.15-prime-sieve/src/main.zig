const std = @import("std");

pub fn main() void {
    const n: usize = 50;
    var sieve = [_]bool{true} ** (n + 1);
    sieve[0] = false;
    sieve[1] = false;
    var i: usize = 2;
    while (i * i <= n) : (i += 1) {
        if (sieve[i]) {
            var j: usize = i * i;
            while (j <= n) : (j += i) sieve[j] = false;
        }
    }
    std.debug.print("primes up to {d}:", .{n});
    for (sieve, 0..) |is_prime, k| {
        if (is_prime) std.debug.print(" {d}", .{k});
    }
    std.debug.print("\n", .{});
}
