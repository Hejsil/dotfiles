---
name: zig-tokencount
description: Counts lexical tokens in Zig source — the code-size metric for before/after complexity comparisons. Load when a task needs a size/complexity measurement of Zig code (simplification/refactor acceptance, "make this smaller", diff size gates).
---

# Zig Token Count

Measure Zig source size as **lexical token count**, using the compiler's own tokenizer (`std.zig.Tokenizer`). The tool is `tokencount.zig` next to this file. Requires Zig 0.16+ (current std APIs).

## Run it

```sh
zig run skill://zig-tokencount/tokencount.zig -- <file.zig>...
```

`zig` is present in any Zig codebase; compilation is cached, execution is instant. To cover a whole tree, enumerate files first (glob), then pass them explicitly.

Output — per-file count, then total:

```
   2867  src/Mod/Tokenizer.zig
 132172  src/Mod/Parser.zig
 165071  total
```

## What counts

- Every token the compiler emits: identifiers, keywords, literals, operators, punctuation.
- Excluded: whitespace, `//` comments, `///` doc comments, `//!` container doc comments, final EOF.
- A string literal is one token regardless of length; an identifier is one token regardless of name.

## Use as an acceptance metric

- Record per-file and total **before** a simplification, run again **after**.
- Success criterion: total not increased (or per-file budgets met).
- The metric only moves on real structural change — reformatting, line-joining, or identifier renaming does not affect it.
