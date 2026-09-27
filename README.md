# zig-playground

Hands-on POCs of the Zig language. Every project is small, focused on one idea and runs with `zig build` or `zig run`.

## 🚀 Basics

The first steps: printing, values, types and tests.
Zig has no hidden control flow and no hidden allocations.

* [hello](hello/) - Hello world with `zig build`
* [hello-debug](hello-debug/) - Hello world with `std.debug.print`
* [zig-0.13-hello](zig-0.13-hello/) - Hello world on Zig 0.13
* [zig-0.14-hello](zig-0.14-hello/) - Hello world on Zig 0.14
* [argv-simple](argv-simple/) - Read command line arguments
* [values-typez](values-typez/) - Integers, floats, booleans, optionals and error unions
* [typez-fun](typez-fun/) - Arrays vs slices vs string literals
* [type_coercion_fun](type_coercion_fun/) - Implicit and explicit type coercion
* [expressions-fun](expressions-fun/) - Blocks and expressions that return values
* [undefined-fun](undefined-fun/) - What `undefined` means for a variable
* [default-field-values-fun](default-field-values-fun/) - Struct fields with default values
* [tests-comments](tests-comments/) - Comments and `test` blocks
* [rnd-num-simple](rnd-num-simple/) - Random numbers with `std.Random`
* [time-tracker-simple](time-tracker-simple/) - Simple integer math to compute a work pace

## 🔀 Control Flow

Zig has `if`, `switch`, `for` and `while`, and all of them can be expressions.
`defer` runs cleanup when the scope ends.

* [if-expression-fun](if-expression-fun/) - `if` as an expression
* [return-if-fun](return-if-fun/) - Returning the value of an `if`
* [switch-fun](switch-fun/) - `switch` statements
* [switch-expressions-fun](switch-expressions-fun/) - `switch` as an expression
* [inline-switch-fun](inline-switch-fun/) - `inline` switch prongs
* [forloops](forloops/) - `for` loops over arrays and slices
* [for-var-fun](for-var-fun/) - `for` loops with captured values
* [for-char-index-fun](for-char-index-fun/) - `for` over chars with the index
* [range-for-index-for](range-for-index-for/) - `for` over ranges
* [slice-for-loop-fun](slice-for-loop-fun/) - `for` over slices
* [inline-loop-fun](inline-loop-fun/) - `inline for` unrolled at compile time
* [zig-while](zig-while/) - `while` loops
* [while-else-fun](while-else-fun/) - `while` with an `else` branch
* [return-while-fun](return-while-fun/) - Returning a value from a `while`
* [defer-fun](defer-fun/) - `defer` and `errdefer`

## ⚠️ Errors & Optionals

Errors are values and optionals replace null pointers.
`try`, `catch` and `orelse` make the unhappy path explicit.

* [catch-after-fn-call-fun](catch-after-fn-call-fun/) - `catch` right after a function call
* [if-to-check-errors-fun](if-to-check-errors-fun/) - `if` to unwrap error unions
* [optional-fun](optional-fun/) - Optional types with `?T`
* [optional-try-2-fun](optional-try-2-fun/) - More on optionals and `try`
* [orelse-fun](orelse-fun/) - Default values with `orelse`
* [zig-optinal-simple-fun](zig-optinal-simple-fun/) - The simplest optional

## 🧵 Strings

Zig has no string type, only byte arrays and slices.
These POCs show how to compare, split, build and reverse them.

* [strings](strings/) - String basics
* [simples-strings-fun](simples-strings-fun/) - Simple string handling
* [chars-strings-pocs](chars-strings-pocs/) - Chars and strings
* [string-equals](string-equals/) - Compare strings with `std.mem.eql`
* [string-rev-fun](string-rev-fun/) - Reverse a string
* [string-builder](string-builder/) - A string builder
* [foreach-string-fun](foreach-string-fun/) - Iterate over a string
* [split-iterator-fun](split-iterator-fun/) - Split strings with an iterator
* [copy-string-using-allocator-fun](copy-string-using-allocator-fun/) - Copy a string with an allocator
* [returning-slices-from-functions-strings](returning-slices-from-functions-strings/) - Return string slices from functions
* [array-of-strings-fun](array-of-strings-fun/) - Arrays of strings
* [zig-strings-lib](zig-strings-lib/) - The `zig-string` library
* [base64-fun](base64-fun/) - Base64 encode and decode

## 📦 Arrays, Slices & Pointers

