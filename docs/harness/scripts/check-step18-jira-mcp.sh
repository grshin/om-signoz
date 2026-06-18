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

echo "== OpenManager HarnessOps Step 18 Jira MCP Check =="

echo
echo "1. Check command availability"

if command -v claude >/dev/null 2>&1; then
  pass "claude command available"
else
  warn "claude command not found"
fi

if command -v node >/dev/null 2>&1; then
  pass "node command available"
else
  warn "node command not found. Node.js is required for mcp-remote based local proxy."
fi

if command -v npx >/dev/null 2>&1; then
  pass "npx command available"
else
  warn "npx command not found. npx is required for mcp-remote based local proxy."
fi

echo
echo "2. Check step 18 directories"

[ -d "docs/harness/mcp" ] && pass "directory exists: docs/harness/mcp" || fail "missing directory: docs/harness/mcp"
[ -d "docs/harness/workflows" ] && pass "directory exists: docs/harness/workflows" || fail "missing directory: docs/harness/workflows"
[ -d "docs/harness/templates" ] && pass "directory exists: docs/harness/templates" || fail "missing directory: docs/harness/templates"
[ -d ".claude/skills/om-jira-readonly-analysis" ] && pass "directory exists: .claude/skills/om-jira-readonly-analysis" || fail "missing directory: .claude/skills/om-jira-readonly-analysis"
[ -d "docs/harness/scripts" ] && pass "directory exists: docs/harness/scripts" || fail "missing directory: docs/harness/scripts"

echo
echo "3. Check step 18 files"

check_file_exists "docs/harness/mcp/JIRA_MCP_POLICY.md"
check_file_exists "docs/harness/mcp/READ_ONLY_MCP_POLICY.md"
check_file_exists "docs/harness/workflows/jira-issue-workflow.md"
check_file_exists "docs/harness/templates/jira-issue-analysis-template.md"
check_file_exists ".claude/skills/om-jira-readonly-analysis/SKILL.md"
check_file_exists "docs/harness/JIRA_MCP_INVENTORY.md"
check_file_exists "docs/harness/scripts/check-step18-jira-mcp.sh"

echo
echo "4. Check step 18 files are not empty"

check_file_not_empty "docs/harness/mcp/JIRA_MCP_POLICY.md"
check_file_not_empty "docs/harness/mcp/READ_ONLY_MCP_POLICY.md"
check_file_not_empty "docs/harness/workflows/jira-issue-workflow.md"
check_file_not_empty "docs/harness/templates/jira-issue-analysis-template.md"
check_file_not_empty ".claude/skills/om-jira-readonly-analysis/SKILL.md"
check_file_not_empty "docs/harness/JIRA_MCP_INVENTORY.md"

echo
echo "5. Check required keywords"

check_contains "docs/harness/mcp/JIRA_MCP_POLICY.md" "Read-only"
check_contains "docs/harness/mcp/JIRA_MCP_POLICY.md" "Jira MCP"
check_contains "docs/harness/mcp/READ_ONLY_MCP_POLICY.md" "Read-only MCP"
check_contains "docs/harness/workflows/jira-issue-workflow.md" "Jira Issue"
check_contains "docs/harness/templates/jira-issue-analysis-template.md" "Jira Issue Analysis"
check_contains ".claude/skills/om-jira-readonly-analysis/SKILL.md" "OpenManager Jira Read-only Analysis"
check_contains "docs/harness/JIRA_MCP_INVENTORY.md" "Jira MCP 산출물"

echo
echo "6. Check step 18 script syntax"

check_shell_syntax "docs/harness/scripts/check-step18-jira-mcp.sh"

echo
echo "7. Check protected local settings are not tracked"

if git ls-files --error-unmatch ".claude/settings.local.json" >/dev/null 2>&1; then
  fail ".claude/settings.local.json is tracked by git"
else
  pass ".claude/settings.local.json is not tracked"
fi

echo
echo "8. Check obvious secret patterns in step 18 files"

SECRET_HITS="$(grep -RInE 'AT[A-Z0-9_]*TOKEN|Bearer[[:space:]]+[A-Za-z0-9._-]+|api[_-]?token[[:space:]]*[:=]' \
  docs/harness/mcp \
  docs/harness/workflows/jira-issue-workflow.md \
  docs/harness/templates/jira-issue-analysis-template.md \
  .claude/skills/om-jira-readonly-analysis/SKILL.md \
  docs/harness/JIRA_MCP_INVENTORY.md 2>/dev/null || true)"

if [ -n "$SECRET_HITS" ]; then
  warn "possible secret pattern found. Review output below."
  echo "$SECRET_HITS"
else
  pass "no obvious secret pattern found in step 18 files"
fi

echo
echo "9. Check Claude MCP list"

if command -v claude >/dev/null 2>&1; then
  MCP_LIST="$(claude mcp list 2>/dev/null || true)"
  if echo "$MCP_LIST" | grep -Ei 'atlassian|jira|rovo' >/dev/null 2>&1; then
    pass "Atlassian/Jira/Rovo MCP entry found in claude mcp list"
  else
    warn "Atlassian/Jira/Rovo MCP entry not found. Register local MCP if real connection test is required."
  fi
else
  warn "skip claude mcp list because claude command not found"
fi

echo
echo "== Summary =="
echo "PASS: $PASS"
echo "WARN: $WARN"
echo "FAIL: $FAIL"

if [ "$FAIL" -ne 0 ]; then
  echo "Step 18 Jira MCP check failed."
  exit 1
fi

echo "Step 18 Jira MCP check passed."
exit 0