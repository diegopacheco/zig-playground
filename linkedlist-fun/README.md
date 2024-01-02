### Run all Tests
```bash
zig test src/linkedlist.zig
```

### Run the Program
```bash
zig build run
```

### Double Linked list

Supported Opperations
```
init         : Creates a Generic T DLL.
deinit       : Destroy a DLL all links.
add          : Add elements of type T to the DLL.
get          : Get elements by index my throw ElementNotFound | EmptyList errors
remove_first : Remove first element(head) of the DLL.
remove_last  : Remove first element(tail) of the DLL.
remove       : Remove by index.
size         : Size of the DLL, 0 if empty.
print        : Print all elements of the DLL.
```

### Useful things in Zig

*Memory Management*: Everything you allocate with `std.mem.Allocator` <BR/> 
needs to be `destroy` before the program ends otherwise <BR/> 
Zig will give you an error sayign the memory has leeked. <BR/> 

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
6. How to catch an error? (there is no try - just catch)
```Rust
    _ = dll.get(100) catch |err| {
        print("Element not found {any} \n", .{err});
    };
```

### Learning from Errors
```
error: use of undeclared identifier 'Node'
```
Wrong
```Rust
    const Node = struct {
        value: T,
        next: Node,
        prev: ?*Self,
        const Self = @This();
    };
```
Right:
```Rust
    const Node = struct {
        value: T,
        next: ?*Self,
        prev: ?*Self,
        const Self = @This();
    };
```
```
 error: no field named 'next' in struct 'linkedlist.DoubleLinkedList.Node'
```
Wrong
```Rust
    const Node = struct {
        value: T,
        prev: ?*Self,
        var next: ?*Self = null;
        const Self = @This();
    };
```
Right:
```Rust
    const Node = struct {
        value: T,
        next: ?*Self,
        prev: ?*Self,
        const Self = @This();
    };
```
This is by language design, Zig does not support private fields in strucs <BR/>
https://www.reddit.com/r/Zig/comments/13v6q2z/struct_fields_are_always_public_by_design/

```
error: cannot assign to constant
```
Wrong:
```Rust
pub fn add(self: Self, value: T) !bool {
     // ... rest of the code
}
```
Right:
```Rust
pub fn add(self: *Self, value: T) !bool {
     // ... rest of the code
}
```
Zig param arguments are immutable by default <BR/> somethimes you will see implicit `const`
https://stackoverflow.com/questions/74021886/how-do-i-mutate-a-zig-function-argument

Pearhaps the most obscrure so far...
```
Segmentation fault at address 0x0
```
Wrong:
```Rust
        pub fn add(self: *Self, value: T) !bool {
            var newNode: *Node = try self.allocator.create(Node);
            newNode.value = value;

            if (self.tail) |safe_tail| {
                newNode.prev = safe_tail;
                safe_tail.next = newNode;
            } else {
                self.head = newNode;
            }
            self.tail = newNode;
            self.count += 1;
            return true;
        }
```
Right:
```Rust
        pub fn add(self: *Self, value: T) !bool {
            var newNode: *Node = try self.allocator.create(Node);
            newNode.value = value;
            newNode.prev = null;
            newNode.next = null;

            if (self.tail) |safe_tail| {
                newNode.prev = safe_tail;
                safe_tail.next = newNode;
            } else {
                self.head = newNode;
            }
            self.tail = newNode;
            self.count += 1;
            return true;
        }
```
Yes - null initialization to sub-strcut pointer is necessary !!!
```Rust
newNode.prev = null;
newNode.next = null;
```


### Tests Result Output
```bash
zig test src/linkedlist.zig
```
```
Test [2/8] test.DLL.print... >>> DLL size is: 1
>> element: [1]
Test [4/8] test.DLL.remove tail... * Found index for removal
* Removing tail
>>> DLL size is: 4
>> element: [1] >> element: [2] >> element: [3] >> element: [4]
Test [5/8] test.DLL.remove head... * Found index for removal
* Removing head
>>> DLL size is: 4
>> element: [2] >> element: [3] >> element: [4] >> element: [5]
Test [6/8] test.DLL.remove middle... * Found index for removal
* Removing in the middle of the list
>>> DLL size is: 4
>> element: [1] >> element: [2] >> element: [4] >> element: [5]
Test [7/8] test.DLL.remove middle, first to all... * Found index for removal
* Removing in the middle of the list
* Found index for removal
* Removing head
* Found index for removal
* Removing head
* Found index for removal
* Removing head
* Found index for removal
* Removing head
>>> DLL size is: 0
Test [8/8] test.DLL.remove middle, tail to all... * Found index for removal
* Removing in the middle of the list
* Found index for removal
* Removing tail
* Found index for removal
* Removing tail
* Found index for removal
* Removing tail
* Found index for removal
* Removing head
>>> DLL size is: 0
All 8 tests passed.
```