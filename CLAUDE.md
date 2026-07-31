# CLAUDE.md — AI Agent Instructions

## Rules (MUST follow)

1. **ALWAYS run linter and formatter before committing code.** Every single commit must pass both checks. Use whatever tools the project uses:
   - **Python** (pyproject.toml): `uv run ruff check . --fix && uv run ruff format .`
   - **Node.js** (package.json): `npx eslint . --fix && npx prettier --write .`
   - **Go** (go.mod): `golangci-lint run && gofmt -l .`
   - **Rust** (Cargo.toml): `cargo clippy -- -D warnings && cargo fmt`

2. **All changes go through a Pull Request.** Never push directly to `main` or `dev`.

3. **Branch workflow:**
   ```
   feature/xyz → dev     (squash merge, for testing/staging)
   feature/xyz → main    (squash merge, for production)
   ```
   Do NOT merge dev into main. Both dev and main receive PRs from feature branches.

4. **Use conventional commit messages:** `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `ci:`, `chore:`

5. **Branch naming:** `feat/description`, `fix/description`, `refactor/description`, etc.

6. **Write tests** for new functionality. Run the full test suite before pushing:
   - **Python:** `uv run pytest`
   - **Node.js:** `npm test`
   - **Go:** `go test ./...`
   - **Rust:** `cargo test`

7. **Don't add dependencies** without discussing first.

## Pre-Commit Checklist (run before EVERY commit)

```bash
# 1. Detect project type and run appropriate linter
# Python example:
uv run ruff check . --fix
uv run ruff format .
uv run ruff check .

# 2. Run tests
uv run pytest

# 3. Only then commit
git add <files>
git commit -m "feat: your message"
```

## Project Structure

```
.github/
  CODEOWNERS                  # Code review ownership
  pull_request_template.md    # PR template
  workflows/ci.yml            # CI pipeline (auto-detects project type)
CLAUDE.md                     # This file — agent instructions
pyproject.toml / package.json / go.mod / Cargo.toml
src/                          # Source code
tests/                        # Tests
scripts/                      # Utility scripts
```
