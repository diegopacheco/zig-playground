### Tree in Zig

Binary Tree.
<BR/>
<BR/>
Zig Version
```bash
0.11.0
```

### Supported Operations
```
init                : Creates a tree node comptime generic type of T.
deinit              : Destroy tree nodes, left and right.
addLeft             : Add value and node to the left side of the tree.
addRight            : Add value and node to the right side of the tree.
getLeft             : Get the Node on the Left side of the tree.
getRight            : Get the Node on the Right side of the tree.
getData             : Get the Data on the tree node type of T.
inorder_print       : Print in-order the whole tree. 
```

### Tests Full Output
```bash
zig test src/ds.zig
```
```
❯ zig test src/ds.zig
All 4 tests passed.
```

### Run the Program
```bash
zig build run
```
```
❯ zig build run
Tree ds.BinaryTree(i32){ .allocator = mem.Allocator{ .ptr = anyopaque@7ffde783df78, .vtable = mem.Allocator.VTable{ .alloc = fn(*anyopaque, usize, u8, usize) ?[*]u8@2525d0, .resize = fn(*anyopaque, []u8, u8, usize, usize) bool@252cb0, .free = fn(*anyopaque, []u8, u8, usize) void@254210 } }, .rootNode = ds.BinaryTree.Node{ .allocator = mem.Allocator{ .ptr = anyopaque@7ffde783df78, .vtable = mem.Allocator.VTable{ ... } }, .data = 1, .leftNode = ds.BinaryTree.Node{ .allocator = mem.Allocator{ ... }, .data = 2, .leftNode = null, .rightNode = null }, .rightNode = ds.BinaryTree.Node{ .allocator = mem.Allocator{ ... }, .data = 3, .leftNode = null, .rightNode = null } } }
2 1 3 %
```