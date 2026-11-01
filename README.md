# agent-skills

My personal agent skills — one folder per skill, written for **Antigravity IDE** first
(Gemini-CLI lineage) and portable to **Hermes Agent**.

Each skill is plain markdown. No build step, no package manager: a skill is a folder
with a `SKILL.md`; the agent reads its `description` to decide when to load it.

## Layout

```
skills/<category>/<skill-name>/
├── SKILL.md              # required: YAML frontmatter (name + description) + body
├── templates/            # optional: files copied into a project (rules, docs)
├── references/           # optional: bulky docs the agent reads on demand
└── scripts/              # optional: helpers the skill tells the agent to run
```

`<category>` is loose (`web`, `media`, `automation`, ...) — it exists so 20 skills stay
readable, not so anything discovers them. Antigravity discovers a skill by
`<skills-root>/<skill-name>/SKILL.md`, so install flattens the category.

## Index

| Skill | Category | Trigger (when the agent loads it) | Ships |
|---|---|---|---|
| [`nextjs-production-stack`](skills/web/nextjs-production-stack/SKILL.md) | web | any Next.js App Router work: new project, feature, page/route, form, auth, DB schema, tests, Vercel deploy | `templates/AGENTS.md` project rule |

<!-- add a row per new skill; keep the Trigger column short and concrete -->

## Install

```bash
# Antigravity (global, all projects)
./install.sh skills/web/nextjs-production-stack

# Antigravity (project only, shared with the team via VCS)
./install.sh skills/web/nextjs-production-stack .agents/skills

# Hermes Agent
cp -r skills/web/nextjs-production-stack ~/AppData/Local/hermes/skills/
```

After a **global** install, restart Antigravity once — new skill directories are
discovered at app start. Content edits to an existing skill need no restart.

`templates/` files are **not** installed by the agent: copy `templates/AGENTS.md`
to `<project>/AGENTS.md` and fill in the placeholders.

## Writing the next skill

1. `mkdir -p skills/<category>/<skill-name>` and add `SKILL.md`.
2. Frontmatter, exactly two required fields:
   ```yaml
   ---
   name: motion-video           # lowercase, hyphens, matches the folder name
   description: Use when ...    # the TRIGGER — this is what the agent reads every turn
   ---
   ```
   `description` is the whole game: state what the skill does **and** the concrete
   situations that should load it ("Figma export", "After Effects", "scroll-driven
   hero"). A vague description is a skill that never fires.
3. Body = procedure the agent cannot already do well. Keep **under ~200 lines**;
   push depth into `references/`, helpers into `scripts/`. Delete any line that does
   not change behavior ("be careful", "use best practices", "run this mentally").
4. If the skill needs a file next to the user's code (a rule, a config, a doc),
   ship it in `templates/` and tell the agent to copy it — never write outside the
   skill at install time.
5. Register it: one new row in the **Index** table above.
6. `./install.sh skills/<category>/<skill-name>` and test it in a fresh chat by
   prompting the trigger sentence, not the skill name.

### Skill vs rule

- **Skill** (`SKILL.md`) — loaded on demand, chosen by `description`. Global install
  is fine: it costs only its description line until it fires.
- **Rule** (`AGENTS.md` / `GEMINI.md`) — always on, scoped to a directory. Because
  it is always on, keep it small, put it at the **project root**, and never install
  one globally unless it applies to every project you own.
