#!/usr/bin/env bash
set -u

PASS=0
WARN=0
FAIL=0

pass() {
  echo "[PASS] $1"
  PASS=$((PASS + 1))
}

warn() {
  echo "[WARN] $1"
  WARN=$((WARN + 1))
}

fail() {
  echo "[FAIL] $1"
  FAIL=$((FAIL + 1))
}

check_file_exists() {
  local file="$1"
  if [ -f "$file" ]; then
    pass "file exists: $file"
  else
    fail "missing file: $file"
  fi
}

check_file_not_empty() {
  local file="$1"
  if [ -s "$file" ]; then
    pass "file not empty: $file"
  else
    fail "file empty or missing: $file"
  fi
}

check_contains() {
  local file="$1"
  local pattern="$2"
  if [ -f "$file" ] && grep -q "$pattern" "$file"; then
    pass "contains '$pattern': $file"
  else
    fail "missing '$pattern': $file"
  fi
}

check_shell_syntax() {
  local file="$1"
  if [ -f "$file" ]; then
    if bash -n "$file"; then
      pass "bash syntax ok: $file"
    else
      fail "bash syntax error: $file"
    fi
  else
    fail "missing shell file: $file"
  fi
}

echo "== OpenManager HarnessOps Step 21 Team Onboarding Check =="

echo
echo "1. Check step 21 directories"

[ -d "docs/harness/onboarding" ] && pass "directory exists: docs/harness/onboarding" || fail "missing directory: docs/harness/onboarding"
[ -d "docs/harness/templates" ] && pass "directory exists: docs/harness/templates" || fail "missing directory: docs/harness/templates"
[ -d ".claude/skills/om-team-onboarding-review" ] && pass "directory exists: .claude/skills/om-team-onboarding-review" || fail "missing directory: .claude/skills/om-team-onboarding-review"
[ -d "docs/harness/scripts" ] && pass "directory exists: docs/harness/scripts" || fail "missing directory: docs/harness/scripts"

echo
echo "2. Check step 21 files"

check_file_exists "docs/harness/onboarding/TEAM_ONBOARDING_GUIDE.md"
check_file_exists "docs/harness/onboarding/CLAUDE_CODE_USAGE_GUIDE.md"
check_file_exists "docs/harness/onboarding/HARNESSOPS_TRAINING_SCENARIO.md"
check_file_exists "docs/harness/templates/onboarding-checklist-template.md"
check_file_exists ".claude/skills/om-team-onboarding-review/SKILL.md"
check_file_exists "docs/harness/TEAM_ONBOARDING_INVENTORY.md"
check_file_exists "docs/harness/scripts/check-step21-team-onboarding.sh"

echo
echo "3. Check step 21 files are not empty"

check_file_not_empty "docs/harness/onboarding/TEAM_ONBOARDING_GUIDE.md"
check_file_not_empty "docs/harness/onboarding/CLAUDE_CODE_USAGE_GUIDE.md"
check_file_not_empty "docs/harness/onboarding/HARNESSOPS_TRAINING_SCENARIO.md"
check_file_not_empty "docs/harness/templates/onboarding-checklist-template.md"
check_file_not_empty ".claude/skills/om-team-onboarding-review/SKILL.md"
check_file_not_empty "docs/harness/TEAM_ONBOARDING_INVENTORY.md"

echo
echo "4. Check required keywords"

check_contains "docs/harness/onboarding/TEAM_ONBOARDING_GUIDE.md" "Team Onboarding"
check_contains "docs/harness/onboarding/TEAM_ONBOARDING_GUIDE.md" "Search-First"
check_contains "docs/harness/onboarding/CLAUDE_CODE_USAGE_GUIDE.md" "Claude Code"
check_contains "docs/harness/onboarding/CLAUDE_CODE_USAGE_GUIDE.md" "사용자 승인"
check_contains "docs/harness/onboarding/HARNESSOPS_TRAINING_SCENARIO.md" "Training Scenario"
check_contains "docs/harness/templates/onboarding-checklist-template.md" "Onboarding Checklist"
check_contains ".claude/skills/om-team-onboarding-review/SKILL.md" "OpenManager Team Onboarding Review"
check_contains "docs/harness/TEAM_ONBOARDING_INVENTORY.md" "Team Onboarding 산출물"

echo
echo "5. Check step 21 script syntax"

check_shell_syntax "docs/harness/scripts/check-step21-team-onboarding.sh"

echo
echo "6. Check protected local settings are not tracked"

if git ls-files --error-unmatch ".claude/settings.local.json" >/dev/null 2>&1; then
  fail ".claude/settings.local.json is tracked by git"
else
  pass ".claude/settings.local.json is not tracked"
fi

echo
echo "7. Check no obvious sensitive files are staged"

if git diff --cached --name-only | grep -E '(^|/)\.env|settings\.local\.json|credential|secret|token' >/dev/null 2>&1; then
  fail "sensitive-looking file is staged"
else
  pass "no obvious sensitive file staged"
fi

echo
echo "8. Check source code changes before approval"

SOURCE_CHANGES="$(git status --short | grep -E 'frontend|pkg|cmd|internal|query-service|deploy|charts|k8s|helm' || true)"

if [ -n "$SOURCE_CHANGES" ]; then
  warn "source or deploy related changes detected. Confirm user approval before commit."
  echo "$SOURCE_CHANGES"
else
  pass "no source or deploy related changes detected"
fi

echo
echo "9. Check previous v2 inventory files exist"

check_file_exists "docs/harness/HOOKOPS_INVENTORY.md"
check_file_exists "docs/harness/WORKTREE_INVENTORY.md"
check_file_exists "docs/harness/JIRA_MCP_INVENTORY.md"
check_file_exists "docs/harness/PILOT_INVENTORY.md"
check_file_exists "docs/harness/LESSONS_METRICS_INVENTORY.md"

echo
echo "== Summary =="
echo "PASS: $PASS"
echo "WARN: $WARN"
echo "FAIL: $FAIL"

if [ "$FAIL" -ne 0 ]; then
  echo "Step 21 Team Onboarding check failed."
  exit 1
fi

echo "Step 21 Team Onboarding check passed."
exit 0