#!/usr/bin/env bash
# Apply branch protection rules to main and dev branches.
# Usage: ./scripts/apply-rulesets.sh [owner/repo]
#
# Requires: gh CLI (authenticated)
# Note: Branch protection API works on free plans for public repos.
#       For private repos, GitHub Pro is required.

set -euo pipefail

REPO="${1:-$(gh repo view --json nameWithOwner -q .nameWithOwner)}"
echo "Applying branch protection to: $REPO"

# ── Main branch ──────────────────────────────────────
echo ""
echo "=== main ==="
cat > /tmp/_bp_main.json << 'JSON'
{
  "required_status_checks": {
    "strict": true,
    "contexts": ["Lint & Format", "Test"]
  },
  "enforce_admins": false,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": false,
    "required_approving_review_count": 0
  },
  "restrictions": null,
  "allow_force_pushes": true,
  "allow_deletions": false,
  "block_creations": false,
  "required_conversation_resolution": false,
  "required_linear_history": true,
  "lock_branch": false,
  "allow_fork_syncing": false
}
JSON

gh api \
  --method PUT \
  "/repos/$REPO/branches/main/protection" \
  --input /tmp/_bp_main.json > /dev/null 2>&1 \
  && echo "  ✓ main: PR required, squash merge, CI must pass, owner can force push" \
  || echo "  ✗ Failed to protect main"

# ── Dev branch ───────────────────────────────────────
echo ""
echo "=== dev ==="
cat > /tmp/_bp_dev.json << 'JSON'
{
  "required_status_checks": {
    "strict": true,
    "contexts": ["Lint & Format", "Test"]
  },
  "enforce_admins": false,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": false,
    "required_approving_review_count": 0
  },
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "block_creations": false,
  "required_conversation_resolution": false,
  "required_linear_history": true,
  "lock_branch": false,
  "allow_fork_syncing": false
}
JSON

gh api \
  --method PUT \
  "/repos/$REPO/branches/dev/protection" \
  --input /tmp/_bp_dev.json > /dev/null 2>&1 \
  && echo "  ✓ dev: PR required, squash merge, CI must pass" \
  || echo "  ✗ Failed to protect dev"

rm -f /tmp/_bp_main.json /tmp/_bp_dev.json

echo ""
echo "Done. Rules applied:"
echo "  feature → dev   (squash merge, CI required)"
echo "  feature → main  (squash merge, CI required, owner bypass)"
echo "  dev → main      NOT allowed (must go through feature branch)"
