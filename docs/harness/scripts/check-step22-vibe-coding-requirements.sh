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

  if bash -n "$file_path" 2>/tmp/om-step22-bash-check.err; then
    pass "Shell 문법 정상: $file_path"
  else
    fail "Shell 문법 오류: $file_path"
    sed 's/^/      /' /tmp/om-step22-bash-check.err
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

check_no_eof_marker() {
  local file_path="$1"

  if grep -q '^EOF$' "$file_path"; then
    fail "불필요한 EOF 문자열 감지: $file_path"
  else
    pass "불필요한 EOF 문자열 없음: $file_path"
  fi
}

check_keyword() {
  local file_path="$1"
  local keyword="$2"
  local label="$3"

  if grep -q "$keyword" "$file_path"; then
    pass "$label 확인: $keyword"
  else
    fail "$label 누락: $keyword"
  fi
}

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$REPO_ROOT" || exit 1

printf '\n'
printf 'OpenManager HarnessOps - Step 22 Vibe Coding Requirements Check\n'
printf 'Repository: %s\n' "$REPO_ROOT"
printf '\n'

WORKFLOW_FILES=(
  "docs/harness/workflows/harnessops-vibe-coding-requirements-workflow.md"
)

TEMPLATE_FILES=(
  "docs/harness/templates/signoz-feature-inventory-template.md"
  "docs/harness/templates/om-requirement-candidate-template.md"
  "docs/harness/templates/harnessops-vibe-coding-candidate-template.md"
)

DISCOVERY_FILES=(
  "docs/harness/discovery/signoz-oss-feature-inventory.md"
  "docs/harness/discovery/om-feature-gap-analysis.md"
  "docs/harness/discovery/om-requirements-candidates.md"
  "docs/harness/discovery/harnessops-vibe-coding-candidate.md"
)

INVENTORY_FILE="docs/harness/VIBE_CODING_REQUIREMENTS_INVENTORY.md"
SCRIPT_FILE="docs/harness/scripts/check-step22-vibe-coding-requirements.sh"
REQUIREMENTS_SKILL=".claude/skills/om-requirements-collector/SKILL.md"

printf '1. 22단계 파일 존재 확인\n'
printf '\n'

for file_path in "${WORKFLOW_FILES[@]}"; do
  check_file_exists "$file_path"
done

for file_path in "${TEMPLATE_FILES[@]}"; do
  check_file_exists "$file_path"
done

for file_path in "${DISCOVERY_FILES[@]}"; do
  check_file_exists "$file_path"
done

check_file_exists "$INVENTORY_FILE"
check_file_exists "$SCRIPT_FILE"

printf '\n'
printf '2. 8단계 요구사항 수집 Skill 확인\n'
printf '\n'

if [ -f "$REQUIREMENTS_SKILL" ]; then
  pass "요구사항 수집 Skill 존재: $REQUIREMENTS_SKILL"
else
  fail "요구사항 수집 Skill 없음: $REQUIREMENTS_SKILL"
fi

printf '\n'
printf '3. Secret 유사 문자열 및 불필요한 EOF 확인\n'
printf '\n'

for file_path in "${WORKFLOW_FILES[@]}" "${TEMPLATE_FILES[@]}" "${DISCOVERY_FILES[@]}" "$INVENTORY_FILE"; do
  if [ -f "$file_path" ]; then
    check_no_secret_patterns "$file_path"
    check_no_eof_marker "$file_path"
  fi
done

printf '\n'
printf '4. Template 필수 항목 확인\n'
printf '\n'

check_keyword "docs/harness/templates/signoz-feature-inventory-template.md" "SigNoz OSS Feature Inventory Template" "기능 인벤토리 Template"
check_keyword "docs/harness/templates/signoz-feature-inventory-template.md" "HarnessOps 바이브 코딩 후보 여부" "기능 인벤토리 Template"
check_keyword "docs/harness/templates/om-requirement-candidate-template.md" "OpenManager Requirement Candidate Template" "요구사항 후보 Template"
check_keyword "docs/harness/templates/om-requirement-candidate-template.md" "Acceptance Criteria 후보" "요구사항 후보 Template"
check_keyword "docs/harness/templates/harnessops-vibe-coding-candidate-template.md" "HarnessOps Vibe Coding Candidate Template" "바이브 코딩 후보 Template"
check_keyword "docs/harness/templates/harnessops-vibe-coding-candidate-template.md" "HookOps Runtime Audit" "바이브 코딩 후보 Template"

printf '\n'
printf '5. Workflow 필수 항목 확인\n'
printf '\n'

