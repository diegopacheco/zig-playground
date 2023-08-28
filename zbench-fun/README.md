## Build
```bash
zig build run
```
```
Total operations: 798
benchmark            time (avg)   (min ... max)        p75        p99        p995
--------------------------------------------------------------------------------------
benchmarkMyFunction  2.0ns        (7.0ns ... 54.0ns) 7.0ns      38.0ns     39.0ns
```

Was not working with Zig 0.11 - I made a fix here: https://github.com/hendriknielaender/zBench/pull/1