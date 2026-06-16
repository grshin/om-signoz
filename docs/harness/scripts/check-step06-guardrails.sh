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

  if bash -n "$file_path" 2>/tmp/om-step06-bash-check.err; then
    pass "Shell 문법 정상: $file_path"
  else
    fail "Shell 문법 오류: $file_path"
    sed 's/^/      /' /tmp/om-step06-bash-check.err
  fi
}

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$REPO_ROOT" || exit 1

printf '\n'
printf 'OpenManager Claude Code Harness - Step 06 Guardrail Check\n'
printf 'Repository: %s\n' "$REPO_ROOT"
printf '\n'

check_file_exists ".claude/settings.json"
check_file_exists ".claude/hooks/om/om-block-dangerous-bash.sh"
check_file_exists ".claude/hooks/om/om-protect-sensitive-files.sh"
check_file_exists ".claude/hooks/om/om-log-tool-usage.sh"
check_file_exists "docs/harness/scripts/check-step06-guardrails.sh"

printf '\n'

if command -v jq >/dev/null 2>&1; then
  pass "jq 명령 확인"
else
  fail "jq 명령 없음"
fi

if command -v bwrap >/dev/null 2>&1; then
  pass "bwrap 명령 확인"
else
  warn "bwrap 명령 없음: Claude Code Bash Sandbox가 비활성 또는 경고 상태가 될 수 있습니다."
fi

if command -v socat >/dev/null 2>&1; then
  pass "socat 명령 확인"
else
  warn "socat 명령 없음: Sandbox 네트워크 프록시 기능이 제한될 수 있습니다."
fi

if command -v rg >/dev/null 2>&1; then
  pass "rg 명령 확인"
else
  warn "rg 명령 없음: 검색 성능이 저하될 수 있습니다."
fi

printf '\n'

if jq empty .claude/settings.json >/dev/null 2>&1; then
  pass ".claude/settings.json JSON 문법 정상"
else
  fail ".claude/settings.json JSON 문법 오류"
fi

if jq -e '.permissions.defaultMode == "default"' .claude/settings.json >/dev/null 2>&1; then
  pass "permissions.defaultMode 확인"
else
  fail "permissions.defaultMode 값이 default가 아닙니다."
fi

if jq -e '.permissions.disableBypassPermissionsMode == "disable"' .claude/settings.json >/dev/null 2>&1; then
  pass "bypassPermissions 비활성 설정 확인"
else
  fail "disableBypassPermissionsMode 설정이 없습니다."
fi

if jq -e '.sandbox.enabled == true' .claude/settings.json >/dev/null 2>&1; then
  pass "sandbox.enabled 확인"
else
  fail "sandbox.enabled 값이 true가 아닙니다."
fi

if jq -e '.sandbox.autoAllowBashIfSandboxed == false' .claude/settings.json >/dev/null 2>&1; then
  pass "sandbox.autoAllowBashIfSandboxed=false 확인"
else
  warn "sandbox.autoAllowBashIfSandboxed=false 설정을 확인하세요."
fi

if jq -e '.sandbox.allowUnsandboxedCommands == false' .claude/settings.json >/dev/null 2>&1; then
  pass "sandbox.allowUnsandboxedCommands=false 확인"
else
  warn "sandbox.allowUnsandboxedCommands=false 설정을 확인하세요."
fi

if jq -e '.hooks.PreToolUse | type == "array"' .claude/settings.json >/dev/null 2>&1; then
  pass "PreToolUse Hook 등록 확인"
else
  fail "PreToolUse Hook 등록 없음"
fi

if jq -e '.hooks.PostToolUse | type == "array"' .claude/settings.json >/dev/null 2>&1; then
  pass "PostToolUse Hook 등록 확인"
else
  fail "PostToolUse Hook 등록 없음"
fi

if jq -e '.hooks.PostToolUseFailure | type == "array"' .claude/settings.json >/dev/null 2>&1; then
  pass "PostToolUseFailure Hook 등록 확인"
else
  fail "PostToolUseFailure Hook 등록 없음"
fi

if jq -e 'any(.hooks.PreToolUse[]?; .matcher == "Bash")' .claude/settings.json >/dev/null 2>&1; then
  pass "Bash PreToolUse Hook matcher 확인"
else
  fail "Bash PreToolUse Hook matcher 없음"
fi

if jq -e 'any(.hooks.PreToolUse[]?; .matcher == "Read|Edit|Write")' .claude/settings.json >/dev/null 2>&1; then
  pass "Read/Edit/Write 민감 파일 보호 Hook matcher 확인"
else
  fail "Read/Edit/Write 민감 파일 보호 Hook matcher 없음"
fi

printf '\n'

check_bash_syntax ".claude/hooks/om/om-block-dangerous-bash.sh"
check_bash_syntax ".claude/hooks/om/om-protect-sensitive-files.sh"
check_bash_syntax ".claude/hooks/om/om-log-tool-usage.sh"
check_bash_syntax "docs/harness/scripts/check-step06-guardrails.sh"

printf '\n'

