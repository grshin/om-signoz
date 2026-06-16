#!/usr/bin/env bash

set -u

REPO_DIR="/home/grshin/project/next-om/om-signoz"

PASS_COUNT=0
FAIL_COUNT=0
WARN_COUNT=0
MANUAL_COUNT=0

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

manual() {
  echo "[MANUAL] $1"
  MANUAL_COUNT=$((MANUAL_COUNT + 1))
}

echo "============================================================"
echo "  OpenManager 하네스 02단계 WSL·Claude Code 완료 확인"
echo "============================================================"

cd "$REPO_DIR" 2>/dev/null || {
  fail "프로젝트 디렉터리로 이동할 수 없습니다: $REPO_DIR"
  exit 1
}

echo
echo "===== 01. 사용자 계정 확인 ====="

CURRENT_USER=$(whoami)

if [ "$CURRENT_USER" = "grshin" ]; then
  pass "현재 사용자: $CURRENT_USER"
else
  fail "현재 사용자가 grshin이 아닙니다: $CURRENT_USER"
fi

echo
echo "===== 02. 홈 디렉터리 확인 ====="

if [ "$HOME" = "/home/grshin" ]; then
  pass "홈 디렉터리 정상: $HOME"
else
  fail "홈 디렉터리가 예상과 다릅니다: $HOME"
fi

echo
echo "===== 03. 프로젝트 경로 확인 ====="

CURRENT_DIR=$(pwd)

if [ "$CURRENT_DIR" = "$REPO_DIR" ]; then
  pass "프로젝트 경로 정상: $CURRENT_DIR"
else
  fail "프로젝트 경로가 예상과 다릅니다: $CURRENT_DIR"
fi

echo
echo "===== 04. WSL2 운영체제 확인 ====="

UNAME_RESULT=$(uname -a)

echo "$UNAME_RESULT"

if echo "$UNAME_RESULT" | grep -qiE 'microsoft.*WSL2|WSL2.*microsoft'; then
  pass "WSL2 Linux 커널 확인"
else
  fail "WSL2 Linux 커널을 확인하지 못했습니다"
fi

if [ -n "${WSL_DISTRO_NAME:-}" ]; then
  pass "WSL 배포판 확인: $WSL_DISTRO_NAME"
else
  warn "WSL_DISTRO_NAME 환경변수를 확인하지 못했습니다"
fi

echo
echo "===== 05. VS Code 명령 확인 ====="

if command -v code >/dev/null 2>&1; then
  pass "VS Code 명령 확인: $(command -v code)"
else
  fail "code 명령을 찾지 못했습니다"
fi

echo
echo "===== 06. Claude Code CLI 확인 ====="

if command -v claude >/dev/null 2>&1; then
  pass "Claude Code CLI 경로: $(command -v claude)"
else
  fail "claude 명령을 찾지 못했습니다"
fi

CLAUDE_VERSION=$(claude --version 2>/dev/null || true)

if [ -n "$CLAUDE_VERSION" ]; then
  pass "Claude Code CLI 버전: $CLAUDE_VERSION"
else
  fail "Claude Code CLI 버전을 확인하지 못했습니다"
fi

echo
echo "===== 07. Sandbox 의존성 확인 ====="

if command -v bwrap >/dev/null 2>&1; then
  pass "bubblewrap 경로: $(command -v bwrap)"
else
  fail "bubblewrap을 찾지 못했습니다"
fi

if command -v socat >/dev/null 2>&1; then
  pass "socat 경로: $(command -v socat)"
else
  fail "socat을 찾지 못했습니다"
fi

echo
echo "===== 08. 로컬 Sandbox 설정 파일 확인 ====="

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
echo "===== 09. Claude Code Extension 설치 여부 참고 확인 ====="

if code --list-extensions 2>/dev/null | grep -qiE 'claude|anthropic'; then
  pass "Claude 관련 VS Code Extension 확인"
else
  warn "Claude 관련 VS Code Extension을 명령으로 확인하지 못했습니다"
  echo "       VS Code Extensions 화면에서 직접 확인하세요."
fi

echo
echo "===== 10. 수동 확인 항목 ====="

manual "VS Code 왼쪽 아래에 WSL: Ubuntu가 표시되는지 확인"
manual "Claude Code /sandbox에서 regular bash permissions가 활성화되어 있는지 확인"
manual "claude doctor 실행 시 치명적인 오류가 없는지 확인"
manual "Claude Code Extension 패널 로그인 상태 확인"

echo
echo "============================================================"
echo "  점검 결과"
echo "============================================================"
echo "PASS   : $PASS_COUNT"
echo "WARN   : $WARN_COUNT"
echo "FAIL   : $FAIL_COUNT"
echo "MANUAL : $MANUAL_COUNT"

if [ "$FAIL_COUNT" -eq 0 ]; then
  echo
  echo "[완료] 02단계 자동 점검 항목이 정상입니다."
  echo "[확인] MANUAL 항목은 화면에서 직접 확인하세요."
  exit 0
else
  echo
  echo "[중단] 02단계 FAIL 항목을 먼저 조치해야 합니다."
  exit 1
fi