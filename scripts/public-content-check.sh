#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

paths=(
  "README.md"
  "index.html"
  "en"
  "da"
  ".github/ISSUE_TEMPLATE"
  "assets"
  "AGENTS.md"
)

internal_pattern='Repository Settings|Settings ->|Deploy from a branch|Pages ->|for maintainers only|internal note|maintainer-only'
secret_pattern='gh[opusr]_[A-Za-z0-9]{20,}|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY|AKIA[0-9A-Z]{16}|password[[:space:]]*[:=]|secret[[:space:]]*[:=]|token[[:space:]]*[:=]'

echo "Running public-content hygiene checks..."

internal_hits="$(rg -n --hidden -S "$internal_pattern" "${paths[@]}" || true)"
secret_hits="$(rg -n --hidden -S "$secret_pattern" "${paths[@]}" || true)"

if [[ -n "$internal_hits" || -n "$secret_hits" ]]; then
  echo
  echo "FAIL: Public-content check found restricted content."
  if [[ -n "$internal_hits" ]]; then
    echo
    echo "[Internal notes]"
    echo "$internal_hits"
  fi
  if [[ -n "$secret_hits" ]]; then
    echo
    echo "[Secrets/credentials]"
    echo "$secret_hits"
  fi
  exit 1
fi

echo "PASS: No internal notes or secrets detected in public files."