check_executable ".claude/hooks/om/om-block-dangerous-bash.sh"
check_executable ".claude/hooks/om/om-protect-sensitive-files.sh"
check_executable ".claude/hooks/om/om-log-tool-usage.sh"
check_executable "docs/harness/scripts/check-step06-guardrails.sh"

printf '\n'

SAFE_BASH_OUTPUT="$(
  printf '%s' '{"hook_event_name":"PreToolUse","tool_name":"Bash","tool_input":{"command":"git status --short"}}' \
    | bash .claude/hooks/om/om-block-dangerous-bash.sh 2>/dev/null || true
)"

if printf '%s' "$SAFE_BASH_OUTPUT" | jq -e '.hookSpecificOutput.permissionDecision == "deny"' >/dev/null 2>&1; then
  fail "위험 Bash Hook Smoke Test 실패: 안전 명령이 차단되었습니다."
else
  pass "위험 Bash Hook Smoke Test: 안전 명령 허용"
fi

DANGEROUS_BASH_OUTPUT="$(
  printf '%s' '{"hook_event_name":"PreToolUse","tool_name":"Bash","tool_input":{"command":"git reset --hard HEAD"}}' \
    | bash .claude/hooks/om/om-block-dangerous-bash.sh 2>/dev/null || true
)"

if printf '%s' "$DANGEROUS_BASH_OUTPUT" | jq -e '.hookSpecificOutput.permissionDecision == "deny"' >/dev/null 2>&1; then
  pass "위험 Bash Hook Smoke Test: git reset --hard 차단"
else
  fail "위험 Bash Hook Smoke Test 실패: git reset --hard가 차단되지 않았습니다."
fi

printf '\n'

SAFE_FILE_OUTPUT="$(
  printf '%s' '{"hook_event_name":"PreToolUse","tool_name":"Read","cwd":"'"$REPO_ROOT"'","tool_input":{"file_path":"docs/harness/RULES_INVENTORY.md"}}' \
    | bash .claude/hooks/om/om-protect-sensitive-files.sh 2>/dev/null || true
)"

if printf '%s' "$SAFE_FILE_OUTPUT" | jq -e '.hookSpecificOutput.permissionDecision == "deny"' >/dev/null 2>&1; then
  fail "민감 파일 Hook Smoke Test 실패: 일반 문서 경로가 차단되었습니다."
else
  pass "민감 파일 Hook Smoke Test: 일반 문서 경로 허용"
fi

SENSITIVE_FILE_OUTPUT="$(
  printf '%s' '{"hook_event_name":"PreToolUse","tool_name":"Read","cwd":"'"$REPO_ROOT"'","tool_input":{"file_path":"'"${HOME:-/home/grshin}"'/.ssh/id_rsa"}}' \
    | bash .claude/hooks/om/om-protect-sensitive-files.sh 2>/dev/null || true
)"

if printf '%s' "$SENSITIVE_FILE_OUTPUT" | jq -e '.hookSpecificOutput.permissionDecision == "deny"' >/dev/null 2>&1; then
  pass "민감 파일 Hook Smoke Test: SSH 개인키 경로 차단"
else
  fail "민감 파일 Hook Smoke Test 실패: SSH 개인키 경로가 차단되지 않았습니다."
fi

printf '\n'

TMP_STATE_DIR="$(mktemp -d)"
export XDG_STATE_HOME="${TMP_STATE_DIR}/state"

printf '%s' '{"hook_event_name":"PreToolUse","session_id":"step06-smoke","cwd":"'"$REPO_ROOT"'","permission_mode":"default","tool_name":"Bash","tool_use_id":"toolu_step06","tool_input":{"command":"echo super-secret-step06-token"}}' \
  | bash .claude/hooks/om/om-log-tool-usage.sh 2>/dev/null || true

LOG_FILE="${XDG_STATE_HOME}/openmanager/claude-code/tool-usage.jsonl"

if [ -s "$LOG_FILE" ]; then
  pass "도구 사용 로그 Smoke Test: JSONL 로그 생성"
else
  fail "도구 사용 로그 Smoke Test 실패: JSONL 로그가 생성되지 않았습니다."
fi

if [ -f "$LOG_FILE" ] && grep -q 'super-secret-step06-token' "$LOG_FILE"; then
  fail "도구 사용 로그 Smoke Test 실패: Bash 명령 원문이 로그에 저장되었습니다."
else
  pass "도구 사용 로그 Smoke Test: Bash 명령 원문 미저장"
fi

rm -rf "$TMP_STATE_DIR"

printf '\n'

if command -v bwrap >/dev/null 2>&1; then
  if bwrap --ro-bind / / --dev /dev --proc /proc /usr/bin/true >/dev/null 2>&1; then
    pass "bwrap Smoke Test 성공"
  else
    warn "bwrap Smoke Test 실패: WSL2/AppArmor 설정 확인 필요"
  fi
fi

printf '\n'
printf 'Summary: PASS=%s WARN=%s FAIL=%s\n' "$PASS_COUNT" "$WARN_COUNT" "$FAIL_COUNT"

if [ "$FAIL_COUNT" -gt 0 ]; then
  exit 1
fi

exit 0