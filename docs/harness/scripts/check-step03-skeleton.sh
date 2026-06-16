#!/usr/bin/env bash

set -u

REPO_DIR="/home/grshin/project/next-om/om-signoz"
EXPECTED_BRANCH="feature/om-harness-bootstrap"

PASS_COUNT=0
FAIL_COUNT=0
WARN_COUNT=0

pass() {
  echo "[PASS] $1"
  PASS_COUNT=$((PASS_COUNT + 1))
}

fail() {
  echo "[FAIL] $1"
  FAIL_COUNT=$((FAIL_COUNT + 1))
}

warn() {
  echo "[WARN] $1"
  WARN_COUNT=$((WARN_COUNT + 1))
}

check_file() {
  if [ -f "$1" ]; then
    pass "파일 존재: $1"
  else
    fail "파일 없음: $1"
  fi
}

check_dir() {
  if [ -d "$1" ]; then
    pass "디렉터리 존재: $1"
  else
    fail "디렉터리 없음: $1"
  fi
}

echo "============================================================"
echo "  OpenManager 하네스 03단계 Skeleton 완료 확인"
echo "============================================================"

cd "$REPO_DIR" 2>/dev/null || {
  fail "프로젝트 디렉터리로 이동할 수 없습니다: $REPO_DIR"
  exit 1
}

echo
echo "===== 01. 현재 브랜치 확인 ====="

CURRENT_BRANCH=$(git branch --show-current)

if [ "$CURRENT_BRANCH" = "$EXPECTED_BRANCH" ]; then
  pass "현재 브랜치: $CURRENT_BRANCH"
else
  warn "현재 브랜치가 $EXPECTED_BRANCH 브랜치가 아닙니다: $CURRENT_BRANCH"
fi

echo
echo "===== 02. 기존 SigNoz Playwright Agent 보존 확인 ====="

for file in \
  .claude/agents/playwright-test-generator.md \
  .claude/agents/playwright-test-healer.md \
  .claude/agents/playwright-test-planner.md
do
  check_file "$file"

  if git ls-files --error-unmatch "$file" >/dev/null 2>&1; then
    pass "기존 Agent Git 추적 상태 정상: $file"
  else
    fail "기존 Agent가 Git 추적 파일이 아닙니다: $file"
  fi
done

echo
echo "===== 03. 기존 Playwright Agent 수정 여부 확인 ====="

PLAYWRIGHT_DIFF=$(git diff --name-only -- \
  .claude/agents/playwright-test-generator.md \
  .claude/agents/playwright-test-healer.md \
  .claude/agents/playwright-test-planner.md)

if [ -z "$PLAYWRIGHT_DIFF" ]; then
  pass "기존 Playwright Agent 수정사항 없음"
else
  fail "기존 Playwright Agent가 수정되었습니다"
  echo "$PLAYWRIGHT_DIFF"
fi

echo
echo "===== 04. Sandbox 로컬 설정 Git 제외 여부 확인 ====="

if [ -f .claude/settings.local.json ]; then
  pass "로컬 설정 파일 존재: .claude/settings.local.json"
else
  warn "로컬 설정 파일 없음: .claude/settings.local.json"
fi

if git check-ignore -q .claude/settings.local.json; then
  pass "settings.local.json Git 제외 처리 완료"
else
  fail "settings.local.json Git 제외 처리가 필요합니다"
fi

echo
echo "===== 05. OpenManager Skeleton 디렉터리 확인 ====="

check_dir ".claude/agents/om"
check_dir ".claude/hooks/om"
check_dir ".claude/rules/om"
check_dir ".claude/skills"
check_dir "docs/harness"
check_dir "docs/harness/templates"

echo
echo "===== 06. OpenManager Skeleton 추적 파일 확인 ====="

check_file ".claude/agents/om/.gitkeep"
check_file ".claude/hooks/om/.gitkeep"
check_file ".claude/rules/om/.gitkeep"
check_file ".claude/skills/.gitkeep"
check_file "docs/harness/templates/.gitkeep"
check_file "docs/harness/README.md"
check_file "docs/harness/EXISTING_CLAUDE_INVENTORY.md"

echo
echo "===== 07. 후속 단계 산출물 존재 여부 참고 확인 ====="

for file in \
  CLAUDE.md \
  AGENTS.md \
  .claude/settings.json \
  .mcp.json
do
  if [ -e "$file" ]; then
    echo "[INFO] 후속 단계 산출물 존재: $file"
  else
    echo "[INFO] 후속 단계 산출물 없음: $file"
  fi
done

echo
echo "===== 08. Git 변경사항 확인 ====="

git status --short

echo
echo "============================================================"
echo "  점검 결과"
echo "============================================================"
echo "PASS : $PASS_COUNT"
echo "WARN : $WARN_COUNT"
echo "FAIL : $FAIL_COUNT"

if [ "$FAIL_COUNT" -eq 0 ]; then
  echo
  echo "[완료] 03단계 Skeleton 생성 상태가 정상입니다."
  exit 0
else
  echo
  echo "[중단] 03단계 FAIL 항목을 먼저 조치해야 합니다."
  exit 1
fi