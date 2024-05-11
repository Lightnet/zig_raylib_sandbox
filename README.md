# zig_raylib_sandbox

# License: MIT

# Lib:
 - raylib 5.0 master f62202198e35161a9fe394a14bbd1a7c655107ad
 - raygui 4.0 master 12804826d01bfb636e36f816bda19eaa23b4ace7
 - zig 0.12.0

# OS:
 * Windows 10 [Tested]
 * Linux [N/A]
 * Mac [N/A]

# Information:
  Work in progress build sandbox testing. Simple raylib and raygui test build.

  The package manager is work in progress from Zig language Dev. Since the release of 0.11.0 This project use zig dependencies download to run application. By using the dependencies to handle build.zig script for easy compile and run application.

  The Zig language will be subject to change in API. Which will break the build config. Since it not release to 1.0.0.

# TO DO LIST:
 * UI Editor
 * Save and Load data
 * ECS
 * World
 * Scene
 * Physics

# Design:
 Work in progress.

 Note his idea base on Wicked Engine way to save assets to create prefab entity. Just like Godot Engine format.



# raylib:
```zig
const r = @cImport({
    @cInclude("raylib.h");
    @cInclude("raygui.h");
});
//...
r.InitWindow(960, 540, "My Window Name");
```
  Note it still use access but with name space. Check out on cheatsheet for more information from raylib site.

# raygui:
  Note that Zig language use name space for easy access for C language. As well same with the raylab as they group together.

```zig
const r = @cImport({
    @cInclude("raylib.h");
    @cInclude("raygui.h");
});

//...
r.InitWindow(960, 540, "My Window Name");
//...
```
  It can be found in https://github.com/raysan5/raygui/blob/master/src/raygui.h

```zig
if (r.GuiButton(r.Rectangle{ .x = 20, .y = 100, .height = 16, .width = 100 }, "Print!") == 1) {
    std.debug.print("Hello World!\n", .{});
}
```
  Note button return is int and not bool.

  Note one file is add to handle raygui.h file for load correctly that is raygui_impl.c.


# Zig:
```
zig build
```
  If nothing happen, it pass build.

```
zig build run
```

Window, text and gui checkbox test.

# Engine or Framework? :
  https://stackoverflow.com/questions/5068992/whats-the-difference-between-an-engine-and-a-framework#:~:text=Frameworks%20provide%20a%20relatively%20static,a%20specific%20type%20of%20work.

# Links Refs:
- https://github.com/ziglang/zig/issues/17302#issuecomment-1737417445
- https://ktj.st/posts/using-a-single-header-c-library-in-zig/
- https://github.com/lhk/raylib_zig_build_setup
- https://github.com/Angluca/raylib-zig-template
- https://ziggit.dev/t/zig-0-12-build-with-raylib-dependency-has-path-error/4058/6
- https://www.reddit.com/r/Zig/comments/16r0fj6/ysk_you_can_use_native_raylib_directly_in_zig_for/
- https://zig.news/perky/hot-reloading-with-raylib-4bf9
- https://github.com/lhk/raylib_zig_build_setup/blob/main/build.zig
- https://github.com/ziglang/zig/issues/19423
- https://github.com/ziglang/zig/issues/17302#issuecomment-1737417445
- 
- 