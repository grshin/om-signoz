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

  if bash -n "$file_path" 2>/tmp/om-step10-bash-check.err; then
    pass "Shell 문법 정상: $file_path"
  else
    fail "Shell 문법 오류: $file_path"
    sed 's/^/      /' /tmp/om-step10-bash-check.err
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

  if grep -q '^description:' "$skill_file"; then
    pass "Skill description 확인: $skill_file"
  else
    fail "Skill description 누락: $skill_file"
  fi

  if grep -q '^disable-model-invocation: true' "$skill_file"; then
    pass "Spec Skill 수동 호출 설정 확인"
  else
    warn "Spec Skill에 disable-model-invocation 설정이 없습니다."
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
printf 'OpenManager Claude Code Harness - Step 10 Spec Templates Check\n'
printf 'Repository: %s\n' "$REPO_ROOT"
printf '\n'

TEMPLATE_FILES=(
  "docs/harness/templates/spec-request-common.md"
  "docs/harness/templates/spec-request-backend-go.md"
  "docs/harness/templates/spec-request-frontend-react.md"
  "docs/harness/templates/spec-request-otel-pipeline.md"
  "docs/harness/templates/spec-request-deploy-kubernetes.md"
)

for template_file in "${TEMPLATE_FILES[@]}"; do
  check_file_exists "$template_file"
done

check_file_exists ".claude/skills/om-spec-request/SKILL.md"
check_file_exists "docs/harness/SPEC_TEMPLATES_INVENTORY.md"
check_file_exists "docs/harness/scripts/check-step10-spec-templates.sh"

printf '\n'

for template_file in "${TEMPLATE_FILES[@]}"; do
  if [ -f "$template_file" ]; then
    check_no_secret_patterns "$template_file"
  fi
done

check_no_secret_patterns ".claude/skills/om-spec-request/SKILL.md"
check_no_secret_patterns "docs/harness/SPEC_TEMPLATES_INVENTORY.md"

printf '\n'

check_skill_frontmatter ".claude/skills/om-spec-request/SKILL.md"

printf '\n'

for keyword in \
  "요청 개요" \
  "적용 Rule" \
  "검증 계획" \
  "Claude Code 요청 문장"
do
  if grep -q "$keyword" docs/harness/templates/spec-request-common.md; then
    pass "공통 Spec 필수 항목 확인: $keyword"
  else
    fail "공통 Spec 필수 항목 누락: $keyword"
  fi
done

printf '\n'

for template_name in \
  "spec-request-common.md" \
  "spec-request-backend-go.md" \
  "spec-request-frontend-react.md" \
  "spec-request-otel-pipeline.md" \
  "spec-request-deploy-kubernetes.md"
do
  if grep -q "$template_name" docs/harness/SPEC_TEMPLATES_INVENTORY.md; then
    pass "Inventory 템플릿 등록 확인: $template_name"
  else
    fail "Inventory 템플릿 등록 누락: $template_name"
  fi
done

if grep -q 'om-spec-request' docs/harness/SPEC_TEMPLATES_INVENTORY.md; then
  pass "Inventory om-spec-request Skill 등록 확인"
else
  fail "Inventory om-spec-request Skill 등록 누락"
fi

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

check_bash_syntax "docs/harness/scripts/check-step10-spec-templates.sh"
check_executable "docs/harness/scripts/check-step10-spec-templates.sh"

printf '\n'
printf 'Summary: PASS=%s WARN=%s FAIL=%s\n' "$PASS_COUNT" "$WARN_COUNT" "$FAIL_COUNT"

if [ "$FAIL_COUNT" -gt 0 ]; then
  exit 1
fi

exit 0