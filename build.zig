// https://github.com/ziglang/zig/issues/19423
// https://github.com/ziglang/zig/issues/17302#issuecomment-1737417445
// https://ziggit.dev/t/include-paths-build-paths-of-a-dependency-from-a-url/3263
//
// zig build run
// will compile build and run application
const std = @import("std");
const raylibSDK = @import("raylib");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    // const strip = b.option(
    //     bool,
    //     "strip",
    //     "Strip debug info to reduce binary size, defaults to false",
    // ) orelse false;
    // const strip_flags = if (strip) .{
    //     "-O3",
    // } else .{
    //     "-O3",
    //     //"-fno-sanitize=undefined", "-O3",
    //     //"-g",
    // };
    //LIB
    // const lib = b.addStaticLibrary(.{
    //     .name = "lightnet-raylib",
    //     .root_source_file = b.path("src/root.zig"),
    //     .target = target,
    //     .optimize = optimize,
    // });
    // b.installArtifact(lib);

    const exe = b.addExecutable(.{
        .name = "raylib_app",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    //RAYGUI
    // FROM build.zig.zon
    // .dependencies = .{
    // //...
    // .raygui = .{
    // .url = "https://github.com/raysan5/raygui/archive/12804826d01bfb636e36f816bda19eaa23b4ace7.tar.gz",
    // .hash = "12201907b4e593271e6a6c3ba91ee298a6e98393c44404915df022fa0764aa224c7e",
    // },
    //
    const raygui_dep = b.dependency("raygui", .{
        .target = target,
        .optimize = optimize,
    });
    // include file from raygui cache dir project root > src
    exe.addIncludePath(raygui_dep.path("src"));
    // project root > lib folder create > raygui github
    //exe.addIncludePath(.{ .path = "lib/raygui/src" }); //works
    exe.addCSourceFiles(.{ // for loading raygui.h file raygui_impl.c
        .files = &[_][]const u8{"src/c/raygui_impl.c"},
        .flags = &[_][]const u8{ "-g", "-O3" },
    });

    //RAYLIB
    const raylib_dep = try raylibSDK.addRaylib(b, target, optimize, .{
        .raudio = true,
        .rmodels = true,
        .rshapes = true,
        .rtext = true,
        .rtextures = true,
        //.raygui = true, // does not work atm
        .platform_drm = false,
    });
    //exe.addIncludePath(.{ .path = "raylib/src" });
    exe.linkLibrary(raylib_dep);
    //APP EXE
    b.installArtifact(exe);
    //RUN APP CMD
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    // //TEST
    // const lib_unit_tests = b.addTest(.{
    //     .root_source_file = b.path("src/root.zig"),
    //     .target = target,
    //     .optimize = optimize,
    // });
    // //TEST
    // const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);
    // const exe_unit_tests = b.addTest(.{
    //     .root_source_file = b.path("src/main.zig"),
    //     .target = target,
    //     .optimize = optimize,
    // });
    // //TEST
    // const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);
    // const test_step = b.step("test", "Run unit tests");
    // test_step.dependOn(&run_lib_unit_tests.step);
    // test_step.dependOn(&run_exe_unit_tests.step);
}
