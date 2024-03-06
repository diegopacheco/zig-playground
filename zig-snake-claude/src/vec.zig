const std = @import("std");
const Random = std.rand.Random;
const meta = std.meta;
const math = std.math;

/// Random value in [0, 1)
inline fn randomNum(comptime T: type, rand: *Random) T {
    return switch (@typeInfo(T)) {
        .Float, .ComptimeFloat => rand.float(T),
        .Int, .ComptimeInt => @compileError("Same as VecT.zero."),
        else => unreachable,
    };
}

/// Random value in [at_least, less_than)
inline fn randomNumRange(comptime T: type, rand: *Random, at_least: T, less_than: T) T {
    return switch (@typeInfo(T)) {
        .Int, .ComptimeInt => rand.intRangeLessThan(T, at_least, less_than),
        .Float, .ComptimeFloat => rand.float(T) * (less_than - at_least) + at_least,
        else => unreachable,
    };
}

/// Various vector operations, generic of vector type and size.
fn VectorOperations(comptime VecT: type) type {
    const ScalarT = VecT.Child;
    if (!meta.trait.isNumber(ScalarT)) @compileError("Expect number as vector child type.");

    const fields = @typeInfo(VecT).Struct.fields;
    return struct {
        /// Init each component with random values in [0, 1).
        pub inline fn random(rand: *Random) VecT {
            var result: VecT = undefined;
            inline for (fields) |f| {
                @field(result, f.name) = randomNum(ScalarT, rand);
            }
            return result;
        }

        /// Init each component with random values in [at_least, less_than).
        pub inline fn randomRange(rand: *Random, at_least: ScalarT, less_than: ScalarT) VecT {
            var result: VecT = undefined;
            inline for (fields) |f| {
                @field(result, f.name) = randomNumRange(ScalarT, rand, at_least, less_than);
            }
            return result;
        }

        /// Access an element of a vector by index.
        /// x = 0, y = 1, z = 2, w = 3
        pub inline fn index(self: VecT, idx: usize) ScalarT {
            inline for (fields, 0..) |_, i| {
                if (idx == i) return @field(self, fields[i].name);
            }
            unreachable;
        }

        /// Negate the vector.
        pub inline fn negate(self: VecT) VecT {
            var result: VecT = undefined;
            inline for (fields) |f| {
                @field(result, f.name) = -@field(self, f.name);
            }
            return result;
        }

        /// Length/magnitude of the vector.
        pub inline fn mag(self: VecT) ScalarT {
            return math.sqrt(self.magSqr());
        }

        /// Squared length/magnitude of the vector.
        pub inline fn magSqr(self: VecT) ScalarT {
            var result: ScalarT = 0;
            inline for (fields) |f|
                result += @field(self, f.name) * @field(self, f.name);
            return result;
        }

        /// Dot product of two vectors.
        pub inline fn dot(self: VecT, b: VecT) ScalarT {
            var result: ScalarT = 0;
            inline for (fields) |f| {
                result += @field(self, f.name) * @field(b, f.name);
            }
            return result;
        }

        /// Normalize the vector.
        /// vec.mag() == 1
        pub inline fn unitVec(self: VecT) VecT {
            return self.div(self.mag());
        }

        /// Convert a float vector to an int vector.
        pub inline fn toInt(self: VecT, comptime IntT: type) Vec(VecT.Size, IntT) {
            const ResultT = Vec(VecT.Size, IntT);
            var result: ResultT = undefined;
            inline for (fields) |f| {
                @field(result, f.name) = @as(IntT, @intFromFloat(@field(self, f.name)));
            }
            return result;
        }

        /// Convert a int vector to a float vector.
        pub inline fn toFloat(self: VecT, comptime FloatT: type) Vec(VecT.Size, FloatT) {
            const ResultT = Vec(VecT.Size, FloatT);
            var result: ResultT = undefined;
            inline for (fields) |f| {
                @field(result, f.name) = @as(FloatT, @floatFromInt(@field(self, f.name)));
            }
            return result;
        }

        // Add the function definition in doc comment as intellisense is lacking
        // Probably will never be able to parse alias->closure

        /// ```
        /// a.add(b: Vec | Scalar) Vec
        /// ```
        /// Add a vector or offset by scalar.
        /// Equiv. to: const c = a + b;
        pub const add = compWiseOp(addOp, false);
        /// ```
        /// a.sub(b: Vec | Scalar) Vec
        /// ```
        /// Subtract a vector or offset by scalar.
        /// Equiv. to: const c = a - b;
        pub const sub = compWiseOp(subOp, false);
        /// ```
        /// a.mul(b: Vec | Scalar) Vec
        /// ```
        /// Multiply by vector or multiply scale by scalar.
        /// Hadamard product.
        /// Equiv. to: const c = a * b;
        pub const mul = compWiseOp(mulOp, false);
        /// ```
        /// a.div(b: Vec | Scalar) Vec
        /// ```
        /// Divide by vector or divide scale by scalar.
        /// Hadamard division.
        /// Equiv. to: const c = a / b;
        pub const div = compWiseOp(divOp, false);

        /// ```
        /// a.addEql(b: Vec | Scalar) void
        /// ```
        /// Add a vector or offset by scalar, in place.
        /// Equiv. to: a += b
        pub const addEql = compWiseOp(addOp, true);
        /// ```
        /// a.subEql(b: Vec | Scalar) void
        /// ```
        /// Subtract a vector or offset by scalar, in place.
        /// Equiv. to: a -= b
        pub const subEql = compWiseOp(subOp, true);
        /// ```
        /// a.mulEql(b: Vec | Scalar) void
        /// ```
        /// Multiply by vector or multiply/scale by scalar, in place.
        /// Hadamard product.
        /// Equiv. to: a *= b
        pub const mulEql = compWiseOp(mulOp, true);
        /// ```
        /// a.divEql(b: Vec | Scalar) void
        /// ```
        /// Divide by vector or divide/scale by scalar, in place.
        /// Hadamard division.
        /// Equiv. to: a /= b
        pub const divEql = compWiseOp(divOp, true);

        /// ```
        /// a.equalTo(b: Vec | Scalar) bool
        /// ```
        /// Vector is equal to a vector or a scalar, component wise.
        /// Equiv. to: a == b
        pub const equalTo = compWiseCmp(eqlCmp);
        /// ```
        /// a.lessThan(b: Vec | Scalar) bool
        /// ```
        /// Vector is less than a vector or a scalar, component wise.
        /// Equiv. to: a < b
        pub const lessThan = compWiseCmp(lessCmp);
        /// ```
        /// a.gterThan(b: Vec | Scalar) bool
        /// ```
        /// Vector is greater than a vector or a scalar, component wise.
        /// Equiv. to: a > b
        pub const gterThan = compWiseCmp(gtrCmp);
        /// ```
        /// a.lessEqual(b: Vec | Scalar) bool
        /// ```
        /// Vector is less than or equal to a vector or a scalar, component wise.
        /// Equiv. to: a <= b
        pub const lessEqual = compWiseCmp(lessEqlCmp);
        /// ```
        /// a.gterEqual(b: Vec | Scalar) bool
        /// ```
        /// Vector is greater than or equal to a vector or a scalar, component wise.
        /// Equiv. to: a >= b
        pub const gterEqual = compWiseCmp(gtrEqlCmp);

        /// The format string will carry over to printing the components of the vector.
        pub fn format(value: VecT, comptime fmt: []const u8, writer: anytype) !void {
            try writer.writeAll("(");
            inline for (fields, 0..) |f, i| {
                // Apply the format string to the scalar types within the vector
                try writer.print("{" ++ fmt ++ "}", .{@field(value, f.name)});
                // No trailing comma
                if (i + 1 < fields.len) try writer.writeAll(", ");
            }
            try writer.writeAll(")");
        }

        // Op functions since no first class operators
        // Probably could be replaced with a switch in compWiseOp()
        inline fn addOp(a: ScalarT, b: ScalarT) ScalarT {
            return a + b;
        }
        inline fn subOp(a: ScalarT, b: ScalarT) ScalarT {
            return a - b;
        }
        inline fn mulOp(a: ScalarT, b: ScalarT) ScalarT {
            return a * b;
        }
        inline fn divOp(a: ScalarT, b: ScalarT) ScalarT {
            return switch (@typeInfo(ScalarT)) {
                // Don't know which integer division to use.
                .Int => @divTrunc(a, b),
                else => a / b,
            };
        }

        // My hope is that after all this is done, itll be inlined as a simple Vec3{.x = a + b...}, but who knows...
        /// Apply component wise operation to two, varying size, vectors
        /// or a vector and a scalar.
        fn compWiseOp(op: fn (a: ScalarT, b: ScalarT) ScalarT, comptime in_place: bool) fn (a: if (in_place) *VecT else VecT, b: anytype) if (in_place) void else VecT {
            const ReturnT = if (in_place) void else VecT;
            const ResultT = if (in_place) *VecT else VecT;

            const Closure = struct {
                pub inline fn applyOp(a: ResultT, b: anytype) ReturnT {
                    const B = @TypeOf(b);
                    var result: ResultT = if (in_place) a else undefined;

                    inline for (fields) |f| {
                        if (@typeInfo(B) == .Struct) {
                            // This allows one to e.g., add a vec3 with a vec2, no field means no change.
                            // But, there is basically no type checking
                            // Adding any struct here, without matching field names, would just do nothing
                            // Possible solution:
                            if (!@hasField(B, "x") or !@hasField(B, "y")) @compileError("Struct type rhs is not a vector.");

                            @field(result, f.name) = op(@field(a, f.name), @as(ScalarT, if (@hasField(B, f.name)) @field(b, f.name) else 0));
                        } else @field(result, f.name) = op(@field(a, f.name), @as(ScalarT, b));
                    }

                    if (!in_place) return result;
                }
            };
            return Closure.applyOp;
        }

        inline fn eqlCmp(a: ScalarT, b: ScalarT) bool {
            return a == b;
        }
        inline fn gtrCmp(a: ScalarT, b: ScalarT) bool {
            return a > b;
        }
        inline fn lessCmp(a: ScalarT, b: ScalarT) bool {
            return a < b;
        }
        inline fn gtrEqlCmp(a: ScalarT, b: ScalarT) bool {
            return a >= b;
        }
        inline fn lessEqlCmp(a: ScalarT, b: ScalarT) bool {
            return a <= b;
        }

        /// Compare two vectors or a vector and a scalar component wise.
        fn compWiseCmp(cmp: fn (a: ScalarT, b: ScalarT) bool) fn (a: VecT, b: anytype) bool {
            const Closure = struct {
                pub inline fn applyCmp(a: VecT, b: anytype) bool {
                    const B = @TypeOf(b);
                    inline for (fields) |f| {
                        if (@typeInfo(B) == .Struct) {
                            if (!cmp(@field(a, f.name), @as(ScalarT, @field(b, f.name))))
                                return false;
                        } else if (!cmp(@field(a, f.name), @as(ScalarT, b)))
                            return false;
                    }

                    return true;
                }
            };
            return Closure.applyCmp;
        }
    };
}

