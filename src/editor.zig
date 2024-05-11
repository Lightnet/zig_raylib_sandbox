//
//
//

const std = @import("std");

pub const Editor = struct{
  
  name: []const u8,

  pub fn init() Editor {
    return Editor{
        .name = "editor",
    };
  }


}
