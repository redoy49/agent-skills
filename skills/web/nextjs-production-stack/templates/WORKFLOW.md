# Workflow

Human-readable diagrams for the two flows defined in [`../AGENTS.md`](../AGENTS.md).
**`AGENTS.md` is normative** — if a diagram and its text disagree, follow the text.

## Main Flow (once per project, top to bottom)

```mermaid
flowchart TD
    A["1. Idea / Planning"] --> B["2. PRD"]
    B --> C["3. UI/UX Design"]
    C --> D["4. Technical Architecture"]
    D --> E["5. Project Setup"]
    E --> F["6. Build (Feature by Feature)"]
    F --> G{"More features left in PRD.md?"}
    G -- yes --> F
    G -- no --> H["7. Final QA"]
    H --> I["8. Deploy"]
    I --> J["9. Maintenance"]
    F -. "requirement changed: update PRD.md first" .-> B
    J -. "new feedback or request" .-> B
```

## Feature Flow (repeat for every feature inside Build)

```mermaid
flowchart TD
    P["1. Plan + Definition of Done"] --> R{"2. Review & Approve (human)"}
    R -- "changes needed" --> P
    R -- approved --> I["3. Implement (open branch feat/name)"]
    I --> T{"4. Test passes?"}
    T -- no --> I
    T -- yes --> C["5. Commit"]
    C --> RV{"6. Review Code & UI ok?"}
    RV -- "issues found" --> I
    RV -- ok --> PR["7. PR + CI"]
    PR --> CI{"CI green?"}
    CI -- no --> I
    CI -- yes --> M["8. Auto-merge into main"]
    M --> P
```

Fix is not a separate step: any failure (test, review, CI) sends you back to Implement.
