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

echo "== OpenManager HarnessOps Step 23 Improvement Spec Check =="

echo
echo "1. Check step 23 directories"

[ -d "docs/harness/improvement" ] && pass "directory exists: docs/harness/improvement" || fail "missing directory: docs/harness/improvement"
[ -d "docs/harness/specs" ] && pass "directory exists: docs/harness/specs" || fail "missing directory: docs/harness/specs"
[ -d "docs/harness/templates" ] && pass "directory exists: docs/harness/templates" || fail "missing directory: docs/harness/templates"
[ -d ".claude/skills/om-improvement-spec-review" ] && pass "directory exists: .claude/skills/om-improvement-spec-review" || fail "missing directory: .claude/skills/om-improvement-spec-review"
[ -d "docs/harness/scripts" ] && pass "directory exists: docs/harness/scripts" || fail "missing directory: docs/harness/scripts"

echo
echo "2. Check step 23 files"

check_file_exists "docs/harness/improvement/IMPROVEMENT_REQUIREMENTS_SELECTION.md"
check_file_exists "docs/harness/specs/OPENMANAGER_SELECTED_SPEC.md"
check_file_exists "docs/harness/templates/improvement-selection-template.md"
check_file_exists "docs/harness/templates/openmanager-spec-template.md"
check_file_exists ".claude/skills/om-improvement-spec-review/SKILL.md"
check_file_exists "docs/harness/IMPROVEMENT_SPEC_INVENTORY.md"
check_file_exists "docs/harness/scripts/check-step23-improvement-spec.sh"

echo
echo "3. Check step 23 files are not empty"

check_file_not_empty "docs/harness/improvement/IMPROVEMENT_REQUIREMENTS_SELECTION.md"
check_file_not_empty "docs/harness/specs/OPENMANAGER_SELECTED_SPEC.md"
check_file_not_empty "docs/harness/templates/improvement-selection-template.md"
check_file_not_empty "docs/harness/templates/openmanager-spec-template.md"
check_file_not_empty ".claude/skills/om-improvement-spec-review/SKILL.md"
check_file_not_empty "docs/harness/IMPROVEMENT_SPEC_INVENTORY.md"

echo
echo "4. Check required keywords"

check_contains "docs/harness/improvement/IMPROVEMENT_REQUIREMENTS_SELECTION.md" "OpenManager Improvement Requirements Selection"
check_contains "docs/harness/improvement/IMPROVEMENT_REQUIREMENTS_SELECTION.md" "OM-FEAT-006"
check_contains "docs/harness/specs/OPENMANAGER_SELECTED_SPEC.md" "OpenManager Selected Improvement Spec"
check_contains "docs/harness/specs/OPENMANAGER_SELECTED_SPEC.md" "OM-SPEC-023-001"
check_contains "docs/harness/templates/improvement-selection-template.md" "OpenManager Improvement Selection Template"
check_contains "docs/harness/templates/openmanager-spec-template.md" "OpenManager Spec Template"
check_contains ".claude/skills/om-improvement-spec-review/SKILL.md" "OpenManager Improvement Spec Review"
check_contains "docs/harness/IMPROVEMENT_SPEC_INVENTORY.md" "23단계 산출물 목록"

echo
echo "5. Check previous required files"

check_file_exists "docs/harness/features/OPENMANAGER_FEATURE_LIST.md"
check_file_exists ".claude/skills/om-requirements-collector/SKILL.md"
check_file_exists "docs/harness/templates/requirements-collection-template.md"
check_file_exists "docs/harness/SKILLS_INVENTORY.md"

echo
echo "6. Check previous feature keyword"

check_contains "docs/harness/features/OPENMANAGER_FEATURE_LIST.md" "OM-FEAT-006"

echo
echo "7. Check step 23 script syntax"

check_shell_syntax "docs/harness/scripts/check-step23-improvement-spec.sh"

echo
echo "8. Check protected local settings are not tracked"

if git ls-files --error-unmatch ".claude/settings.local.json" >/dev/null 2>&1; then
  fail ".claude/settings.local.json is tracked by git"
else
  pass ".claude/settings.local.json is not tracked"
fi

echo
echo "9. Check no obvious sensitive files are staged"

if git diff --cached --name-only | grep -E '(^|/)\.env|settings\.local\.json|credential|secret|token|id_rsa|id_ed25519|\.pem|\.key' >/dev/null 2>&1; then
  fail "sensitive-looking file is staged"
else
  pass "no obvious sensitive file staged"
fi

echo
echo "10. Check source code changes before approval"

SOURCE_CHANGES="$(git status --short | grep -E 'frontend|pkg|cmd|internal|query-service|deploy|charts|k8s|helm' || true)"

if [ -n "$SOURCE_CHANGES" ]; then
  warn "source or deploy related changes detected. Step 23 should not implement source changes."
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
  echo "Step 23 Improvement Spec check failed."
  exit 1
fi

echo "Step 23 Improvement Spec check passed."
exit 0