/// Vector2(double)
pub const V2d = Vec2(f64);
/// Vector2(float)
pub const V2f = Vec2(f32);
/// Vector2(long)
pub const V2l = Vec2(i64);
/// Vector2(int)
pub const V2i = Vec2(i32);

pub fn Vec2(comptime ScalarT: type) type {
    return extern struct {
        const Self = @This();
        pub const Size = 2;
        pub const Child = ScalarT;
        usingnamespace VectorOperations(Self);

        x: ScalarT,
        y: ScalarT,

        // Init with x and y components
        pub inline fn init(x: ScalarT, y: ScalarT) Self {
            return Self{ .x = x, .y = y };
        }

        // Cross product of two Vec2s
        pub inline fn cross(self: Self, b: Self) ScalarT {
            return self.x * b.y + self.y * b.x;
        }

        pub const zero = Self.init(0, 0);
        pub const one = Self.init(1, 1);
        pub const up = Self.init(0, 1);
        pub const down = Self.init(0, -1);
        pub const right = Self.init(1, 0);
        pub const left = Self.init(-1, 0);
    };
}

/// Vector3(double)
pub const V3d = Vec3(f64);
/// Vector3(float)
pub const V3f = Vec3(f32);
/// Vector3(long)
pub const V3l = Vec3(i64);
/// Vector3(int)
pub const V3i = Vec3(i32);

