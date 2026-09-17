---
name: writing-skills
description: Design principles for authoring agent skills.
---

# Writing Skills

Best practices for creating effective agent skills. Apply these when authoring or evaluating any skill.

## What a skill is
A file-backed **capability pack** — concise knowledge/instructions the model loads on demand via `skill://<name>`. It is not a place for persistent behavioral directives; those belong in the system-prompt override (always-on style) or context files (`AGENTS.md` / `RULES.md`). A skill must earn its on-demand load; it is never a standing system instruction.

## The cost/effect tradeoff
Every token you put in a skill has a cost. Optimize for signal per token:

- **Description** — always present in the system prompt (paid on every session). Make it a **trigger, not a summary**: state the scope and when to load. Do not enumerate every principle; a general trigger ("governs all code") beats a checklist.
- **Body** — loaded only when the skill is actually read. Spend your budget here, but keep it minimal: one example beats prose; three lines of code beat a paragraph.
- If a paragraph only restates textbook definitions or motivation, cut it.

## Writing a good description
The description is the only part of a skill the model always sees (in the system prompt), so it is the sole basis for deciding whether to load the body. Optimize it for signal per token:

- Make it a **trigger, not a summary**: state the scope and when the skill applies, and stop.
- Add a short distinguishing clause only if it earns its place — a phrase that sets the skill apart from its siblings (e.g. "meta-skill about skill design") strengthens selection; a generic "consult before/use when" verb adds nothing, since that instruction applies to every skill anyway.
- Do not enumerate contents the body already covers; a general scope statement beats a checklist.

## Effective structure
- Write each principle as **principle → one-line why → actionable directive**.
- Include a tiny concrete example only where it pays off (e.g. an inversion rewrite for early returns); omit it where a good example would be long.
- State clear signals for applying the principle ("never swallow errors", "avoid per-item allocation in inner loops") instead of abstract definitions.

## Layout rules
- One level under the skills root: `<skills-root>/<skill-name>/SKILL.md` — nested `group/<name>/SKILL.md` is not discovered.
- `name` (defaults to directory name) and a meaningful `description` in frontmatter.
- Reference assets live in the same directory: `skill://<name>/<asset>`.

## When NOT to make a skill
- Persistent behavior that should apply every turn → `APPEND_SYSTEM.md`.
- Repo conventions / always-on context → `AGENTS.md` or sticky `RULES.md`.
- Executable tools/commands/hooks → an extension, not a skill.
- If it can't be stated in a few short lines, it's too big for a skill; split or move it to context files.
