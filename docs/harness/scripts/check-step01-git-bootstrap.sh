#!/usr/bin/env bash

set -u

REPO_DIR="/home/grshin/project/next-om/om-signoz"

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

echo "============================================================"
echo "  OpenManager 하네스 01단계 Git Bootstrap 완료 확인"
echo "============================================================"

echo
echo "===== 01. 프로젝트 디렉터리 확인 ====="

if [ -d "$REPO_DIR" ]; then
  pass "프로젝트 디렉터리 존재: $REPO_DIR"
else
  fail "프로젝트 디렉터리 없음: $REPO_DIR"
fi

cd "$REPO_DIR" 2>/dev/null || exit 1

echo
echo "===== 02. Git 저장소 확인 ====="

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  pass "Git 저장소 확인"
else
  fail "Git 저장소가 아닙니다"
fi

ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || true)

if [ "$ROOT_DIR" = "$REPO_DIR" ]; then
  pass "Git Root 경로 정상: $ROOT_DIR"
else
  fail "Git Root 경로가 예상과 다릅니다: $ROOT_DIR"
fi

echo
echo "===== 03. origin Remote 확인 ====="

ORIGIN_URL=$(git remote get-url origin 2>/dev/null || true)

case "$ORIGIN_URL" in
  "git@github.com:grshin/om-signoz.git"|"https://github.com/grshin/om-signoz.git")
    pass "origin Remote 정상: $ORIGIN_URL"
    ;;
  "")
    fail "origin Remote가 등록되어 있지 않습니다"
    ;;
  *)
    fail "origin Remote가 예상과 다릅니다: $ORIGIN_URL"
    ;;
esac

echo
echo "===== 04. upstream Remote 확인 ====="

UPSTREAM_URL=$(git remote get-url upstream 2>/dev/null || true)

case "$UPSTREAM_URL" in
  "https://github.com/SigNoz/signoz.git"|"git@github.com:SigNoz/signoz.git")
    pass "upstream Remote 정상: $UPSTREAM_URL"
    ;;
  "")
    fail "upstream Remote가 등록되어 있지 않습니다"
    ;;
  *)
    fail "upstream Remote가 예상과 다릅니다: $UPSTREAM_URL"
    ;;
esac

echo
echo "===== 05. 로컬 브랜치 확인 ====="

if git show-ref --verify --quiet refs/heads/main; then
  pass "로컬 main 브랜치 존재"
else
  fail "로컬 main 브랜치 없음"
fi

if git show-ref --verify --quiet refs/heads/om-main; then
  pass "로컬 om-main 브랜치 존재"
else
  fail "로컬 om-main 브랜치 없음"
fi

echo
echo "===== 06. Remote Tracking Branch 확인 ====="

if git show-ref --verify --quiet refs/remotes/origin/om-main; then
  pass "origin/om-main Remote Tracking Branch 존재"
else
  warn "origin/om-main Remote Tracking Branch를 확인하지 못했습니다"
fi

if git show-ref --verify --quiet refs/remotes/upstream/main; then
  pass "upstream/main Remote Tracking Branch 존재"
else
  warn "upstream/main Remote Tracking Branch를 확인하지 못했습니다"
  echo "       필요 시 git fetch upstream을 실행하여 최신 상태를 가져오세요."
fi

echo
echo "===== 07. 현재 작업 브랜치 확인 ====="

CURRENT_BRANCH=$(git branch --show-current)

if [ -n "$CURRENT_BRANCH" ]; then
  pass "현재 작업 브랜치: $CURRENT_BRANCH"
else
  fail "현재 작업 브랜치를 확인하지 못했습니다"
fi

echo
echo "===== 08. 기존 Git 추적 파일 변경사항 확인 ====="

if git diff --quiet && git diff --cached --quiet; then
  pass "기존 Git 추적 파일 변경사항 없음"
else
  warn "기존 Git 추적 파일 변경사항이 있습니다"
fi

echo
echo "===== 09. Git 변경사항 출력 ====="

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
  echo "[완료] 01단계 Git Bootstrap 상태가 정상입니다."
  exit 0
else
  echo
  echo "[중단] 01단계 FAIL 항목을 먼저 조치해야 합니다."
  exit 1
fi