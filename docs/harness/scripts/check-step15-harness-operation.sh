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

  if bash -n "$file_path" 2>/tmp/om-step15-bash-check.err; then
    pass "Shell 문법 정상: $file_path"
  else
    fail "Shell 문법 오류: $file_path"
    sed 's/^/      /' /tmp/om-step15-bash-check.err
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
printf 'OpenManager Claude Code Harness - Step 15 Harness Operation Check\n'
printf 'Repository: %s\n' "$REPO_ROOT"
printf '\n'

OPERATION_FILES=(
  "docs/harness/operations/harness-operation-policy.md"
  "docs/harness/operations/harness-maintenance-runbook.md"
)

TEMPLATE_FILES=(
  "docs/harness/templates/harness-release-checklist-template.md"
  "docs/harness/templates/harness-maintenance-review-template.md"
)

SKILL_FILES=(
  ".claude/skills/om-harness-operation/SKILL.md"
)

INVENTORY_FILE="docs/harness/HARNESS_OPERATION_INVENTORY.md"
SCRIPT_FILE="docs/harness/scripts/check-step15-harness-operation.sh"

for operation_file in "${OPERATION_FILES[@]}"; do
  check_file_exists "$operation_file"
done

for template_file in "${TEMPLATE_FILES[@]}"; do
  check_file_exists "$template_file"
done

for skill_file in "${SKILL_FILES[@]}"; do
  check_file_exists "$skill_file"
done

check_file_exists "$INVENTORY_FILE"
check_file_exists "$SCRIPT_FILE"

printf '\n'

for operation_file in "${OPERATION_FILES[@]}"; do
  if [ -f "$operation_file" ]; then
    check_no_secret_patterns "$operation_file"
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

if [ -f "$INVENTORY_FILE" ]; then
  check_no_secret_patterns "$INVENTORY_FILE"
fi

printf '\n'

for skill_file in "${SKILL_FILES[@]}"; do
  if [ -f "$skill_file" ]; then
    check_skill_frontmatter "$skill_file"
  fi
done

printf '\n'

for keyword in \
  "Harness Operation Policy" \
  "운영 적용" \
  "Commit 전 운영 기준" \
  "Push 전 운영 기준" \
  "Secret 및 민감 정보 운영 기준"
do
  if grep -q "$keyword" docs/harness/operations/harness-operation-policy.md; then
    pass "Operation Policy 필수 키워드 확인: $keyword"
  else
    fail "Operation Policy 필수 키워드 누락: $keyword"
  fi
done

printf '\n'

for keyword in \
  "Harness Maintenance RunBook" \
  "유지관리 대상" \
  "Rule 유지관리 기준" \
  "Skill 유지관리 기준" \
  "Hook 유지관리 기준"
do
  if grep -q "$keyword" docs/harness/operations/harness-maintenance-runbook.md; then
    pass "Maintenance RunBook 필수 키워드 확인: $keyword"
  else
    fail "Maintenance RunBook 필수 키워드 누락: $keyword"
  fi
done

printf '\n'

for keyword in \
  "Release 개요" \
  "하네스 구성 요소 영향 확인" \
  "운영 적용 전 필수 확인" \
  "보안 및 민감 정보 점검" \
  "Release 최종 판단"
do
  if grep -q "$keyword" docs/harness/templates/harness-release-checklist-template.md; then
    pass "Release Checklist Template 필수 항목 확인: $keyword"
  else
    fail "Release Checklist Template 필수 항목 누락: $keyword"
  fi
done

printf '\n'

for keyword in \
  "유지관리 리뷰 개요" \
  "하네스 구성 요소 점검" \
  "Rule 리뷰" \
  "Skill 리뷰" \
  "운영 적용 상태 리뷰"
do
  if grep -q "$keyword" docs/harness/templates/harness-maintenance-review-template.md; then
    pass "Maintenance Review Template 필수 항목 확인: $keyword"
  else
    fail "Maintenance Review Template 필수 항목 누락: $keyword"
  fi
done

printf '\n'

for item in \
  "harness-operation-policy.md" \
  "harness-maintenance-runbook.md" \
  "harness-release-checklist-template.md" \
  "harness-maintenance-review-template.md" \
  "om-harness-operation" \
  "check-step15-harness-operation.sh"
do
  if grep -q "$item" "$INVENTORY_FILE"; then
    pass "Inventory 등록 확인: $item"
  else
    fail "Inventory 등록 누락: $item"
  fi
done

printf '\n'

for keyword in \
  "MCP_SERVERS_INVENTORY.md" \
  "QUALITY_GATES_INVENTORY.md" \
  "AUDIT_TRAIL_INVENTORY.md" \
  "SCENARIO_VALIDATION_INVENTORY.md" \
  "HARNESS_OPERATION_INVENTORY.md"
do
  if grep -q "$keyword" "$INVENTORY_FILE"; then
    pass "Inventory 연결 문서 확인: $keyword"
  else
    fail "Inventory 연결 문서 누락: $keyword"
  fi
done

printf '\n'

for keyword in \
  "사용자 승인 없이 운영 명령을 실행하지 않는다" \
  "사용자 승인 없이 Git Push를 실행하지 않는다" \
  "Secret 원문은 읽거나 기록하지 않는다" \
  "기존 SigNoz Playwright Agent는 임의 수정하지 않는다" \
  "통합 점검 스크립트는 작성하지 않는다"
do
  if grep -q "$keyword" "$INVENTORY_FILE"; then
    pass "운영 원칙 확인: $keyword"
  else
    fail "운영 원칙 누락: $keyword"
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

check_bash_syntax "$SCRIPT_FILE"
check_executable "$SCRIPT_FILE"

printf '\n'
printf 'Summary: PASS=%s WARN=%s FAIL=%s\n' "$PASS_COUNT" "$WARN_COUNT" "$FAIL_COUNT"

if [ "$FAIL_COUNT" -gt 0 ]; then
  exit 1
fi

exit 0