//
// Testing UI Editor
// Keep it simple.
// https://github.com/raysan5/raygui/blob/master/examples/portable_window/portable_window.c
//
//
//

const std = @import("std");
const r = @cImport({
    @cInclude("raylib.h");
    @cInclude("raygui.h");
});

const game = @import("game.zig");

fn test_update() void {
    //
}

pub fn main() !void {
    const screenWidth = 960;
    const screenHeight = 540;
    r.InitWindow(screenWidth, screenHeight, "App Editor");
    r.SetTargetFPS(60);

    defer r.CloseWindow();

    var dragWindow = false;
    //comptime var exitWindow = 0;
    var mousePosition = r.Vector2{ .x = 0, .y = 0 };
    var panOffset = mousePosition;
    //var windowPosition = .{ .x = 0, .y = 0 };

    var window_pos = r.Vector2{ .x = 0, .y = 0 };

    while (!r.WindowShouldClose()) {
        // UPDATE
        mousePosition = r.GetMousePosition();

        if (r.IsMouseButtonPressed(r.MOUSE_LEFT_BUTTON) and !dragWindow) {
            std.debug.print("Hello, World!\n", .{});
            if (r.CheckCollisionPointRec(mousePosition, r.Rectangle{ .x = window_pos.x, .y = window_pos.y, .width = screenWidth, .height = 20 })) {
                dragWindow = true;
                panOffset = mousePosition;
                panOffset.x = panOffset.x - window_pos.x;
                panOffset.y = panOffset.y - window_pos.y;
            }
        }
        var x = window_pos.x;
        var y = window_pos.y;
        if (dragWindow) {
            if (r.IsMouseButtonReleased(r.MOUSE_LEFT_BUTTON)) dragWindow = false;
            x = mousePosition.x - panOffset.x;
            y = mousePosition.y - panOffset.y;
            window_pos = r.Vector2{ .x = x, .y = y };
        }

        //RENDER
        r.BeginDrawing();
        defer r.EndDrawing();
        r.ClearBackground(r.RAYWHITE);

        r.DrawText("Editor!", 190, 200, 20, r.BLUE);

        //_ = r.GuiWindowBox(r.Rectangle{ .x = 0, .y = 0, .height = 200, .width = 200 }, "#198# PORTABLE WINDOW");
        // const x = mousePosition.x + panOffset.x;
        // const y = mousePosition.y + panOffset.y;
        _ = r.GuiWindowBox(r.Rectangle{ .x = x, .y = y, .height = 200, .width = 200 }, "#198# PORTABLE WINDOW");

        r.DrawText(r.TextFormat("Mouse Position: [ %.0f, %.0f ]", mousePosition.x, mousePosition.y), 10, 40, 10, r.DARKGRAY);

        test_update();
    }
}
