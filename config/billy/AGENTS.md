Write code for a human reader, not for the machine. They hold about four things at once, so keep the
number of facts needed to follow a piece of code as small as possible.

- Do only what the task asks. No validation, options, configuration or abstraction nobody asked for:
  extra code is extra to read, and it changes behaviour nobody wanted.
- Use the smallest useful subset of the language, so that reading it needs no knowledge of its
  corners.
- Use names and values that say what they are; avoid tables and mappings a reader has to memorise.
- When one condition holds several facts, name the parts, test the names, and return early rather
  than nesting. Do that inside the function: do not give each condition a function of its own.
- A helper earns its place by hiding work behind a small interface, not by renaming a condition;
  prefer a few deep modules to many shallow ones.
- Do not over-apply DRY: a little duplication is cheaper to read than a needless dependency.
- Comment the why: what a piece of code is for, what is subtle about it, and any reading of the task
  you had to choose. Never restate the next line.
