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

  if bash -n "$file_path" 2>/tmp/om-step09-bash-check.err; then
    pass "Shell 문법 정상: $file_path"
  else
    fail "Shell 문법 오류: $file_path"
    sed 's/^/      /' /tmp/om-step09-bash-check.err
  fi
}

check_agent_frontmatter() {
  local agent_file="$1"

  if sed -n '1p' "$agent_file" | grep -qx -- '---'; then
    pass "Agent frontmatter 시작 확인: $agent_file"
  else
    fail "Agent frontmatter 시작 누락: $agent_file"
  fi

  if sed -n '2,25p' "$agent_file" | grep -qx -- '---'; then
    pass "Agent frontmatter 종료 확인: $agent_file"
  else
    fail "Agent frontmatter 종료 누락: $agent_file"
  fi

  if grep -q '^name:' "$agent_file"; then
    pass "Agent name 확인: $agent_file"
  else
    fail "Agent name 누락: $agent_file"
  fi

  if grep -q '^description:' "$agent_file"; then
    pass "Agent description 확인: $agent_file"
  else
    fail "Agent description 누락: $agent_file"
  fi

  if grep -q '^tools:' "$agent_file"; then
    pass "Agent tools 확인: $agent_file"
  else
    warn "Agent tools 누락: $agent_file"
  fi

  if grep -Eiq '^tools:.*(Edit|Write)' "$agent_file"; then
    fail "Agent tools에 Edit 또는 Write 포함: $agent_file"
  else
    pass "Agent tools Edit/Write 미포함 확인: $agent_file"
  fi
}

check_no_secret_patterns() {
  local file_path="$1"

  if grep -Eiq '(api[_-]?key[[:space:]]*[:=]|client[_-]?secret[[:space:]]*[:=]|password[[:space:]]*[:=]|token[[:space:]]*[:=]|-----BEGIN[[:space:]]+.*PRIVATE[[:space:]]+KEY-----)' "$file_path"; then
    fail "Secret 유사 문자열 감지: $file_path"
  else
    pass "Secret 유사 문자열 없음: $file_path"
  fi
}

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$REPO_ROOT" || exit 1

printf '\n'
printf 'OpenManager Claude Code Harness - Step 09 Agents Check\n'
printf 'Repository: %s\n' "$REPO_ROOT"
printf '\n'

AGENT_FILES=(
  ".claude/agents/om/om-architecture-reviewer.md"
  ".claude/agents/om/om-backend-go-reviewer.md"
  ".claude/agents/om/om-frontend-react-reviewer.md"
  ".claude/agents/om/om-otel-pipeline-reviewer.md"
  ".claude/agents/om/om-deploy-kubernetes-reviewer.md"
  ".claude/agents/om/om-security-quality-reviewer.md"
)

for agent_file in "${AGENT_FILES[@]}"; do
  check_file_exists "$agent_file"
done

check_file_exists "docs/harness/AGENTS_INVENTORY.md"
check_file_exists "docs/harness/scripts/check-step09-agents.sh"

printf '\n'

for agent_file in "${AGENT_FILES[@]}"; do
  if [ -f "$agent_file" ]; then
    check_agent_frontmatter "$agent_file"
  fi
done

printf '\n'

for agent_file in "${AGENT_FILES[@]}"; do
  if [ -f "$agent_file" ]; then
    check_no_secret_patterns "$agent_file"
  fi
done

check_no_secret_patterns "docs/harness/AGENTS_INVENTORY.md"

printf '\n'

for agent_name in \
  om-architecture-reviewer \
  om-backend-go-reviewer \
  om-frontend-react-reviewer \
  om-otel-pipeline-reviewer \
  om-deploy-kubernetes-reviewer \
  om-security-quality-reviewer
do
  if grep -q "$agent_name" docs/harness/AGENTS_INVENTORY.md; then
    pass "Inventory Agent 등록 확인: $agent_name"
  else
    fail "Inventory Agent 등록 누락: $agent_name"
  fi
done

printf '\n'

if git diff --name-only -- .claude/agents/playwright-test-planner.md .claude/agents/playwright-test-generator.md .claude/agents/playwright-test-healer.md | grep -q .; then
  fail "기존 SigNoz Playwright Agent 변경 감지"
else
  pass "기존 SigNoz Playwright Agent 미수정 확인"
fi

if [ -f ".claude/settings.local.json" ]; then
  if git ls-files --error-unmatch .claude/settings.local.json >/dev/null 2>&1; then
    fail ".claude/settings.local.json 이 Git 추적 대상입니다."
  else
    pass ".claude/settings.local.json Git 미추적 확인"
  fi
else
  pass ".claude/settings.local.json 없음 또는 개인 설정 미사용"
fi

printf '\n'

AGENT_NAMES="$(grep -h '^name:' "${AGENT_FILES[@]}" 2>/dev/null | sed 's/^name:[[:space:]]*//' | sort)"
DUPLICATE_NAMES="$(printf '%s\n' "$AGENT_NAMES" | uniq -d)"

if [ -z "$DUPLICATE_NAMES" ]; then
  pass "Agent name 중복 없음"
else
  fail "Agent name 중복 감지: $DUPLICATE_NAMES"
fi

printf '\n'

check_bash_syntax "docs/harness/scripts/check-step09-agents.sh"
check_executable "docs/harness/scripts/check-step09-agents.sh"

printf '\n'
printf 'Summary: PASS=%s WARN=%s FAIL=%s\n' "$PASS_COUNT" "$WARN_COUNT" "$FAIL_COUNT"

if [ "$FAIL_COUNT" -gt 0 ]; then
  exit 1
fi

exit 0