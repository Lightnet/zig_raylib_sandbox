// https://www.openmymind.net/Performance-of-reading-a-file-line-by-line-in-Zig/
// https://stackoverflow.com/questions/68368122/how-to-read-a-file-in-zig
//
//
//
const std = @import("std");

pub fn main() !void {
    std.debug.print("FILE, {s}!\n", .{"World"});

    const file = try std.fs.cwd().openFile(
        "junk_file.txt",
        .{},
    );
    defer file.close();

    //const stat = try file.stat();
    //std.debug.print("stat: {any}\n", .{stat});
    // var buf_reader = std.io.bufferedReader(file.reader());
    // var in_stream = buf_reader.reader();

    // var buf: [1024]u8 = undefined;
    // while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
    //     // do something with line...
    //     //std.debug.print("line: {any}\n", .{line});
    //     std.debug.print("line: {s}\n", .{line});
    // }

    var buffer: [100]u8 = undefined;
    try file.seekTo(0);
    const bytes_read = try file.readAll(&buffer);
    std.debug.print("bytes_read: {any}\n", .{bytes_read});
}
