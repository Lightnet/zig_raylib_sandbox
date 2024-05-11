const std = @import("std");

pub fn main() !void {
    std.debug.print("Hello, {s}!\n", .{"World"});

    const file = try std.fs.cwd().createFile(
        "junk_file.txt",
        .{ .read = true },
    );
    defer file.close();

    const bytes_written = try file.writeAll("Hello File!");
    _ = bytes_written;

    var buffer: [100]u8 = undefined;
    try file.seekTo(0);
    const bytes_read = try file.readAll(&buffer);

    std.debug.print("bytes_read: {any}\n", .{bytes_read});
}
