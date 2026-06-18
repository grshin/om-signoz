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

echo "== OpenManager HarnessOps Step 19 OpenManager Pilot Check =="

echo
echo "1. Check step 19 directories"

[ -d "docs/harness/pilot" ] && pass "directory exists: docs/harness/pilot" || fail "missing directory: docs/harness/pilot"
[ -d "docs/harness/templates" ] && pass "directory exists: docs/harness/templates" || fail "missing directory: docs/harness/templates"
[ -d ".claude/skills/om-pilot-application" ] && pass "directory exists: .claude/skills/om-pilot-application" || fail "missing directory: .claude/skills/om-pilot-application"
[ -d "docs/harness/scripts" ] && pass "directory exists: docs/harness/scripts" || fail "missing directory: docs/harness/scripts"

echo
echo "2. Check step 19 files"

check_file_exists "docs/harness/pilot/OPENMANAGER_PILOT_PLAN.md"
check_file_exists "docs/harness/pilot/OPENMANAGER_PILOT_RESULT.md"
check_file_exists "docs/harness/templates/pilot-result-template.md"
check_file_exists ".claude/skills/om-pilot-application/SKILL.md"
check_file_exists "docs/harness/PILOT_INVENTORY.md"
check_file_exists "docs/harness/scripts/check-step19-openmanager-pilot.sh"

echo
echo "3. Check step 19 files are not empty"

check_file_not_empty "docs/harness/pilot/OPENMANAGER_PILOT_PLAN.md"
check_file_not_empty "docs/harness/pilot/OPENMANAGER_PILOT_RESULT.md"
check_file_not_empty "docs/harness/templates/pilot-result-template.md"
check_file_not_empty ".claude/skills/om-pilot-application/SKILL.md"
check_file_not_empty "docs/harness/PILOT_INVENTORY.md"

echo
echo "4. Check required keywords"

check_contains "docs/harness/pilot/OPENMANAGER_PILOT_PLAN.md" "Pilot"
check_contains "docs/harness/pilot/OPENMANAGER_PILOT_PLAN.md" "Dashboard"
check_contains "docs/harness/pilot/OPENMANAGER_PILOT_RESULT.md" "Pilot 결과"
check_contains "docs/harness/templates/pilot-result-template.md" "OpenManager Pilot Result Template"
check_contains ".claude/skills/om-pilot-application/SKILL.md" "OpenManager Pilot Application"
check_contains "docs/harness/PILOT_INVENTORY.md" "Pilot 산출물"

echo
echo "5. Check step 19 script syntax"

check_shell_syntax "docs/harness/scripts/check-step19-openmanager-pilot.sh"

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

SOURCE_CHANGES="$(git status --short | grep -E 'frontend|pkg|cmd|internal|query-service|frontend|deploy|charts|k8s|helm' || true)"

if [ -n "$SOURCE_CHANGES" ]; then
  warn "source or deploy related changes detected. Confirm user approval before commit."
  echo "$SOURCE_CHANGES"
else
  pass "no source or deploy related changes detected"
fi

echo
echo "== Summary =="
echo "PASS: $PASS"
echo "WARN: $WARN"
echo "FAIL: $FAIL"

if [ "$FAIL" -ne 0 ]; then
  echo "Step 19 OpenManager Pilot check failed."
  exit 1
fi

echo "Step 19 OpenManager Pilot check passed."
exit 0