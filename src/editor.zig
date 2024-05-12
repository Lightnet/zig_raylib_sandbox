//
//
//
// https://zig.news/kristoff/dont-self-simple-structs-fj8
//
const std = @import("std");
const r = @cImport({
    @cInclude("raylib.h");
    @cInclude("raygui.h");
});

pub const Editor = struct {
    //const Self = @This();
    name: []const u8,
    mousePosition: r.Vector2,
    panOffset: r.Vector2,
    window_pos: r.Vector2,
    screenWidth: f32,
    dragWindow: bool,

    pub fn init() Editor {
        return Editor{
            .name = "editor",
            .mousePosition = r.Vector2{ .x = 0, .y = 0 },
            .panOffset = r.Vector2{ .x = 0, .y = 0 },
            .window_pos = r.Vector2{ .x = 0, .y = 0 },
            .screenWidth = 540,
            .dragWindow = false,
        };
    }

    pub fn load(_: Editor) void {
        //
    }

    pub fn update(self: *Editor) void {
        //
        self.mousePosition = r.GetMousePosition();
        if (r.IsMouseButtonPressed(r.MOUSE_LEFT_BUTTON) and !self.dragWindow) {
            std.debug.print("Hello, World!\n", .{});
            //react check if mouse pos in the area
            if (r.CheckCollisionPointRec(self.mousePosition, r.Rectangle{ .x = self.window_pos.x, .y = self.window_pos.y, .width = self.screenWidth, .height = 20 })) {
                self.dragWindow = true;
                self.panOffset = self.mousePosition;
                self.panOffset.x = self.panOffset.x - self.window_pos.x;
                self.panOffset.y = self.panOffset.y - self.window_pos.y;
            }
        }

        if (self.dragWindow) {
            if (r.IsMouseButtonReleased(r.MOUSE_LEFT_BUTTON)) self.dragWindow = false;
            const x = self.mousePosition.x - self.panOffset.x;
            const y = self.mousePosition.y - self.panOffset.y;
            self.window_pos = r.Vector2{ .x = x, .y = y };
        }
    }

    pub fn draw(self: Editor) void {
        //
        _ = r.GuiWindowBox(r.Rectangle{ .x = self.window_pos.x, .y = self.window_pos.y, .height = 200, .width = 200 }, "#198# PORTABLE WINDOW");
    }
};
