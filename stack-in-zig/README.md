## Stack in Zig

Stacks are FIFO(First in First Out). <BR/>
Zig version:
```bash
0.11.0
```
### Supported Opperations

```
init             : Creates a generic comptime Stack of type T.
deinit           : Destroy all Nodes on the Stack.
push             : Add a value to the stack of type T. Return T.
pop              : Remove tail of the stack, return type T.
size             : Returns usize, size of the stack.
poll             : Returns current element without removing from the stack.
print            : Print all elements of the stack, return void.
```

### Full Test output
```
zig test src/stack.zig
```
```
❯ zig test src/stack.zig
Test [2/5] test.stack.print... Stack size: 0

All 5 tests passed.
```

### Run the Program 
```bash
zig build run
```
```
Stack size: 0

Stack size: 3
element: 3
element: 2
element: 1

Stack size: 0

```