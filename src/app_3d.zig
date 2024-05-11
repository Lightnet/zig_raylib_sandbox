// https://gist.github.com/leroycep/ac3e7089f3540895c8d5998bdfbf2a7f ref
// https://github.com/Durobot/raylib-zig-examples/blob/main/zig-raylib-11-core-3d-camera-mode/main.zig working...
const std = @import("std");
const r = @cImport({
    @cInclude("raylib.h");
    @cInclude("raygui.h");
});

const game = @import("game.zig");

pub fn main() !void {
    r.InitWindow(960, 540, "App 2D");
    r.SetTargetFPS(60);

    defer r.CloseWindow();

    // var camera = r.Camera{
    //     //.type = r.CAMERA_PERSPECTIVE,
    // };

    // camera.position = r.Vector3{ .x = 0.0, .y = 10.0, .z = 10.0 };
    // camera.target = r.Vector3{ .x = 0.0, .y = 0.0, .z = 0.0 };
    // camera.fovy = 60.0;

    // Define the camera to look into our 3d world
    const camera = r.Camera3D{
        .position = .{ .x = 0.0, .y = 10.0, .z = 10.0 }, // Camera position
        .target = .{ .x = 0.0, .y = 0.0, .z = 0.0 }, // Camera looking at point
        .up = .{ .x = 0.0, .y = 1.0, .z = 0.0 }, // Camera up vector (rotation towards target)
        .fovy = 45.0, // Camera field-of-view Y
        .projection = r.CAMERA_PERSPECTIVE, // Camera mode type
    };

    const pos = r.Vector3{ .x = 0.0, .y = 0.0, .z = 0.0 };

    while (!r.WindowShouldClose()) {
        r.BeginDrawing();
        defer r.EndDrawing();
        r.ClearBackground(r.RAYWHITE);

        r.BeginMode3D(camera);
        defer r.EndMode3D();
        // 3D
        //r.DrawPlane(r.Vector3{ .x = 0.0, .y = 0.0, .z = 0.0 }, r.Vector2{ .x = 32.0, .y = 32.0 }, r.LIGHTGRAY);
        r.DrawCube(pos, 1.0, 1.0, 1.0, r.RED);
        r.DrawGrid(10, 1.0);
        // 3D

        r.DrawFPS(10, 10);

        r.DrawText("Hello, World! 3D!", 190, 200, 20, r.LIGHTGRAY);
    }
}