Arrays have a length known at compile time, slices carry a pointer and a length.
Pointers can be single item, many item or optional.

* [arrays](arrays/) - Arrays
* [change-array-ref-fun](change-array-ref-fun/) - Change an array through a reference
* [slices-fun](slices-fun/) - Slices
* [vectors-fun](vectors-fun/) - SIMD `@Vector`
* [pointers](pointers/) - Pointers
* [pointer-fun](pointer-fun/) - More pointers
* [pointers-null-fun](pointers-null-fun/) - Optional pointers instead of null

## 🧱 Structs, Enums & Unions

Structs hold data and functions, enums name values and tagged unions hold one of many types.

* [structs](structs/) - Structs
* [this-struct-fun](this-struct-fun/) - `@This()` inside a struct
* [struct-comptime-fun](struct-comptime-fun/) - Structs built at compile time
* [generic-struct-fun](generic-struct-fun/) - Generic structs
* [wrapper-type-zig](wrapper-type-zig/) - A generic wrapper type
* [funcs-fun](funcs-fun/) - Functions
* [enums](enums/) - Enums
* [unions-fun](unions-fun/) - Unions
* [tagged-union](tagged-union/) - Tagged unions

## 🧬 Comptime & Reflection

`comptime` runs code at compile time and types are values.
This is how Zig does generics and reflection.

* [comptime_fizzbuzz](comptime_fizzbuzz/) - FizzBuzz at compile time
* [comptime_generic_functions](comptime_generic_functions/) - Generic functions with `comptime`
* [comptime_generic_struct](comptime_generic_struct/) - Generic structs with `comptime`
* [comptime_partial_eval](comptime_partial_eval/) - Partial evaluation at compile time
* [comptime-generics-fun](comptime-generics-fun/) - More generics
* [comptime-parameters](comptime-parameters/) - `comptime` parameters
* [comptime-vs-runtime-fun](comptime-vs-runtime-fun/) - Compile time vs runtime
* [function-reflection-fun](function-reflection-fun/) - Reflection over functions
* [metaprograming-typeof-fun](metaprograming-typeof-fun/) - Metaprogramming with `@TypeOf`
* [typeof-fun](typeof-fun/) - `@TypeOf` and `@typeInfo`
* [typeof-fun-has-field](typeof-fun-has-field/) - `@hasField` checks

## 🔌 Interfaces

Zig has no interfaces, so they are built by hand with pointers and vtables.

* [interfaces-ptr-fun](interfaces-ptr-fun/) - Interfaces with `*anyopaque`
* [interfaces-zig-fun](interfaces-zig-fun/) - Interfaces in Zig
* [zig-interfaces-ish](zig-interfaces-ish/) - An interface-ish pattern
* [iter-zig-fun](iter-zig-fun/) - Custom iterators

## 🗂️ Data Structures & Memory

Every allocation takes an explicit allocator.
Data structures from `std` and written by hand.

* [arraylist](arraylist/) - `std.ArrayList`
* [array-lists-fun](array-lists-fun/) - More `ArrayList`
* [hashmap-fun](hashmap-fun/) - `std.HashMap`
* [hashmap-struct-fun](hashmap-struct-fun/) - HashMap with struct values
* [linkedlist-fun](linkedlist-fun/) - Linked list
* [queue-in-zig](queue-in-zig/) - Queue
* [stack-in-zig](stack-in-zig/) - Stack
* [ring-buffer](ring-buffer/) - Ring buffer
* [tree-zig](tree-zig/) - Binary tree
* [arena-allocator-fun](arena-allocator-fun/) - Arena allocator
* [threadlocal-fun](threadlocal-fun/) - `threadlocal` variables

## 📄 JSON, Files & Templates

Parse and write JSON, read files and render templates.

* [json-fun](json-fun/) - JSON with `std.json`
* [json-lib-fun](json-lib-fun/) - JSON with a library
* [tru-json-parsing-fun](tru-json-parsing-fun/) - JSON parsing
* [zig-json-std-0.13](zig-json-std-0.13/) - `std.json` on Zig 0.13
* [getty-fun](getty-fun/) - Getty JSON serialization
* [parse-file-fun](parse-file-fun/) - Read and parse a file
* [mustache-zig-fun](mustache-zig-fun/) - Mustache templates

## 🌐 Networking & Web

Sockets, HTTP servers and clients, and web frameworks.

