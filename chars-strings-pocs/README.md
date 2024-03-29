### POC

This POC show how to work with Strings and chars in Zig. <br/>
There is a bunch of experiments.

### Rationale - Strings in Zig

Zig has String literals, when you do "hello world" this is a hardcoded string, Zig compiler does something called String interning to remove duplicates(https://en.wikipedia.org/wiki/String_interning). When using string literals you are not using the Stack memory, you are always dealing with pointers.
<br/>
<br/>
Zig does not have a String type per se."Strings" are just arrays of bytes. Strings literal in Zig have a null terminator at the end, which makes it compatible with C language. <br/>
There are Arrays and Slices:
```Zig
var array:[5]u8 = .{'d','i','e','g','o'};
```
Slices are similars to arrays but the difference is the lack of size, for instance:
```Zig
var slice: []u8 = array[0..];
```
So, what is a Slice? It's a pointer + length, which does not own memory.
What about returning or mutating strings and return in functions?
1. You can return string literal ([]const u8)
2. You can recive a buffer and append on the buffer
3. You can have an allocator(recive the allocator) and do dynamyc allocation.
4. You can return a buffer like [5]u8 as long the the caller is holding it (this is not ideal because how do you know the
right size of the string, you will make it bigger and will be inneficient)

Can I return a pointer to a buffer in function? NO. 
Because the functions live in the stack, when the function is over, stack is clean.

### Recipes(functions) on the POC

* Slices (slices)
* Direct concatenate 2 String literals (direct_concat)
* Convert String literal to integer (string_to_int)
* Replace char by index in String (replace_string_with_char)
* Compare two strings (compare_strings)
* Know is a char is digit or alpha(char_utils_is_digit_alpha_num)
* Concatenate String with char (concat_string_with_char)