## Queue implemented in Zig

Queues are LIFOs(Last In First Out) <BR/><BR/>
Zig Version:
```bash
0.11.0
```

### Supported Opperations
```
init               : Creates a generic comptime queue of type T.
deinit             : Destroy all Node's in memory for clear memory management.
add                : Add an element of type T to the Queue.
poll               : Retrieve and remove the tail element of the head, may raise QueueIsEmptyError.
peek               : Returns the head value of the queue or raise QueueIsEmptyError.
size               : Returns the usize size of the queue.
print              : Returns void, but print the queue on console.
```

### Full Tests output
```bash
zig test src/queue.zig
```
```
❯ zig test src/queue.zig
Test [3/6] test.Queue.print... >>> Queue size is 3
>>> Queue head: [1] - tail: [3] - elements:
[1] [2] [3]
All 6 tests passed.
```

### Learning some Zig from errors

```
error: function with comptime-only return type 'type' requires all parameters to be comptime
```
Wrong:
```Rust
    pub fn init(allocator: Allocator) type {
        return .{
            // rest of the code
        };
    }
```
Right:
```Rust
    pub fn init(allocator: Allocator) !Self {
        return .{
            // rest of the code
        };
    }
```
<BR/>
<BR/>

```
 error: expected type '*mem.Allocator', found 'mem.Allocator'
```
Wrong:
```Rust
    pub fn init(allocator: *Allocator) Self {
        return .{
            // rest of the code
        };
    }
```
Right:
```Rust
    pub fn init(allocator: Allocator) Self {
        return .{
            // rest of the code
        };
    }
```
<BR/>
<BR/>

```
error: expected 2 argument(s), found 1
```
Wrong:
```Rust
    pub fn init(self: *Self, allocator: Allocator) Self {
        _ = self;
        return .{
            // rest of the code
        };
    }
```
Right:
```Rust
    pub fn init(allocator: Allocator) Self {
        return .{
            // rest of the code
        };
    }
```

How to test for errors?
```Rust
const Errors = error{
  QueueIsEmptyError,
};  
// rest of the code

test "Queue.poll error.QueueIsEmptyError" {    
  // rest of the code  
  var err = iq.poll();
  try std.testing.expectError(Errors.QueueIsEmptyError, err);
}
```

### Run the program
```bash
zig build run
```
```
❯ zig build run
Queue: queue.Queue(i32){ .allocator = mem.Allocator{ .ptr = anyopaque@7ffc24605ca8, .vtable = mem.Allocator.VTable{ .alloc = fn(*anyopaque, usize, u8, usize) ?[*]u8@252cf0, .resize = fn(*anyopaque, []u8, u8, usize, usize) bool@2533d0, .free = fn(*anyopaque, []u8, u8, usize) void@254930 } }, .size = 0, .head = null, .tail = null } created!
>>> Queue size is 3
>>> Queue head: [1] - tail: [3] - elements:
[1] [2] [3]
Head val is 1
>>> Queue size is 2
>>> Queue head: [1] - tail: [2] - elements:
[1] [2]
>>> Queue size is 1
>>> Queue head: [1] - tail: [1] - elements:
[1]
>>> Queue size is 0
```