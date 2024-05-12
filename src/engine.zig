// game engine
const std = @import("std");
const r = @cImport({
    @cInclude("raylib.h");
    @cInclude("raygui.h");
});

pub const App = struct {
    name: []const u8,

    pub fn init() App {
        return App{
            .name = "test",
        };
    }
    pub fn load(_: App) void {
        std.debug.print("init App!\n", .{});
        //std.debug.print("name: {}\n", .{self.name});
        //
    }
    pub fn update(self: App) void {
        std.debug.print("name: {}\n", .{self.name});
        //
    }
    //pub fn draw(_: App) void {
    pub fn draw(_: App) void {
        //std.debug.print("name: {}\n", .{self.name});
        //
        r.DrawText("Draw Test!", 0, 0, 20, r.LIGHTGRAY);
    }
};
