#!/usr/bin/env bash

set -u

REPO_DIR="/home/grshin/project/next-om/om-signoz"
EXPECTED_BRANCH="feature/om-harness-bootstrap"

PASS_COUNT=0
FAIL_COUNT=0
WARN_COUNT=0
INFO_COUNT=0

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

info() {
  echo "[INFO] $1"
  INFO_COUNT=$((INFO_COUNT + 1))
}

check_file() {
  if [ -f "$1" ]; then
    pass "파일 존재: $1"
  else
    fail "파일 없음: $1"
  fi
}

check_nonempty_file() {
  if [ -s "$1" ]; then
    pass "파일 내용 존재: $1"
  else
    fail "파일이 비어 있습니다: $1"
  fi
}

check_paths_frontmatter() {
  local file="$1"

  if head -n 1 "$file" | grep -qxF -- '---'; then
    pass "YAML Frontmatter 시작 확인: $file"
  else
    fail "YAML Frontmatter 시작 누락: $file"
  fi

  if grep -q '^paths:' "$file"; then
    pass "paths 설정 확인: $file"
  else
    fail "paths 설정 누락: $file"
  fi
}

echo "============================================================"
echo "  OpenManager 하네스 05단계 Rules 완료 확인"
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
echo "===== 02. 루트 Steering 파일 확인 ====="

check_file "CLAUDE.md"
check_file "AGENTS.md"

if grep -qxF '@AGENTS.md' CLAUDE.md; then
  pass "CLAUDE.md에서 AGENTS.md Import 확인"
else
  fail "CLAUDE.md에 @AGENTS.md Import가 없습니다"
fi

echo
echo "===== 03. 공통 Rule 파일 확인 ====="

ALWAYS_RULES=(
  ".claude/rules/om/architecture.md"
  ".claude/rules/om/upstream-boundary.md"
  ".claude/rules/om/security-policy.md"
  ".claude/rules/om/quality-gate.md"
)

for file in "${ALWAYS_RULES[@]}"
do
  check_file "$file"
  check_nonempty_file "$file"

  if grep -q '^paths:' "$file"; then
    warn "공통 Rule에 paths가 설정되어 있습니다: $file"
  else
    pass "공통 Rule 무조건 로딩 구조 확인: $file"
  fi
done

echo
echo "===== 04. 경로별 Rule 파일과 Frontmatter 확인 ====="

PATH_RULES=(
  ".claude/rules/om/backend-go.md"
  ".claude/rules/om/frontend-react.md"
  ".claude/rules/om/otel-pipeline.md"
  ".claude/rules/om/deploy-kubernetes.md"
)

for file in "${PATH_RULES[@]}"
do
  check_file "$file"
  check_nonempty_file "$file"

  if [ -s "$file" ]; then
    check_paths_frontmatter "$file"
  fi
done

echo
echo "===== 05. Rules 목록 문서 확인 ====="

check_file "docs/harness/RULES_INVENTORY.md"
check_nonempty_file "docs/harness/RULES_INVENTORY.md"

echo
echo "===== 06. 필수 문구 확인 ====="

REQUIRED_CHECKS=(
  ".claude/rules/om/architecture.md|SigNoz OSS"
  ".claude/rules/om/upstream-boundary.md|upstream"
  ".claude/rules/om/security-policy.md|Secret"
  ".claude/rules/om/quality-gate.md|git diff --check"
  ".claude/rules/om/backend-go.md|gofmt"
  ".claude/rules/om/frontend-react.md|package.json"
  ".claude/rules/om/otel-pipeline.md|OpenTelemetry"
  ".claude/rules/om/deploy-kubernetes.md|kubectl apply"
)

for item in "${REQUIRED_CHECKS[@]}"
do
  file="${item%%|*}"
  pattern="${item#*|}"

  if grep -qiF "$pattern" "$file"; then
    pass "필수 문구 확인: $file → $pattern"
  else
    fail "필수 문구 누락: $file → $pattern"
  fi
done

echo
echo "===== 07. Placeholder 정리 확인 ====="

if [ -e .claude/rules/om/.gitkeep ]; then
  warn "Rule 파일이 생성되었으므로 .claude/rules/om/.gitkeep 제거를 권장합니다"
else
  pass "Rule Placeholder 제거 확인"
fi

echo
echo "===== 08. 기존 SigNoz Playwright Agent 보존 확인 ====="

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
echo "===== 09. 줄 끝 공백 확인 ====="

TRAILING_SPACES=$(grep -R -n '[[:blank:]]$' \
  .claude/rules/om \
  docs/harness/RULES_INVENTORY.md \
  2>/dev/null || true)

if [ -z "$TRAILING_SPACES" ]; then
  pass "Rules 문서 줄 끝 공백 없음"
else
  warn "Rules 문서에 줄 끝 공백이 있습니다"
  echo "$TRAILING_SPACES"
fi

echo
echo "===== 10. Windows CRLF 줄바꿈 확인 ====="

CRLF_LINES=$(grep -R -n $'\r' \
  .claude/rules/om \
  docs/harness/RULES_INVENTORY.md \
  docs/harness/scripts/check-step05-rules.sh \
  2>/dev/null || true)

if [ -z "$CRLF_LINES" ]; then
  pass "Rules 문서와 Script의 LF 줄바꿈 확인"
else
  warn "Rules 문서 또는 Script에 CRLF 줄바꿈이 있습니다"
  echo "$CRLF_LINES"
fi

echo
echo "===== 11. 후속 단계 산출물 참고 확인 ====="

for file in \
  .claude/settings.json \
  .mcp.json
do
  if [ -e "$file" ]; then
    info "후속 단계 산출물 존재: $file"
  else
    info "후속 단계 산출물 없음: $file"
  fi
done

echo
echo "===== 12. Git 변경사항 확인 ====="

git status --short

echo
echo "============================================================"
echo "  점검 결과"
echo "============================================================"
echo "PASS : $PASS_COUNT"
echo "WARN : $WARN_COUNT"
echo "INFO : $INFO_COUNT"
echo "FAIL : $FAIL_COUNT"

if [ "$FAIL_COUNT" -eq 0 ]; then
  echo
  echo "[완료] 05단계 경로별 Rules 구성이 정상입니다."
  echo "[다음] Claude Code /memory와 Extension 패널에서 Rule 로딩을 확인합니다."
  exit 0
else
  echo
  echo "[중단] 05단계 FAIL 항목을 먼저 조치해야 합니다."
  exit 1
fi