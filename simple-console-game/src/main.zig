const std = @import("std");

pub fn main() !void {
    var computer_choice:i32 = try generateRandonNum();

    std.debug.print("Guess a number: !\n",.{});
    std.debug.print("Rock, paper, scissors!\n",.{});
    std.debug.print("1. Rock\n2. Paper\n3. Scissors\n",.{});
    std.debug.print("Enter your choice: ",.{});
    
    while(true){
        const player_choice:i32 = try ask_user();
        if (player_choice == computer_choice){
            std.debug.print("You win!\n",.{});
            break;
        }else{
            std.debug.print("You lose! Try again... ",.{});
        }
    }
}

fn generateRandonNum() !i32 {
    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.os.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();
    const result = rand.intRangeAtMost(i32, 1, 3);   
    return @as(i32, result);
}

fn ask_user() !i32 {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var buf: [10]u8 = undefined;
    try stdout.print("A number please: ", .{});

    if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |user_input| {
        return std.fmt.parseInt(i32, user_input, 10);
    } else {
        return @as(i32, 0);
    }
}