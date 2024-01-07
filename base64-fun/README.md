### Zig Version
```
0.11.0
```

### Supported Operations
Person 
```
init              : Init a Person struct.
to_slice          : Return a slice of []u8 to the client(client will owen the memory) this is the format `id,name,email`
to_encoded        : Returns []const u8 base64 encoded of id,name,email
to_decoded        : Base64 Decoded into a reference buffer: `buf: []u8` returns void
```

### Program Output
```bash
❯ zig build run
Person id: 49, name: john, email:john@doe.com
look what I got == [1,john,john@doe.com]
got encoded [MSxqb2huLGpvaG5AZG9lLmNvbQ==]
back baby = 1,john,john@doe.com
Base64 [am9obg==]
Decoded [john]
```

## Full Test Output
```bash
zig test src/main.zig
```
```
❯ zig test src/main.zig
Test [1/4] test.Person.init... Person id: 49, name: john, email:john@doe.com
Test [2/4] test.Person.to_slice... look what I got == [1,john,john@doe.com]
Test [3/4] test.Person.to_encoded... look what I got == [1,john,john@doe.com]
got encoded [MSxqb2huLGpvaG5AZG9lLmNvbQ==]
All 4 tests passed.
```
