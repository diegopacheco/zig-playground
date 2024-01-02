### Useful things in Zig

1. How to unwrap some optional value? 
```Zig
var temp: ?*Node = curr.next;  // Optional becase ?
var temp: *Node = curr.next.?; // Type has no ? because was unwraped by .? 
```