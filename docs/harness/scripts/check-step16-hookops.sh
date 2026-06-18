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

echo "== OpenManager HarnessOps Step 16 HookOps Check =="

echo
echo "1. Check step 16 directories"
[ -d "docs/harness/hookops" ] && pass "directory exists: docs/harness/hookops" || fail "missing directory: docs/harness/hookops"
[ -d "docs/harness/templates" ] && pass "directory exists: docs/harness/templates" || fail "missing directory: docs/harness/templates"
[ -d ".claude/skills/om-hookops-review" ] && pass "directory exists: .claude/skills/om-hookops-review" || fail "missing directory: .claude/skills/om-hookops-review"
[ -d "docs/harness/scripts" ] && pass "directory exists: docs/harness/scripts" || fail "missing directory: docs/harness/scripts"

echo
echo "2. Check step 16 files"
check_file_exists "docs/harness/hookops/HOOKOPS_POLICY.md"
check_file_exists "docs/harness/hookops/GUARDRAIL_EXCEPTION_POLICY.md"
check_file_exists "docs/harness/templates/hookops-result-template.md"
check_file_exists ".claude/skills/om-hookops-review/SKILL.md"
check_file_exists "docs/harness/HOOKOPS_INVENTORY.md"
check_file_exists "docs/harness/scripts/check-step16-hookops.sh"

echo
echo "3. Check step 16 files are not empty"
check_file_not_empty "docs/harness/hookops/HOOKOPS_POLICY.md"
check_file_not_empty "docs/harness/hookops/GUARDRAIL_EXCEPTION_POLICY.md"
check_file_not_empty "docs/harness/templates/hookops-result-template.md"
check_file_not_empty ".claude/skills/om-hookops-review/SKILL.md"
check_file_not_empty "docs/harness/HOOKOPS_INVENTORY.md"

echo
echo "4. Check required keywords"
check_contains "docs/harness/hookops/HOOKOPS_POLICY.md" "HookOps"
check_contains "docs/harness/hookops/HOOKOPS_POLICY.md" "위험 명령"
check_contains "docs/harness/hookops/GUARDRAIL_EXCEPTION_POLICY.md" "예외 승인"
check_contains "docs/harness/templates/hookops-result-template.md" "HookOps 검토"
check_contains ".claude/skills/om-hookops-review/SKILL.md" "OpenManager HookOps Review"
check_contains "docs/harness/HOOKOPS_INVENTORY.md" "HookOps 산출물"

echo
echo "5. Check existing hook files are preserved"
check_file_exists ".claude/hooks/om/om-block-dangerous-bash.sh"
check_file_exists ".claude/hooks/om/om-protect-sensitive-files.sh"
check_file_exists ".claude/hooks/om/om-log-tool-usage.sh"

echo
echo "6. Check existing hook shell syntax"
check_shell_syntax ".claude/hooks/om/om-block-dangerous-bash.sh"
check_shell_syntax ".claude/hooks/om/om-protect-sensitive-files.sh"
check_shell_syntax ".claude/hooks/om/om-log-tool-usage.sh"

echo
echo "7. Check step 16 script syntax"
check_shell_syntax "docs/harness/scripts/check-step16-hookops.sh"

echo
echo "8. Check protected local settings are not tracked"
if git ls-files --error-unmatch ".claude/settings.local.json" >/dev/null 2>&1; then
  fail ".claude/settings.local.json is tracked by git"
else
  pass ".claude/settings.local.json is not tracked"
fi

echo
echo "9. Check Git diff does not modify existing hook files"
if git diff --name-only -- .claude/hooks/om/om-block-dangerous-bash.sh .claude/hooks/om/om-protect-sensitive-files.sh .claude/hooks/om/om-log-tool-usage.sh | grep -q .; then
  warn "existing hook files have modifications. Review before commit."
else
  pass "existing hook files are not modified"
fi

echo
echo "== Summary =="
echo "PASS: $PASS"
echo "WARN: $WARN"
echo "FAIL: $FAIL"

if [ "$FAIL" -ne 0 ]; then
  echo "Step 16 HookOps check failed."
  exit 1
fi

echo "Step 16 HookOps check passed."
exit 0