* [simple-server-socket-zig](simple-server-socket-zig/) - TCP server socket
* [zig-echo-fun](zig-echo-fun/) - TCP echo server
* [zig-http-server-and-client](zig-http-server-and-client/) - HTTP server and client with `std.http`
* [http-server-c](http-server-c/) - HTTP server in C built with Zig
* [zig-zap](zig-zap/) - Zap web framework
* [jet-zig-fun](jet-zig-fun/) - Jetzig web framework
* [okredis-lib-fun](okredis-lib-fun/) - Redis client with OkRedis

## 🤝 C, Rust & WebAssembly

Zig is also a C compiler and a cross compiler.
It can call C and Rust and target WebAssembly.

* [translate-c-fun](translate-c-fun/) - Turn C code into Zig with `translate-c`
* [zig-compiles-c](zig-compiles-c/) - Zig as a C compiler
* [zig-0.13-zig-and-c-all-together](zig-0.13-zig-and-c-all-together/) - Zig and C in one build
* [zig-calling-rust-fun](zig-calling-rust-fun/) - Zig calling a Rust library
* [zig-cross-compile](zig-cross-compile/) - Cross compile to other targets
* [webassembly-fun](webassembly-fun/) - Zig to WebAssembly
* [zig-wasi-fun](zig-wasi-fun/) - Zig on WASI

## 🛠️ Modules, Build & Tooling

Split code into files and modules, add packages, parse flags and benchmark.

* [module-file-import-fun](module-file-import-fun/) - Import another file
* [zig-imports-modules](zig-imports-modules/) - Import modules from folders
* [zig-modules-fun](zig-modules-fun/) - Modules
* [fun-with-zigmod-package-manager](fun-with-zigmod-package-manager/) - zigmod package manager
* [zig-clap-fun](zig-clap-fun/) - Command line flags with zig-clap
* [zbench-fun](zbench-fun/) - Benchmarks with zBench

## 🎮 Apps & Games

Small complete programs.

* [simple-console-game](simple-console-game/) - Rock, paper, scissors in the console
* [zig-snake-claude](zig-snake-claude/) - Snake game generated by Claude
* [raylib-fun](raylib-fun/) - A window with raylib
* [zig-simple-pass-gen](zig-simple-pass-gen/) - Password generator
* [in-memory-stock-engine](in-memory-stock-engine/) - In-memory stock matching engine
* [100-million-row-challenge-zig](100-million-row-challenge-zig/) - Process 100 million rows as fast as possible

## ⚡ Zig 0.15

Short POCs written for Zig 0.15.

* [zig-0.15-anon-struct](zig-0.15-anon-struct/) - Anonymous structs
* [zig-0.15-arraylist-sum](zig-0.15-arraylist-sum/) - Sum an `ArrayList`
* [zig-0.15-bit-flags](zig-0.15-bit-flags/) - Bit flags
* [zig-0.15-comptime-fact](zig-0.15-comptime-fact/) - Factorial at compile time
* [zig-0.15-defer-order](zig-0.15-defer-order/) - Order of `defer` calls
* [zig-0.15-enum-name](zig-0.15-enum-name/) - Enum names with `@tagName`
* [zig-0.15-error-handler](zig-0.15-error-handler/) - Error handling
* [zig-0.15-fibonacci-rec](zig-0.15-fibonacci-rec/) - Recursive Fibonacci
* [zig-0.15-json-stringify](zig-0.15-json-stringify/) - JSON stringify
* [zig-0.15-optional-chain](zig-0.15-optional-chain/) - Optional chains
* [zig-0.15-pointer-mut](zig-0.15-pointer-mut/) - Mutate through a pointer
* [zig-0.15-prime-sieve](zig-0.15-prime-sieve/) - Prime sieve
* [zig-0.15-slice-reverse](zig-0.15-slice-reverse/) - Reverse a slice
* [zig-0.15-string-iter](zig-0.15-string-iter/) - Iterate over a string
* [zig-0.15-struct-method](zig-0.15-struct-method/) - Struct methods
* [zig-0.15-switch-range](zig-0.15-switch-range/) - `switch` on ranges
* [zig-0.15-tagged-shape](zig-0.15-tagged-shape/) - Shapes with tagged unions
* [zig-0.15-time-now](zig-0.15-time-now/) - Current time
* [zig-0.15-vtable-fun](zig-0.15-vtable-fun/) - Polymorphism with a vtable
* [zig-0.15-while-step](zig-0.15-while-step/) - `while` with a step
* [zig-0.15-word-count](zig-0.15-word-count/) - Word count
