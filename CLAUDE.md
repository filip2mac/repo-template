# CLAUDE.md — AI Agent Instructions

## Rules (MUST follow)

1. **ALWAYS run linter and formatter before committing code.** Every single commit must pass both checks:
   ```bash
   uv run ruff check . --fix    # lint + auto-fix
   uv run ruff format .         # format
   uv run ruff check .          # verify clean (exit 0)
   ```

2. **All changes go through a Pull Request.** Never push directly to `main`. Create a feature branch, make changes, push, and open a PR.

3. **Use conventional commit messages:** `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `ci:`, `chore:`

4. **Branch naming:** `feat/description`, `fix/description`, `refactor/description`, etc.

5. **Squash and merge** is the only merge strategy. Keep PRs focused — one logical change per PR.

6. **Write tests** for new functionality. Run the full test suite before pushing:
   ```bash
   uv run pytest
   ```

7. **Don't add dependencies** without discussing first. Use `uv add <package>` if adding is needed.

## Pre-Commit Checklist (run before EVERY commit)

```bash
# 1. Lint
uv run ruff check . --fix

# 2. Format
uv run ruff format .

# 3. Verify lint is clean
uv run ruff check .

# 4. Run tests
uv run pytest

# 5. Only then commit
git add <files>
git commit -m "feat: your message"
```

## Project Structure

```
.github/
  CODEOWNERS            # Code review ownership
  pull_request_template.md
  repository_rulesets.json  # GitHub ruleset definition (applied via script)
  workflows/ci.yml      # CI pipeline (lint + test)
CLAUDE.md               # This file — agent instructions
pyproject.toml          # Project config + ruff settings
src/                    # Source code
tests/                  # Tests
scripts/
  apply-rulesets.sh     # Apply GitHub rulesets from config
```

## Code Style

- Python 3.13+
- Ruff for linting and formatting
- Type hints required on public APIs
- Docstrings for public functions/classes
- Prefer `pathlib` over `os.path`
- f-strings over `.format()` or `%`
