### Rationale

This POC show how to work with Strings and chars in Zig.
There is a bunch of experiments.

### Strings in Zig

Zig has String literals, when you do "hello world" this is a hardcoded string, Zig compiler does something called String interning to remove duplicates(https://en.wikipedia.org/wiki/String_interning). When using string lerals you are not using the Stack memory, you are always dealing with pointers.

