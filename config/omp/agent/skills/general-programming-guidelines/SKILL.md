---
name: general-programming-guidelines
description: Coding conventions governing all authoring, review, and refactoring in any project.
---

# General Programming Guidelines

Applies to all code written, reviewed, or refactored in every project.

## Early returns over deep nesting
Exit as soon as the outcome is known. Invert conditions and `return`/`continue`/`break` early instead of nesting `if/else`.

```rust
// avoid
if a { if b { if c { work() } } }
// prefer
if !a { return; }
if !b { return; }
if c { work() }
```

## Offensive programming — fail fast and visibly
Validate inputs and invariants up front; error or panic immediately rather than silently continuing or deferring failure. Never swallow or ignore errors. A loud failure now beats a confusing bug later. Assert invariants where they matter; don't paper over bad state.

## Data-oriented design for large data
When processing large volumes of data, prefer flat, contiguous, cache-friendly layouts (arrays, structs-of-arrays, batch processing) over pointer-chasing object graphs and per-element abstraction. Design around memory layout and hot loops; avoid indirection and per-item allocation in inner loops.

## Follow YAGNI principle
Don't implement features or abstractions until they are actually needed. Avoid over-engineering and speculative general solutions. Favor simple, direct solutions over complex abstractions.

## Validate your work
Never yield work without proof it works. Format the code, build the project, run relevant linters, and run all tests. Whenever a feature introduces a new observable behavior, accompany it with a test that validates that behavior; don't ship untested changes.
