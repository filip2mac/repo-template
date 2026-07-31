#!/usr/bin/env bash
# Apply GitHub repository rulesets from .github/repository_rulesets.json
# Usage: ./scripts/apply-rulesets.sh [owner/repo]
#
# Requires: gh CLI (authenticated)

set -euo pipefail

REPO="${1:-$(gh repo view --json nameWithOwner -q .nameWithOwner)}"
RULESETS_FILE=".github/repository_rulesets.json"

if [[ ! -f "$RULESETS_FILE" ]]; then
    echo "ERROR: $RULESETS_FILE not found"
    exit 1
fi

echo "Applying rulesets to: $REPO"

# Check if ruleset already exists (by name)
RULESET_NAME=$(python3 -c "import json; print(json.load(open('$RULESETS_FILE'))['name'])")
EXISTING=$(gh api "repos/$REPO/rulesets" --jq ".[] | select(.name==\"$RULESET_NAME\") | .id" 2>/dev/null || true)

RULESET_JSON=$(cat "$RULESETS_FILE")

if [[ -n "$EXISTING" ]]; then
    echo "Updating existing ruleset: $RULESET_NAME (id=$EXISTING)"
    echo "$RULESET_JSON" | gh api "repos/$REPO/rulesets/$EXISTING" --method PUT --input -
    echo "Updated: $RULESET_NAME"
else
    echo "Creating new ruleset: $RULESET_NAME"
    echo "$RULESET_JSON" | gh api "repos/$REPO/rulesets" --method POST --input -
    echo "Created: $RULESET_NAME"
fi

echo ""
echo "Ruleset applied. Verifying..."
gh api "repos/$REPO/rulesets" --jq '.[] | "  [\(.id)] \(.name) — enforcement: \(.enforcement)"'
