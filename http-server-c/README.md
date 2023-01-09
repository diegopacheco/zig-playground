### Compile and Run in C

```bash
cc -o server server.c
 ./server 8080
```

### Compile and Zig with `Zig cc`
```bash
zig cc -o zig-server server.c -target x86_64-linux-gnu
./zig-server 8080
```

### Call the HTTP Server
```bash
curl -i http://localhost:8080/index.html
```
```bash
HTTP/1.1 200 OK
Content-Type: text/html
Content-Length: 39

<html><body>Hello, World!</body></html>%   
```