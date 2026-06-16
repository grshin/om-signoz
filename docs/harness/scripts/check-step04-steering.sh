#!/usr/bin/env bash

set -u

cd /home/grshin/project/next-om/om-signoz || exit 1

echo "============================================================"
echo "  OpenManager 하네스 04단계 Steering 완료 확인"
echo "============================================================"

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

echo
echo "===== 01. 현재 브랜치 확인 ====="

CURRENT_BRANCH=$(git branch --show-current)

if [ "$CURRENT_BRANCH" = "feature/om-harness-bootstrap" ]; then
  pass "현재 브랜치: $CURRENT_BRANCH"
else
  fail "현재 브랜치가 feature/om-harness-bootstrap이 아닙니다: $CURRENT_BRANCH"
fi

echo
echo "===== 02. Steering 파일 존재 여부 ====="

check_file "CLAUDE.md"
check_file "AGENTS.md"

echo
echo "===== 03. AGENTS.md Import 확인 ====="

if grep -qxF '@AGENTS.md' CLAUDE.md; then
  pass "CLAUDE.md에서 AGENTS.md Import 확인"
else
  fail "CLAUDE.md에 @AGENTS.md Import가 없습니다"
fi

echo
echo "===== 04. 필수 Steering 문구 확인 ====="

for pattern in \
  "OpenManager Observability Engine" \
  "upstream" \
  "om-main" \
  ".claude/agents/om/" \
  ".claude/rules/om/" \
  ".claude/hooks/om/" \
  ".claude/skills/om-" \
  "Markdown 문서의 설명은 한국어" \
  "git commit" \
  "git push"
do
  if grep -qiF "$pattern" CLAUDE.md AGENTS.md; then
    pass "필수 문구 확인: $pattern"
  else
    fail "필수 문구 누락: $pattern"
  fi
done

echo
echo "===== 05. Steering 파일 줄 수 확인 ====="

CLAUDE_LINES=$(wc -l < CLAUDE.md)
AGENTS_LINES=$(wc -l < AGENTS.md)

echo "CLAUDE.md : $CLAUDE_LINES 줄"
echo "AGENTS.md : $AGENTS_LINES 줄"

if [ "$CLAUDE_LINES" -le 200 ]; then
  pass "CLAUDE.md 200줄 이하"
else
  warn "CLAUDE.md가 200줄을 초과합니다"
fi

if [ "$AGENTS_LINES" -le 200 ]; then
  pass "AGENTS.md 200줄 이하"
else
  warn "AGENTS.md가 200줄을 초과합니다"
fi

echo
echo "===== 06. 기존 SigNoz Playwright Agent 보존 확인 ====="

for file in \
  .claude/agents/playwright-test-generator.md \
  .claude/agents/playwright-test-healer.md \
  .claude/agents/playwright-test-planner.md
do
  check_file "$file"
done

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
echo "===== 07. OM Skeleton 구조 보존 확인 ====="

check_dir ".claude/agents/om"
check_dir ".claude/hooks/om"
check_dir ".claude/rules/om"
check_dir ".claude/skills"
check_dir "docs/harness"
check_dir "docs/harness/templates"

echo
echo "===== 08. Sandbox 로컬 설정 Git 제외 여부 확인 ====="

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
echo "===== 09. 후속 단계용 파일 미생성 상태 확인 ====="

for file in \
  .claude/settings.json \
  .mcp.json
do
  if [ -e "$file" ]; then
    warn "후속 단계용 파일이 이미 존재합니다: $file"
  else
    pass "후속 단계용 파일 미생성 상태 정상: $file"
  fi
done

echo
echo "===== 10. Steering 문서 줄 끝 공백 확인 ====="

TRAILING_SPACES=$(grep -n '[[:blank:]]$' CLAUDE.md AGENTS.md || true)

if [ -z "$TRAILING_SPACES" ]; then
  pass "CLAUDE.md, AGENTS.md 줄 끝 공백 없음"
else
  warn "Steering 문서에 줄 끝 공백이 있습니다"
  echo "$TRAILING_SPACES"
fi

echo
echo "===== 11. Windows CRLF 줄바꿈 확인 ====="

CRLF_LINES=$(grep -n $'\r' CLAUDE.md AGENTS.md || true)

if [ -z "$CRLF_LINES" ]; then
  pass "CLAUDE.md, AGENTS.md LF 줄바꿈 확인"
else
  warn "Steering 문서에 CRLF 줄바꿈이 있습니다"
  echo "$CRLF_LINES"
fi

echo
echo "===== 12. Git 변경사항 확인 ====="

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
  echo "[완료] 04단계 Steering 기본 규칙 구성이 정상입니다."
  echo "[다음] Claude Code /memory 로딩과 읽기 전용 Prompt 검증을 진행합니다."
else
  echo
  echo "[중단] FAIL 항목을 먼저 조치해야 합니다."
fi