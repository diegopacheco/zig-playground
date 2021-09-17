pub const MATH_UTILS = struct {

    va: u64,    
    vb: u64,    
    const Self = @This();

    pub fn new(va:u64,vb:u64) Self {
        return .{ .va = va , .vb = vb };
    }

    pub fn sum(va:u64,vb:u64) u64 {
        return va+vb;
    }

    pub fn sub(va:u64,vb:u64) u64 {
        return va-vb;
    }

    pub fn mul(self:Self) u64 {
        return self.va * self.vb;
    }
    
};