check_keyword "docs/harness/workflows/harnessops-vibe-coding-requirements-workflow.md" "HarnessOps Vibe Coding Requirements Workflow" "Requirements Workflow"
check_keyword "docs/harness/workflows/harnessops-vibe-coding-requirements-workflow.md" "om-requirements-collector" "Requirements Workflow"
check_keyword "docs/harness/workflows/harnessops-vibe-coding-requirements-workflow.md" "SigNoz OSS 기능 영역 탐색" "Requirements Workflow"
check_keyword "docs/harness/workflows/harnessops-vibe-coding-requirements-workflow.md" "후속 단계 연결" "Requirements Workflow"

printf '\n'
printf '6. Discovery 산출물 필수 항목 확인\n'
printf '\n'

check_keyword "docs/harness/discovery/signoz-oss-feature-inventory.md" "SigNoz OSS Feature Inventory" "기능 인벤토리"
check_keyword "docs/harness/discovery/signoz-oss-feature-inventory.md" "Dashboard" "기능 인벤토리"
check_keyword "docs/harness/discovery/signoz-oss-feature-inventory.md" "OTel Collector" "기능 인벤토리"
check_keyword "docs/harness/discovery/om-feature-gap-analysis.md" "OpenManager Feature Gap Analysis" "Gap 분석"
check_keyword "docs/harness/discovery/om-feature-gap-analysis.md" "OTel Collector OpenManager 설정 Template 보강" "Gap 분석"
check_keyword "docs/harness/discovery/om-requirements-candidates.md" "OpenManager Requirements Candidates" "요구사항 후보"
check_keyword "docs/harness/discovery/om-requirements-candidates.md" "OM-REQ-001" "요구사항 후보"
check_keyword "docs/harness/discovery/harnessops-vibe-coding-candidate.md" "HarnessOps Vibe Coding Candidate" "바이브 코딩 후보"
check_keyword "docs/harness/discovery/harnessops-vibe-coding-candidate.md" "OM-VIBE-001" "바이브 코딩 후보"

printf '\n'
printf '7. Inventory 필수 항목 확인\n'
printf '\n'

check_keyword "$INVENTORY_FILE" "Vibe Coding Requirements Inventory" "Inventory"
check_keyword "$INVENTORY_FILE" "harnessops-vibe-coding-requirements-workflow.md" "Inventory"
check_keyword "$INVENTORY_FILE" "signoz-oss-feature-inventory.md" "Inventory"
check_keyword "$INVENTORY_FILE" "om-feature-gap-analysis.md" "Inventory"
check_keyword "$INVENTORY_FILE" "om-requirements-candidates.md" "Inventory"
check_keyword "$INVENTORY_FILE" "harnessops-vibe-coding-candidate.md" "Inventory"
check_keyword "$INVENTORY_FILE" "check-step22-vibe-coding-requirements.sh" "Inventory"
check_keyword "$INVENTORY_FILE" "OM-VIBE-001" "Inventory"

printf '\n'
printf '8. 기존 Agent / Hook 보존 확인\n'
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

printf '\n'
printf '9. Git 추적 금지 파일 확인\n'
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

printf '\n'
printf '10. 실제 소스 변경 여부 참고 확인\n'
printf '\n'

SOURCE_CHANGE_COUNT="$(git diff --name-only -- \
  ':(exclude)docs/harness/discovery/**' \
  ':(exclude)docs/harness/templates/signoz-feature-inventory-template.md' \
  ':(exclude)docs/harness/templates/om-requirement-candidate-template.md' \
  ':(exclude)docs/harness/templates/harnessops-vibe-coding-candidate-template.md' \
  ':(exclude)docs/harness/workflows/harnessops-vibe-coding-requirements-workflow.md' \
  ':(exclude)docs/harness/VIBE_CODING_REQUIREMENTS_INVENTORY.md' \
  ':(exclude)docs/harness/scripts/check-step22-vibe-coding-requirements.sh' \
  | wc -l | tr -d ' ')"

if [ "$SOURCE_CHANGE_COUNT" = "0" ]; then
  pass "22단계 범위 외 수정 파일 없음"
else
  warn "22단계 범위 외 수정 파일이 있습니다. git diff --name-only 로 확인하세요."
fi

printf '\n'
printf '11. 스크립트 자체 점검\n'
printf '\n'

check_bash_syntax "$SCRIPT_FILE"
check_executable "$SCRIPT_FILE"

printf '\n'
printf 'Summary: PASS=%s WARN=%s FAIL=%s\n' "$PASS_COUNT" "$WARN_COUNT" "$FAIL_COUNT"

if [ "$FAIL_COUNT" -gt 0 ]; then
  exit 1
fi

exit 0