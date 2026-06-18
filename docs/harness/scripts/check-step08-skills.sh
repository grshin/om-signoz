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

  if bash -n "$file_path" 2>/tmp/om-step08-bash-check.err; then
    pass "Shell 문법 정상: $file_path"
  else
    fail "Shell 문법 오류: $file_path"
    sed 's/^/      /' /tmp/om-step08-bash-check.err
  fi
}

check_skill_frontmatter() {
  local skill_file="$1"

  if sed -n '1p' "$skill_file" | grep -qx -- '---'; then
    pass "Skill frontmatter 시작 확인: $skill_file"
  else
    fail "Skill frontmatter 시작 누락: $skill_file"
  fi

  if sed -n '2,20p' "$skill_file" | grep -qx -- '---'; then
    pass "Skill frontmatter 종료 확인: $skill_file"
  else
    fail "Skill frontmatter 종료 누락: $skill_file"
  fi

  if grep -q '^description:' "$skill_file"; then
    pass "Skill description 확인: $skill_file"
  else
    fail "Skill description 누락: $skill_file"
  fi
}

check_no_secret_patterns() {
  local file_path="$1"

  if grep -Eiq '(authorization[[:space:]]*:[[:space:]]*bearer[[:space:]]+[A-Za-z0-9._~+/=-]+|api[_-]?key[[:space:]]*[:=][[:space:]]*["'\'']?[A-Za-z0-9._~+/=-]{12,}|client[_-]?secret[[:space:]]*[:=]|password[[:space:]]*[:=]|token[[:space:]]*[:=][[:space:]]*["'\'']?[A-Za-z0-9._~+/=-]{12,}|-----BEGIN[[:space:]]+(RSA|OPENSSH|PRIVATE)[[:space:]]+KEY-----)' "$file_path"; then
    fail "Secret 유사 문자열 감지: $file_path"
  else
    pass "Secret 유사 문자열 없음: $file_path"
  fi
}

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$REPO_ROOT" || exit 1

printf '\n'
printf 'OpenManager Claude Code Harness - Step 08 Skills Check\n'
printf 'Repository: %s\n' "$REPO_ROOT"
printf '\n'

SKILL_FILES=(
  ".claude/skills/om-project-context/SKILL.md"
  ".claude/skills/om-rule-router/SKILL.md"
  ".claude/skills/om-change-risk-review/SKILL.md"
  ".claude/skills/om-validation-plan/SKILL.md"
)

for skill_file in "${SKILL_FILES[@]}"; do
  check_file_exists "$skill_file"
done

check_file_exists "docs/harness/SKILLS_INVENTORY.md"
check_file_exists "docs/harness/scripts/check-step08-skills.sh"

printf '\n'

for skill_file in "${SKILL_FILES[@]}"; do
  if [ -f "$skill_file" ]; then
    check_skill_frontmatter "$skill_file"
  fi
done

printf '\n'

for skill_file in "${SKILL_FILES[@]}"; do
  if [ -f "$skill_file" ]; then
    check_no_secret_patterns "$skill_file"
  fi
done

check_no_secret_patterns "docs/harness/SKILLS_INVENTORY.md"

printf '\n'

if grep -q 'om-project-context' docs/harness/SKILLS_INVENTORY.md; then
  pass "Inventory om-project-context 등록 확인"
else
  fail "Inventory om-project-context 등록 누락"
fi

if grep -q 'om-rule-router' docs/harness/SKILLS_INVENTORY.md; then
  pass "Inventory om-rule-router 등록 확인"
else
  fail "Inventory om-rule-router 등록 누락"
fi

if grep -q 'om-change-risk-review' docs/harness/SKILLS_INVENTORY.md; then
  pass "Inventory om-change-risk-review 등록 확인"
else
  fail "Inventory om-change-risk-review 등록 누락"
fi

if grep -q 'om-validation-plan' docs/harness/SKILLS_INVENTORY.md; then
  pass "Inventory om-validation-plan 등록 확인"
else
  fail "Inventory om-validation-plan 등록 누락"
fi

printf '\n'

if grep -q 'disable-model-invocation: true' .claude/skills/om-change-risk-review/SKILL.md; then
  pass "om-change-risk-review 수동 호출 설정 확인"
else
  warn "om-change-risk-review에 disable-model-invocation 설정이 없습니다."
fi

if grep -q 'allowed-tools:' .claude/skills/om-project-context/SKILL.md \
  && grep -q 'allowed-tools:' .claude/skills/om-rule-router/SKILL.md \
  && grep -q 'allowed-tools:' .claude/skills/om-change-risk-review/SKILL.md \
  && grep -q 'allowed-tools:' .claude/skills/om-validation-plan/SKILL.md; then
  pass "모든 Skill allowed-tools 설정 확인"
else
  warn "일부 Skill에 allowed-tools 설정이 없습니다."
fi

printf '\n'

check_bash_syntax "docs/harness/scripts/check-step08-skills.sh"
check_executable "docs/harness/scripts/check-step08-skills.sh"

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
printf 'Summary: PASS=%s WARN=%s FAIL=%s\n' "$PASS_COUNT" "$WARN_COUNT" "$FAIL_COUNT"

if [ "$FAIL_COUNT" -gt 0 ]; then
  exit 1
fi

exit 0