pub fn Vec3(comptime ScalarT: type) type {
    return extern struct {
        const Self = @This();
        pub const Size = 3;
        pub const Child = ScalarT;
        usingnamespace VectorOperations(Self);

        x: ScalarT,
        y: ScalarT,
        z: ScalarT,

        /// Init with x, y, and z components.
        pub inline fn init(x: ScalarT, y: ScalarT, z: ScalarT) Self {
            return .{ .x = x, .y = y, .z = z };
        }

        /// Init with a Vec2, z will be zero.
        pub inline fn initV2(vec2: Vec2(ScalarT)) Self {
            return .{ .x = vec2.x, .y = vec2.y, .z = 0 };
        }

        /// Cross product of two Vec3s
        pub inline fn cross(self: Self, b: Self) Self {
            return .{
                .x = self.y * b.z - self.z * b.y,
                .y = self.z * b.x - self.x * b.z,
                .z = self.x * b.y - self.y * b.x,
            };
        }

        pub const zero = Self.init(0, 0, 0);
        pub const one = Self.init(1, 1, 1);
        pub const up = Self.init(0, 1, 0);
        pub const down = Self.init(0, -1, 0);
        pub const foward = Self.init(0, 0, 1);
        pub const backward = Self.init(0, 0, -1);
        pub const right = Self.init(1, 0, 0);
        pub const left = Self.init(-1, 0, 0);
    };
}

