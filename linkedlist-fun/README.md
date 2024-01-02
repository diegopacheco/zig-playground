### Useful things in Zig

1. How to unwrap some optional value? 
```Rust
var temp: ?*Node = curr.next;  // Optional becase ?
var temp: *Node = curr.next.?; // Type has no ? because was unwraped by .? 
```
2. How to create errors ? And return errors? 
```Rust
    const Errors = error{
        ElementNotFound,
        EmptyList,
    };
    pub fn get(self: *Self, index: usize) !T {
         _ = self;  // ignore arg not used.
         _ = index; // ignore arg not used.
         // ... Return T type or Errors
         // to throw errors
         return Errors.EmptyList;
    }
```

### Run all Tests
```bash
zig test src/linkedlist.zig
```

### Run the Program
```bash
zig build run
```