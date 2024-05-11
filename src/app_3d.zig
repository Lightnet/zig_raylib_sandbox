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

    while (!r.WindowShouldClose()) {
        r.BeginDrawing();
        r.ClearBackground(r.RAYWHITE);

        r.DrawText("Hello, World! 3D!", 190, 200, 20, r.LIGHTGRAY);
        r.EndDrawing();
    }
}
