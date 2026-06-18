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

echo "== OpenManager HarnessOps Step 17 Git Worktree Check =="

echo
echo "1. Check git worktree command"
if git worktree list >/dev/null 2>&1; then
  pass "git worktree command available"
else
  fail "git worktree command not available"
fi

echo
echo "2. Check current repository"
if git rev-parse --show-toplevel >/dev/null 2>&1; then
  REPO_ROOT="$(git rev-parse --show-toplevel)"
  pass "git repository detected: $REPO_ROOT"
else
  fail "not a git repository"
  REPO_ROOT=""
fi

echo
echo "3. Check recommended repository path"
if [ "$REPO_ROOT" = "/home/grshin/project/next-om/om-signoz" ]; then
  pass "repository path matches recommended path"
else
  warn "repository path differs from recommended path: $REPO_ROOT"
fi

echo
echo "4. Check step 17 directories"
[ -d "docs/harness/git-worktree" ] && pass "directory exists: docs/harness/git-worktree" || fail "missing directory: docs/harness/git-worktree"
[ -d "docs/harness/templates" ] && pass "directory exists: docs/harness/templates" || fail "missing directory: docs/harness/templates"
[ -d ".claude/skills/om-worktree-review" ] && pass "directory exists: .claude/skills/om-worktree-review" || fail "missing directory: .claude/skills/om-worktree-review"
[ -d "docs/harness/scripts" ] && pass "directory exists: docs/harness/scripts" || fail "missing directory: docs/harness/scripts"

echo
echo "5. Check step 17 files"
check_file_exists "docs/harness/git-worktree/WORKTREE_POLICY.md"
check_file_exists "docs/harness/git-worktree/WORKTREE_RUNBOOK.md"
check_file_exists "docs/harness/templates/worktree-task-template.md"
check_file_exists ".claude/skills/om-worktree-review/SKILL.md"
check_file_exists "docs/harness/WORKTREE_INVENTORY.md"
check_file_exists "docs/harness/scripts/check-step17-git-worktree.sh"

echo
echo "6. Check step 17 files are not empty"
check_file_not_empty "docs/harness/git-worktree/WORKTREE_POLICY.md"
check_file_not_empty "docs/harness/git-worktree/WORKTREE_RUNBOOK.md"
check_file_not_empty "docs/harness/templates/worktree-task-template.md"
check_file_not_empty ".claude/skills/om-worktree-review/SKILL.md"
check_file_not_empty "docs/harness/WORKTREE_INVENTORY.md"

echo
echo "7. Check required keywords"
check_contains "docs/harness/git-worktree/WORKTREE_POLICY.md" "Git Worktree"
check_contains "docs/harness/git-worktree/WORKTREE_POLICY.md" "작업 격리"
check_contains "docs/harness/git-worktree/WORKTREE_RUNBOOK.md" "git worktree add"
check_contains "docs/harness/templates/worktree-task-template.md" "Worktree 정보"
check_contains ".claude/skills/om-worktree-review/SKILL.md" "OpenManager Worktree Review"
check_contains "docs/harness/WORKTREE_INVENTORY.md" "Worktree 산출물"

echo
echo "8. Check step 17 script syntax"
check_shell_syntax "docs/harness/scripts/check-step17-git-worktree.sh"

echo
echo "9. Check protected local settings are not tracked"
if git ls-files --error-unmatch ".claude/settings.local.json" >/dev/null 2>&1; then
  fail ".claude/settings.local.json is tracked by git"
else
  pass ".claude/settings.local.json is not tracked"
fi

echo
echo "10. Check worktree directory is not inside repository"
if [ -d "worktrees" ]; then
  warn "worktrees directory exists inside repository. Recommended path is /home/grshin/project/next-om/worktrees"
else
  pass "no worktrees directory inside repository"
fi

echo
echo "11. Check current worktree list"
git worktree list || warn "unable to list worktrees"

echo
echo "== Summary =="
echo "PASS: $PASS"
echo "WARN: $WARN"
echo "FAIL: $FAIL"

if [ "$FAIL" -ne 0 ]; then
  echo "Step 17 Git Worktree check failed."
  exit 1
fi

echo "Step 17 Git Worktree check passed."
exit 0