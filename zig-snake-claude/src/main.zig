const std = @import("std");
const math = std.math;
const os = std.os;
const termios = os.linux.termios;

const screen_width = 80;
const screen_height = 24;
const tile_size = 1;
const board_width = screen_width / tile_size;
const board_height = screen_height / tile_size;

const vec = @import("vec.zig");

var snake = std.ArrayList(vec.Vec2).init(std.heap.page_allocator);
var food_pos: vec.Vec2 = undefined;
var game_over = false;
var direction = vec.Vec2{ .x = 1, .y = 0 };

var orig_termios: termios = undefined;
var termios_initialized = false;

fn initGame() void {
    snake.append(vec.Vec2{ .x = @as(f32, @floatFromInt(board_width / 2)), .y = @as(f32, @floatFromInt(board_height / 2)) }) catch unreachable;
    respawnFood();
}

fn respawnFood() void {
    var random = std.rand.DefaultPrng.init(blk: {
        var seed_data: u64 = undefined;
        std.os.getrandom(std.mem.asBytes(&seed_data)) catch unreachable;
        break :blk seed_data;
    });
    const prng = random.random();
    food_pos.x = prng.random.float(f32, 0, @as(f32, @floatFromInt(board_width - 1)));
    food_pos.y = prng.random.float(f32, 0, @as(f32, @floatFromInt(board_height - 1)));
}

fn updateGame() void {
    const head = snake.items[0];
    const new_head = vec.Vec2{ .x = head.x + direction.x, .y = head.y + direction.y };

    if (new_head.x < 0 or new_head.x >= @as(f32, @floatFromInt(board_width)) or
        new_head.y < 0 or new_head.y >= @as(f32, @floatFromInt(board_height)) or
        snake.items[1..].contains(new_head))
    {
        game_over = true;
        return;
    }

    snake.insertSlice(snake.items.len, 0, &.{new_head});

    if (math.approxEql(new_head.x, food_pos.x, 0.1) and math.approxEql(new_head.y, food_pos.y, 0.1)) {
        respawnFood();
    } else {
        _ = snake.pop();
    }
}

fn drawGame() void {
    os.termios.tc.flushinput();
    os.termios.tc.cursor_invisible = true;
    os.termios.tc.clear_screen();

    for (snake.items) |segment| {
        const x = @as(usize, @intFromFloat(segment.x));
        const y = @as(usize, @intFromFloat(segment.y));
        os.termios.tc.move_cursor(y, x);
        os.termios.tc.flush_unbuffered();
        os.write(1, "#") catch unreachable;
    }

    const food_x = @as(usize, @intFromFloat(food_pos.x));
    const food_y = @as(usize, @intFromFloat(food_pos.y));
    os.termios.tc.move_cursor(food_y, food_x);
    os.termios.tc.flush_unbuffered();
    os.write(1, "@") catch unreachable;
}

pub fn main() !void {
    if (!termios_initialized) {
        orig_termios = os.tcgetattr(0) catch {
            std.log.err("Failed to get terminal attributes", .{});
            return;
        };

        var new_termios = orig_termios;
        new_termios.lflag &= ~(@as(u32, 0x00000010) | @as(u32, 0x00000002) | @as(u32, 0x00000080));
        //if (try os.tcsetattr(0, .NOW, new_termios)) {
        //std.log.err("Failed to set terminal attributes", .{});
        //return;
        //}
        try os.tcsetattr(0, .NOW, new_termios);
        termios_initialized = true;
    }
    defer {
        if (termios_initialized) {
            os.tcsetattr(0, .NOW, orig_termios) catch unreachable;
        }
    }

    initGame();

    while (!game_over) {
        var buf: [1]u8 = undefined;
        const read_count = os.read(0, &buf) catch unreachable;
        if (read_count == 1) {
            switch (buf[0]) {
                'j' => direction = vec.Vec2{ .x = 0, .y = 1 },
                'k' => direction = vec.Vec2{ .x = 0, .y = -1 },
                'h' => direction = vec.Vec2{ .x = -1, .y = 0 },
                'l' => direction = vec.Vec2{ .x = 1, .y = 0 },
                else => {},
            }
        }

        drawGame();
        updateGame();
        std.time.sleep(200 * std.time.ns_per_ms);
    }
}
