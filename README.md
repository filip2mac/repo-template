# repo-template

Template repository for AI agent-driven projects. Use this as a starting point for new repos.

## What's Included

- **CI Pipeline** — GitHub Actions runs `ruff check` (lint) and `ruff format` (format) + tests on every PR
- **CODEOWNERS** — filip2mac owns all code
- **PR Template** — structured checklist for every pull request
- **Repository Rulesets** — branch protection rules (defined in `.github/repository_rulesets.json`)
- **CLAUDE.md** — instructions for AI agents working in this repo

## Quick Start (create a new repo from this template)

```bash
gh repo create my-new-project --template filip2mac/repo-template --public --clone
cd my-new-project

# Apply repository rulesets
./scripts/apply-rulesets.sh
```

## Rules (enforced by CI + branch protection)

1. All changes go through a Pull Request (no direct pushes to `main`)
2. Squash and merge only
3. CI must pass (lint + format + tests) before merge
4. No force pushes to `main`

## For AI Agents

Read `CLAUDE.md` for mandatory pre-commit workflow. Key rule: always run `ruff check . --fix && ruff format .` before committing.

## Development

```bash
# Install deps
uv sync

# Lint
uv run ruff check . --fix
uv run ruff format .
uv run ruff check .

# Test
uv run pytest
```
