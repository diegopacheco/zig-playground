### Zig version

```
❯ zig version
0.13.0
```

### Result

```
zig build run
```
```
Zig: 2  + 3 = 5 
C  : 10 - 3 = 7 
C  : 5  * 6 = 30 
```

### How to make Zig also include and compile C?

build.zig
```
 // Add all C source files C and H files
 exe.addIncludePath(.{ .src_path = .{
    .owner = b,
    .sub_path = "c-src/",
 }});
```