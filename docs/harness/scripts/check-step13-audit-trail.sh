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

  if bash -n "$file_path" 2>/tmp/om-step13-bash-check.err; then
    pass "Shell 문법 정상: $file_path"
  else
    fail "Shell 문법 오류: $file_path"
    sed 's/^/      /' /tmp/om-step13-bash-check.err
  fi
}

check_skill_frontmatter() {
  local skill_file="$1"

  if sed -n '1p' "$skill_file" | grep -qx -- '---'; then
    pass "Skill frontmatter 시작 확인: $skill_file"
  else
    fail "Skill frontmatter 시작 누락: $skill_file"
  fi

  if sed -n '2,25p' "$skill_file" | grep -qx -- '---'; then
    pass "Skill frontmatter 종료 확인: $skill_file"
  else
    fail "Skill frontmatter 종료 누락: $skill_file"
  fi

  if grep -q '^name:' "$skill_file"; then
    pass "Skill name 확인: $skill_file"
  else
    fail "Skill name 누락: $skill_file"
  fi

  if grep -q '^description:' "$skill_file"; then
    pass "Skill description 확인: $skill_file"
  else
    fail "Skill description 누락: $skill_file"
  fi

  if grep -q '^disable-model-invocation: true' "$skill_file"; then
    pass "Skill 수동 호출 설정 확인: $skill_file"
  else
    warn "Skill에 disable-model-invocation 설정이 없습니다: $skill_file"
  fi

  if grep -q '^allowed-tools:' "$skill_file"; then
    pass "Skill allowed-tools 확인: $skill_file"
  else
    fail "Skill allowed-tools 누락: $skill_file"
  fi
}

check_no_secret_patterns() {
  local file_path="$1"

  if grep -Eiq '(authorization[[:space:]]*:[[:space:]]*bearer[[:space:]]+[A-Za-z0-9._~+/=-]+|api[_-]?key[[:space:]]*[:=]|client[_-]?secret[[:space:]]*[:=]|password[[:space:]]*[:=]|token[[:space:]]*[:=]|-----BEGIN[[:space:]]+.*PRIVATE[[:space:]]+KEY-----)' "$file_path"; then
    fail "Secret 유사 문자열 감지: $file_path"
  else
    pass "Secret 유사 문자열 없음: $file_path"
  fi
}

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$REPO_ROOT" || exit 1

printf '\n'
printf 'OpenManager Claude Code Harness - Step 13 Audit Trail Check\n'
printf 'Repository: %s\n' "$REPO_ROOT"
printf '\n'

WORKFLOW_FILES=(
  "docs/harness/workflows/change-history-workflow.md"
  "docs/harness/workflows/tool-usage-audit-workflow.md"
)

TEMPLATE_FILES=(
  "docs/harness/templates/change-history-template.md"
  "docs/harness/templates/tool-usage-audit-template.md"
)

SKILL_FILES=(
  ".claude/skills/om-change-history/SKILL.md"
  ".claude/skills/om-tool-audit/SKILL.md"
)

for workflow_file in "${WORKFLOW_FILES[@]}"; do
  check_file_exists "$workflow_file"
done

for template_file in "${TEMPLATE_FILES[@]}"; do
  check_file_exists "$template_file"
done

for skill_file in "${SKILL_FILES[@]}"; do
  check_file_exists "$skill_file"
done

check_file_exists "docs/harness/AUDIT_TRAIL_INVENTORY.md"
check_file_exists "docs/harness/scripts/check-step13-audit-trail.sh"

printf '\n'

for workflow_file in "${WORKFLOW_FILES[@]}"; do
  if [ -f "$workflow_file" ]; then
    check_no_secret_patterns "$workflow_file"
  fi
done

for template_file in "${TEMPLATE_FILES[@]}"; do
  if [ -f "$template_file" ]; then
    check_no_secret_patterns "$template_file"
  fi
done

for skill_file in "${SKILL_FILES[@]}"; do
  if [ -f "$skill_file" ]; then
    check_no_secret_patterns "$skill_file"
  fi
done

check_no_secret_patterns "docs/harness/AUDIT_TRAIL_INVENTORY.md"

printf '\n'

for skill_file in "${SKILL_FILES[@]}"; do
  if [ -f "$skill_file" ]; then
    check_skill_frontmatter "$skill_file"
  fi
done

printf '\n'

for keyword in \
  "Change History" \
  "변경 이력" \
  "Quality Gate" \
  "Tool 사용 로그"
do
  if grep -q "$keyword" docs/harness/workflows/change-history-workflow.md; then
    pass "Change History Workflow 필수 키워드 확인: $keyword"
  else
    fail "Change History Workflow 필수 키워드 누락: $keyword"
  fi
done

printf '\n'

for keyword in \
  "Tool Usage Audit" \
  "위험 명령" \
  "민감 파일" \
  "운영 명령"
do
  if grep -q "$keyword" docs/harness/workflows/tool-usage-audit-workflow.md; then
    pass "Tool Usage Audit Workflow 필수 키워드 확인: $keyword"
  else
    fail "Tool Usage Audit Workflow 필수 키워드 누락: $keyword"
  fi
done

printf '\n'

for keyword in \
  "변경 이력 개요" \
  "사용자 요청 요약" \
  "검증 결과" \
  "Git 이력"
do
  if grep -q "$keyword" docs/harness/templates/change-history-template.md; then
    pass "Change History Template 필수 항목 확인: $keyword"
  else
    fail "Change History Template 필수 항목 누락: $keyword"
  fi
done

printf '\n'

for keyword in \
  "감사 개요" \
  "Bash 명령 감사" \
  "민감 파일 접근 감사" \
  "Change History 반영 항목"
do
  if grep -q "$keyword" docs/harness/templates/tool-usage-audit-template.md; then
    pass "Tool Usage Audit Template 필수 항목 확인: $keyword"
  else
    fail "Tool Usage Audit Template 필수 항목 누락: $keyword"
  fi
done

printf '\n'

for item in \
  "change-history-workflow.md" \
  "tool-usage-audit-workflow.md" \
  "change-history-template.md" \
  "tool-usage-audit-template.md" \
  "om-change-history" \
  "om-tool-audit" \
  ".claude/logs/tool-usage.log"
do
  if grep -q "$item" docs/harness/AUDIT_TRAIL_INVENTORY.md; then
    pass "Inventory 등록 확인: $item"
  else
    fail "Inventory 등록 누락: $item"
  fi
done

printf '\n'

if git diff --name-only -- .claude/agents/playwright-test-planner.md .claude/agents/playwright-test-generator.md .claude/agents/playwright-test-healer.md | grep -q .; then
  fail "기존 SigNoz Playwright Agent 변경 감지"
else
  pass "기존 SigNoz Playwright Agent 미수정 확인"
fi

if git diff --name-only -- .claude/hooks/om/om-block-dangerous-bash.sh .claude/hooks/om/om-protect-sensitive-files.sh .claude/hooks/om/om-log-tool-usage.sh | grep -q .; then
  fail "기존 Hook 파일 변경 감지"
else
  pass "기존 Hook 파일 미수정 확인"
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

check_bash_syntax "docs/harness/scripts/check-step13-audit-trail.sh"
check_executable "docs/harness/scripts/check-step13-audit-trail.sh"

printf '\n'
printf 'Summary: PASS=%s WARN=%s FAIL=%s\n' "$PASS_COUNT" "$WARN_COUNT" "$FAIL_COUNT"

if [ "$FAIL_COUNT" -gt 0 ]; then
  exit 1
fi

exit 0