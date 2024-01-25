const std = @import("std");
const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addSharedLibrary(.{
        .name = "mathtest",
        .target = target,
        .optimize = optimize,
        .root_source_file = .{
            .path = "./mathtest.zig",
        },
    });

    const exe = b.addExecutable(.{
        .name = "test",
        //.root_source_file = .{ .path = "test.c" },
        .target = target,
        .optimize = optimize,
    });

    exe.addCSourceFile(.{
        .file = .{
            .path = "./test.c",
        },
        .flags = &[_][]const u8{"-std=c99"},
    });
    exe.linkLibrary(lib);
    exe.linkSystemLibrary("c");

    b.default_step.dependOn(&exe.step);
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const test_step = b.step("test", "Test the program");
    test_step.dependOn(&run_cmd.step);
}
