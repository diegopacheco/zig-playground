const std = @import("std");

fn fizzBuzz(writer: std.io.AnyWriter) !void {
    var i: usize = 1;
    while (i <= 100) : (i += 1) {
        if (i % 3 == 0 and i % 5 == 0) {
            try writer.print("fizzbuzz\n", .{});
        } else if (i % 3 == 0) {
            try writer.print("fizz\n", .{});
        } else if (i % 5 == 0) {
            try writer.print("buzz\n", .{});
        } else {
            try writer.print("{d}\n", .{i});
        }
    }
}

pub fn main() !void {
    const full_fizzbuzz = comptime init: {
        var cw = std.io.countingWriter(std.io.null_writer);
        fizzBuzz(cw.writer().any()) catch unreachable;

        var buffer: [cw.bytes_written]u8 = undefined;
        var fbs = std.io.fixedBufferStream(&buffer);
        fizzBuzz(fbs.writer().any()) catch unreachable;

        break :init buffer;
    };

    const out_writer = std.io.getStdOut().writer().any();
    try out_writer.writeAll(&full_fizzbuzz);
}

test "simple test fizzbuzz" {
    const full_fizzbuzz = comptime init: {
        var cw = std.io.countingWriter(std.io.null_writer);
        fizzBuzz(cw.writer().any()) catch unreachable;

        var buffer: [cw.bytes_written]u8 = undefined;
        var fbs = std.io.fixedBufferStream(&buffer);
        fizzBuzz(fbs.writer().any()) catch unreachable;

        break :init buffer;
    };

    // Compare slices instead of forcing pointer addresses:
    try std.testing.expectEqualStrings(full_fizzbuzz[0..], "1\n2\nfizz\n4\nbuzz\nfizz\n7\n8\nfizz\nbuzz\n11\nfizz\n13\n14\nfizzbuzz\n16\n17\nfizz\n19\nbuzz\nfizz\n22\n23\nfizz\nbuzz\n26\nfizz\n28\n29\nfizzbuzz\n31\n32\nfizz\n34\nbuzz\nfizz\n37\n38\nfizz\nbuzz\n41\nfizz\n43\n44\nfizzbuzz\n46\n47\nfizz\n49\nbuzz\nfizz\n52\n53\nfizz\nbuzz\n56\nfizz\n58\n59\nfizzbuzz\n61\n62\nfizz\n64\nbuzz\nfizz\n67\n68\nfizz\nbuzz\n71\nfizz\n73\n74\nfizzbuzz\n76\n77\nfizz\n79\nbuzz\nfizz\n82\n83\nfizz\nbuzz\n86\nfizz\n88\n89\nfizzbuzz\n91\n92\nfizz\n94\nbuzz\nfizz\n97\n98\nfizz\nbuzz\n");
}
