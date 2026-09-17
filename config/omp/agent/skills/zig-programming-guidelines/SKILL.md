---
name: zig-programming-guidelines
description: Coding conventions governing all authoring, review, and refactoring in Zig projects.
---

# Zig Programming Guidelines

## Validate your work

```bash
zig fmt .

# Discover steps
zig build --help | grep 'Steps:' -A10

# Run relevant validation steps discovered by above
zig build install test check
```

## Style Guide

Coding conventions from the Zig language reference.

### Avoid redundancy in names

Avoid `Value`, `Data`, `Context`, `Manager`, `State`, `utils`, `misc`, or initials in type names — they apply to every type, so they communicate nothing. Declarations that "need" a utils/misc namespace can live at the root of the module instead.

### Avoid redundant names in fully-qualified namespaces

Every declaration has a fully-qualified namespace (files are part of it too). Name relative to it: `json.JsonValue` → `json.Value`, because the FQN already says "json". Exceptions are allowed when the name is already minimal and correct.

### Refrain from underscore prefixes

Zig has no private fields; don't fake privacy with `_field`. Name fields by semantics and document invariants in doc comments. For collisions, prefer more verbose names at outer scopes and abbreviated names at inner scopes. Prefer `@"keyword"` string identifiers over underscore tricks.

### Names

Roughly: `camelCaseFunctionName`, `TitleCaseTypeName`, `snake_case_variable_name`. More precisely:

- `snake_case`: namespaces (0-field structs never instantiated), variables, fields, parameters.
- `TitleCase`: types and type aliases, and callables whose return type is `type`.
- `camelCase`: anything else callable.
- Acronyms and proper nouns follow normal capitalization: `xml_document`, `readU32Be`. Established conventions win (`ENOENT`).
- Files: `TitleCase.zig` if the file's implicit struct has top-level fields, else `snake_case.zig`. Directories: `snake_case`.

### Name allocators by usage

An allocator variable is named for what it is, not generically: `gpa` for a general-purpose allocator, `arena` for an arena allocator. The same applies to allocator-typed fields and parameters (`Store.gpa`, `init(gpa: Allocator, …)`).

### File-as-struct for data types

A file whose purpose is one data type should BE the struct: declare its fields at the top level instead of wrapping them in `pub const MyType = struct { … }`. Consumers then write `const MyType = @import("MyType.zig")`. Methods take `my_type: *@This()`; constructors return `@This()`.

### Name method receivers by what they are

Don't use `self` as a method's first argument when a better name exists: a receiver is the thing the method operates on, so name it that (`store: *const Store`, `feed: *Feed`, `my_type: *@This()`). Reserve `self` for the rare case where no meaningful name exists (e.g. a comparator's anonymous struct).

### Tests alias the testing allocator and io up front

A test that uses them starts by aliasing, before any other setup:

```zig
test "a test" {
    const io = std.testing.io;
    const gpa = std.testing.allocator;
    // rest of test
}
```

Alias `io` and `gpa` each only when the test actually uses them.

### Doc comment guidance

- Omit anything redundant with the name of the documented thing.
- Duplicating info across similar functions is encouraged — it improves IDE help text.
- Use **assume** for invariants that cause unchecked illegal behavior; **assert** for invariants that cause safety-checked illegal behavior.
