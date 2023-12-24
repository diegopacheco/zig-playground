### POC

This POC show how to work with Strings and chars in Zig. <br/>
There is a bunch of experiments.

### Rationale - Strings in Zig

Zig has String literals, when you do "hello world" this is a hardcoded string, Zig compiler does something called String interning to remove duplicates(https://en.wikipedia.org/wiki/String_interning). When using string lerals you are not using the Stack memory, you are always dealing with pointers.

### Recipes(functions) on the POC

* Direct concatenate 2 String literals (direct_concat)
* Convert String literal to integer (string_to_int)
* Replace char by index in String (replace_string_with_char)
* Compare two strings (compare_strings)
* Know is a char is digit or alpha(char_utils_is_digit_alpha_num)
* Concatenate String with char (concat_string_with_char)