/// Vector4(double)
pub const V4d = Vec4(f64);
/// Vector4(float)
pub const V4f = Vec4(f32);
/// Vector4(long)
pub const V4l = Vec4(i64);
/// Vector4(int)
pub const V4i = Vec4(i32);

pub fn Vec4(comptime ScalarT: type) type {
    return extern struct {
        const Self = @This();
        pub const Size = 4;
        pub const Child = ScalarT;
        usingnamespace VectorOperations(Self);

        x: ScalarT,
        y: ScalarT,
        z: ScalarT,
        w: ScalarT,

        /// Init with x, y, z and w components
        pub inline fn init(x: ScalarT, y: ScalarT, z: ScalarT, w: ScalarT) Self {
            return Self{ .x = x, .y = y, .z = z, .w = w };
        }

        /// Init with a Vec2, z and w will be zero.
        pub inline fn initV2(vec2: Vec2(ScalarT)) Self {
            return Self{ .x = vec2.x, .y = vec2.y, .z = 0, .w = 0 };
        }

        /// Init with a Vec3, w will be zero.
        //pub inline fn initV3(vec3, Vec3(ScalarT)) Self {
        //return Self{ .x = vec3.x, .y = vec3.y, .z = vec3.z, .w = 0 };
        //}

        pub const zero = Self.init(0, 0, 0, 0);
        pub const one = Self.init(1, 1, 1, 1);
        pub const up = Self.init(0, 1, 0, 0);
        pub const down = Self.init(0, -1, 0, 0);
        pub const foward = Self.init(0, 0, 1, 0);
        pub const backward = Self.init(0, 0, -1, 0);
        pub const right = Self.init(1, 0, 0, 0);
        pub const left = Self.init(-1, 0, 0, 0);
    };
}

pub fn Vec(comptime size: comptime_int, comptime ScalarT: type) type {
    return switch (size) {
        2 => Vec2(ScalarT),
        3 => Vec3(ScalarT),
        4 => Vec4(ScalarT),
        else => unreachable,
    };
}

test "Vec3 operations" {
    const a = V2i.up; // 0, 1, 0
    const b = a.add(2); // 2, 3, 2
    const c = b.add(V2i.init(3, 2)); // 5, 5, 5
    const d = c.sub(1); // 4, 4, 4
    const e = d.mul(3); // 12, 12, 12
    const f = e.negate(); // -12, -12, -12
    const g = f.mul(-2); // 24, 24, 24

    std.testing.expect(g.equalTo(24));
    std.testing.expect(g.lessThan(V2i.one.mul(26)));
    std.testing.expect(g.gterEqual(V2i.init(24, 24)));
}

test "Vec3 random" {
    var rand = std.rand.DefaultPrng.init(1337).random;

    std.testing.expect(V3f.random(&rand).unitVec().magSqr() == 1);
}
