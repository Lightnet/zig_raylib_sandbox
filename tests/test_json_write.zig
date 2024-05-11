// https://github.com/berdon/zig-json
// https://www.huy.rocks/everyday/01-09-2022-zig-json-in-5-minutes
//
//
//
//

const std = @import("std");

const Place = struct { lat: f32, long: f32 };

pub fn main() !void {
    std.debug.print("FILE, {s}!\n", .{"World"});

    const x = Place{
        .lat = 51.997664,
        .long = -0.740687,
    };

    var buf: [100]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);
    var string = std.ArrayList(u8).init(fba.allocator());
    try std.json.stringify(x, .{}, string.writer());
}
