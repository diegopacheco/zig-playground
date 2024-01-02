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
3. How to create a Generic DataStructure ?
```Rust
pub fn DoubleLinkedList(comptime T: type) type {
       return struct {
             // fields and functions
       };
}
```
4. How to safe check if optional is present?
```Rust
 var tail: ?*Node = null;
 if (self.tail) |safe_tail| {
    _ = safe_tail;
 }
```
5. How to go over a series of linked optional Structs?
```Rust
     var current: ?*Node = self.head;
     while (current) |curr| : (current = curr.next) {
         // print
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