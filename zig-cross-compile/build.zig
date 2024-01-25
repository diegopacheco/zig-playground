const std = @import("std");
const Builder = @import("std").build.Builder;

const targets = [_]std.zig.CrossTarget{
    .{ .cpu_arch = .x86_64, .os_tag = .linux },
    .{ .cpu_arch = .x86_64, .os_tag = .windows },
    //.{ .cpu_arch = .aarch64, .os_tag = .macos },
};

pub fn build(b: *Builder) void {
    //const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "test",
        //.root_source_file = .{ .path = "test.c" },
        //.target = t,
        //.optimize = optimize,
    });

    exe.addCSourceFile(.{
        .file = .{
            .path = "./test.c",
        },
        .flags = &[_][]const u8{"-std=c99"},
    });
    exe.linkSystemLibrary("c");

    for (targets) |t| {
        const lib = b.addSharedLibrary(.{
            .name = "mathtest",
            .target = t,
            .optimize = optimize,
            .root_source_file = .{
                .path = "./mathtest.zig",
            },
        });
        exe.linkLibrary(lib);
    }

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
