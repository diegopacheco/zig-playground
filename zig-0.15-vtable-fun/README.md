# Zig VTable Implementation

## How It Works

A vtable (virtual table) is a mechanism for achieving polymorphism without using language-level inheritance. This implementation shows how to manually create polymorphic behavior in Zig.

### Core Concept

1. **Base Type (Animal)**: Contains a pointer to a VTable struct that holds function pointers for all polymorphic methods (`speak` and `move`).

2. **VTable Struct**: Defines the interface by holding function pointers. Each pointer accepts `*const Animal` as parameter to enable polymorphic calls.

3. **Concrete Types (Dog, Cat)**: Each type embeds the base Animal struct and provides its own implementations of the vtable functions. They use `@fieldParentPtr` to convert from the Animal pointer back to the concrete type.

4. **Static VTables**: Each concrete type defines a constant vtable with pointers to its specific implementations.

5. **Polymorphic Usage**: Different types can be stored in an array of `*const Animal` and called uniformly through the same interface, with each type executing its own implementation.

### Flow

When calling `animal.speak()`:
- The Animal struct's speak method is called
- It delegates to `self.vtable.speak(self)`
- The vtable points to the concrete implementation (Dog.speak or Cat.speak)
- The concrete implementation uses `@fieldParentPtr` to recover the original type
- The type-specific behavior executes

This pattern enables runtime polymorphism without inheritance, giving explicit control over dispatch behavior.

### Run

```bash
./run.sh
``` 

### Result

```
❯ ./run.sh
Rex says: Woof!
Rex runs on four legs

Whiskers says: Meow!
Whiskers walks silently
```
