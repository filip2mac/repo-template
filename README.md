# repo-template

Template repository for AI agent-driven projects. Supports Python, Node.js, Go, and Rust out of the box.

## What's Included

- **CI Pipeline** — auto-detects project type (Python/Node/Go/Rust) and runs the appropriate linter + formatter + tests
- **Branch Protection** — main and dev require PRs, squash merge only, CI must pass
- **CODEOWNERS** — filip2mac owns all code
- **PR Template** — structured checklist for every pull request
- **CLAUDE.md** — instructions for AI agents working in this repo

## Workflow

```
feature/xyz → dev     (squash merge, for testing/staging)
feature/xyz → main    (squash merge, for production)
```

Both `main` and `dev` are protected:
- All changes go through a Pull Request
- Squash and merge only
- CI (lint + format + tests) must pass before merge
- Linear history enforced (no merge commits)

The repo owner (filip2mac) can force push to `main` when needed.

## Quick Start (create a new repo from this template)

```bash
gh repo create my-new-project --template filip2mac/repo-template --public --clone
cd my-new-project
```

## Supported Project Types

The CI pipeline auto-detects your project based on manifest files:

| Language | Detection     | Linter        | Formatter    | Test runner |
|----------|--------------|---------------|--------------|-------------|
| Python   | pyproject.toml | ruff        | ruff format  | pytest      |
| Node.js  | package.json | eslint        | prettier     | npm test    |
| Go       | go.mod       | golangci-lint | gofmt        | go test     |
| Rust     | Cargo.toml   | clippy        | cargo fmt    | cargo test  |

## For AI Agents

Read `CLAUDE.md` for mandatory pre-commit workflow. Key rule: always run the project's linter + formatter before committing.

## Development

```bash
# Python
uv sync && uv run ruff check . --fix && uv run ruff format . && uv run pytest

# Node.js
npm install && npx eslint . --fix && npx prettier --write . && npm test

# Go
go mod download && golangci-lint run && gofmt -w . && go test ./...

# Rust
cargo build && cargo clippy -- -D warnings && cargo fmt && cargo test
```
