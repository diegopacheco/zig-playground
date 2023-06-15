### Build Rust lib
```bash
cd rust-add-lib/
cargo install cbindgen
cbindgen --lang c --output rustlib.h
cargo build --release
```

### Build Zig App
```bash
zig build-exe main.zig -I. -lc -l rust_lib/target/release/librust_lib.so
```

### Run
```bash
./main
```