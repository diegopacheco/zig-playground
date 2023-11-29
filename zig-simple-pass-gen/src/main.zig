const std = @import("std");
const allocator = std.heap.page_allocator;
const RndGen = std.rand.DefaultPrng;

const charset: [62]u8 = [_]u8{ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();

    std.debug.print("Enter username: ", .{});
    var usernameResult = try stdin.readUntilDelimiterOrEofAlloc(allocator, '\n', 512);
    var username = usernameResult.?;
    defer allocator.free(username);

    std.debug.print("Enter domain: ", .{});
    var domainResult = try stdin.readUntilDelimiterOrEofAlloc(allocator, '\n', 512);
    var domain = domainResult.?;
    defer allocator.free(domain);

    var homeDir = std.os.getenv("HOME").?;
    var confDir = ".config";
    var confFile = "zpass.conf";

    // Allocate memory for the dynamic string
    const fullPath = try std.fmt.allocPrint(allocator, "{s}/{s}/{s}", .{ homeDir, confDir, confFile });
    defer allocator.free(fullPath);

    // Generate random seed by picking randombyte from memory
    var seed: u64 = undefined;
    std.os.getrandom(std.mem.asBytes(&seed)) catch unreachable;
    var rnd = RndGen.init(seed);

    // Generate Password
    var password: [10]u8 = undefined;
    for (&password) |*char| {
        var some_random_num = rnd.random().intRangeLessThan(usize, 0, charset.len);
        char.* = charset[some_random_num];
    }
    std.debug.print("Password: {s}\n", .{password});

    // Open file to write username, domain and password
    const openFlags = std.fs.File.OpenFlags{ .mode = std.fs.File.OpenMode.read_write };
    var file = try std.fs.openFileAbsolute(fullPath, openFlags);
    defer file.close();

    // seeking file position so that to append at beginning
    try file.seekTo(0);

    var fullText = try std.fmt.allocPrint(allocator, "Username: {s}, Domain: {s}, Password: {s}", .{ username, domain, password });
    defer allocator.free(fullText);
    _ = try file.writeAll(fullText[0..]);

    // Adding new line char at end
    const newline = [_]u8{'\n'};
    _ = try file.write(newline[0..]);
}
