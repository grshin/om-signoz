#!/usr/bin/env bash

set -u

PASS_COUNT=0
WARN_COUNT=0
FAIL_COUNT=0

pass() {
  printf 'PASS  %s\n' "$1"
  PASS_COUNT=$((PASS_COUNT + 1))
}

warn() {
  printf 'WARN  %s\n' "$1"
  WARN_COUNT=$((WARN_COUNT + 1))
}

fail() {
  printf 'FAIL  %s\n' "$1"
  FAIL_COUNT=$((FAIL_COUNT + 1))
}

check_file_exists() {
  local file_path="$1"

  if [ -f "$file_path" ]; then
    pass "파일 존재: $file_path"
  else
    fail "파일 없음: $file_path"
  fi
}

check_executable() {
  local file_path="$1"

  if [ -x "$file_path" ]; then
    pass "실행 권한 확인: $file_path"
  else
    fail "실행 권한 없음: $file_path"
  fi
}

check_bash_syntax() {
  local file_path="$1"

  if bash -n "$file_path" 2>/tmp/om-step07-bash-check.err; then
    pass "Shell 문법 정상: $file_path"
  else
    fail "Shell 문법 오류: $file_path"
    sed 's/^/      /' /tmp/om-step07-bash-check.err
  fi
}

check_no_secret_patterns() {
  local file_path="$1"

  if [ ! -f "$file_path" ]; then
    fail "Secret 검사 대상 파일 없음: $file_path"
    return 0
  fi

  if grep -Eiq '(authorization[[:space:]]*:[[:space:]]*bearer[[:space:]]+[A-Za-z0-9._~+/=-]+|api[_-]?key[[:space:]]*[:=][[:space:]]*["'\'']?[A-Za-z0-9._~+/=-]{12,}|client[_-]?secret[[:space:]]*[:=]|password[[:space:]]*[:=]|token[[:space:]]*[:=][[:space:]]*["'\'']?[A-Za-z0-9._~+/=-]{12,})' "$file_path"; then
    fail "Secret 유사 문자열 감지: $file_path"
  else
    pass "Secret 유사 문자열 없음: $file_path"
  fi
}

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$REPO_ROOT" || exit 1

printf '\n'
printf 'OpenManager Claude Code Harness - Step 07 MCP Policy Check\n'
printf 'Repository: %s\n' "$REPO_ROOT"
printf '\n'

check_file_exists ".mcp.json"
check_file_exists "docs/harness/MCP_POLICY.md"
check_file_exists "docs/harness/MCP_SERVERS_INVENTORY.md"
check_file_exists "docs/harness/scripts/check-step07-mcp-policy.sh"

printf '\n'

if command -v jq >/dev/null 2>&1; then
  pass "jq 명령 확인"
else
  fail "jq 명령 없음"
fi

if command -v claude >/dev/null 2>&1; then
  pass "claude 명령 확인"
else
  warn "claude 명령 없음: MCP CLI 상태 확인은 생략됩니다."
fi

printf '\n'

if jq empty .mcp.json >/dev/null 2>&1; then
  pass ".mcp.json JSON 문법 정상"
else
  fail ".mcp.json JSON 문법 오류"
fi

if jq -e '.mcpServers | type == "object"' .mcp.json >/dev/null 2>&1; then
  pass ".mcp.json mcpServers 객체 확인"
else
  fail ".mcp.json mcpServers 객체 없음"
fi

if jq -e 'has("mcpServers")' .mcp.json >/dev/null 2>&1; then
  pass ".mcp.json 최상위 mcpServers 키 확인"
else
  fail ".mcp.json 최상위 mcpServers 키 없음"
fi

MCP_SERVER_COUNT="$(jq '.mcpServers | length' .mcp.json 2>/dev/null || printf '0')"

if [ "$MCP_SERVER_COUNT" = "0" ]; then
  pass "Project Scope MCP 서버 미등록 상태 확인"
else
  warn "Project Scope MCP 서버가 등록되어 있습니다. 등록 서버 수: $MCP_SERVER_COUNT"
fi

printf '\n'

check_no_secret_patterns ".mcp.json"
check_no_secret_patterns "docs/harness/MCP_POLICY.md"
check_no_secret_patterns "docs/harness/MCP_SERVERS_INVENTORY.md"

printf '\n'

if grep -q '최소 권한' docs/harness/MCP_POLICY.md; then
  pass "MCP_POLICY 최소 권한 원칙 확인"
else
  fail "MCP_POLICY 최소 권한 원칙 누락"
fi

if grep -q '인증 정보 비저장' docs/harness/MCP_POLICY.md; then
  pass "MCP_POLICY 인증 정보 비저장 원칙 확인"
else
  fail "MCP_POLICY 인증 정보 비저장 원칙 누락"
fi

if grep -q 'Prompt Injection' docs/harness/MCP_POLICY.md; then
  pass "MCP_POLICY Prompt Injection 위험 언급 확인"
else
  warn "MCP_POLICY Prompt Injection 위험 언급이 없습니다."
fi

if grep -q 'local' docs/harness/MCP_POLICY.md && grep -q 'project' docs/harness/MCP_POLICY.md && grep -q 'user' docs/harness/MCP_POLICY.md; then
  pass "MCP_POLICY Scope 기준 확인"
else
  fail "MCP_POLICY Scope 기준 누락"
fi

if grep -q 'Project Scope MCP 서버' docs/harness/MCP_SERVERS_INVENTORY.md; then
  pass "MCP_SERVERS_INVENTORY Project Scope 섹션 확인"
else
  fail "MCP_SERVERS_INVENTORY Project Scope 섹션 누락"
fi

if grep -q '/status' docs/harness/MCP_SERVERS_INVENTORY.md && grep -q '/mcp' docs/harness/MCP_SERVERS_INVENTORY.md; then
  pass "MCP_SERVERS_INVENTORY 인증 확인 절차 확인"
else
  warn "MCP_SERVERS_INVENTORY 인증 확인 절차 보완 필요"
fi

printf '\n'

check_bash_syntax "docs/harness/scripts/check-step07-mcp-policy.sh"
check_executable "docs/harness/scripts/check-step07-mcp-policy.sh"

printf '\n'

if [ -f ".claude/settings.local.json" ]; then
  if git ls-files --error-unmatch .claude/settings.local.json >/dev/null 2>&1; then
    fail ".claude/settings.local.json 이 Git 추적 대상입니다."
  else
    pass ".claude/settings.local.json Git 미추적 확인"
  fi
else
  pass ".claude/settings.local.json 없음 또는 개인 설정 미사용"
fi

if [ -f "$HOME/.claude.json" ]; then
  if git ls-files --error-unmatch "$HOME/.claude.json" >/dev/null 2>&1; then
    fail "~/.claude.json 이 Git 추적 대상입니다."
  else
    pass "~/.claude.json Git 미추적 확인"
  fi
else
  pass "~/.claude.json 없음 또는 개인 MCP 설정 미사용"
fi

printf '\n'

if command -v claude >/dev/null 2>&1; then
  if claude mcp list >/tmp/om-step07-mcp-list.out 2>/tmp/om-step07-mcp-list.err; then
    pass "claude mcp list 실행 가능"
  else
    warn "claude mcp list 실행 실패 또는 인증 필요 상태입니다. /mcp에서 확인하세요."
  fi
fi

printf '\n'
printf 'Summary: PASS=%s WARN=%s FAIL=%s\n' "$PASS_COUNT" "$WARN_COUNT" "$FAIL_COUNT"

if [ "$FAIL_COUNT" -gt 0 ]; then
  exit 1
fi

exit 0