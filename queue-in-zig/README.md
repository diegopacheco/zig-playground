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
Test [2/5] test.Queue.print... >>> Queue size is 3
>>> Queue head: [1] - tail: [3] - elements:
[1] [2] [3]
All 5 tests passed.
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