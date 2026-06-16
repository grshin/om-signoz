#!/usr/bin/env bash

set -u

INPUT="$(cat)"

EVENT="$(printf '%s' "$INPUT" | jq -r '.hook_event_name // ""' 2>/dev/null)"
TOOL_NAME="$(printf '%s' "$INPUT" | jq -r '.tool_name // ""' 2>/dev/null)"
COMMAND="$(printf '%s' "$INPUT" | jq -r '.tool_input.command // ""' 2>/dev/null)"

deny() {
  local reason="$1"

  jq -n --arg reason "$reason" '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: $reason
    }
  }'

  exit 0
}

if [ "$EVENT" != "PreToolUse" ]; then
  exit 0
fi

if [ "$TOOL_NAME" != "Bash" ]; then
  exit 0
fi

if [ -z "$COMMAND" ]; then
  exit 0
fi

NORMALIZED_COMMAND="$(
  printf '%s' "$COMMAND" \
    | tr '\n' ' ' \
    | sed -E 's/[[:space:]]+/ /g; s/^[[:space:]]+//; s/[[:space:]]+$//'
)"

LOWER_COMMAND="$(printf '%s' "$NORMALIZED_COMMAND" | tr '[:upper:]' '[:lower:]')"

if [[ "$LOWER_COMMAND" == *"--dangerously-skip-permissions"* ]]; then
  deny "OpenManager Guardrail: Claude Code 권한 우회 옵션은 사용할 수 없습니다."
fi

if [[ "$LOWER_COMMAND" =~ (^|[[:space:];&|])sudo[[:space:]]+rm[[:space:]]+(-[^[:space:]]*r[^[:space:]]*f|-[^[:space:]]*f[^[:space:]]*r)[[:space:]]+ ]]; then
  deny "OpenManager Guardrail: sudo rm -rf 계열 명령은 차단되었습니다."
fi

if [[ "$LOWER_COMMAND" =~ (^|[[:space:];&|])rm[[:space:]]+(-[^[:space:]]*r[^[:space:]]*f|-[^[:space:]]*f[^[:space:]]*r)[[:space:]]+ ]]; then
  deny "OpenManager Guardrail: rm -rf 계열 명령은 차단되었습니다."
fi

if [[ "$LOWER_COMMAND" =~ (^|[[:space:];&|])find[[:space:]].*[[:space:]]-delete($|[[:space:];&|]) ]]; then
  deny "OpenManager Guardrail: find -delete 명령은 차단되었습니다."
fi

if [[ "$LOWER_COMMAND" =~ (^|[[:space:];&|])git[[:space:]]+reset[[:space:]]+--hard($|[[:space:]]) ]]; then
  deny "OpenManager Guardrail: git reset --hard 명령은 차단되었습니다."
fi

if [[ "$LOWER_COMMAND" =~ (^|[[:space:];&|])git[[:space:]]+clean[[:space:]]+-fdx($|[[:space:]]) ]]; then
  deny "OpenManager Guardrail: git clean -fdx 명령은 차단되었습니다."
fi

if [[ "$LOWER_COMMAND" =~ (^|[[:space:];&|])git[[:space:]]+push[[:space:]].*(--force|-f) ]]; then
  deny "OpenManager Guardrail: 강제 Push 명령은 차단되었습니다."
fi

if [[ "$LOWER_COMMAND" =~ (^|[[:space:];&|])chmod[[:space:]]+-r[[:space:]]+777[[:space:]]+ ]]; then
  deny "OpenManager Guardrail: chmod -R 777 명령은 차단되었습니다."
fi

if [[ "$LOWER_COMMAND" =~ (^|[[:space:];&|])chown[[:space:]]+-r[[:space:]]+ ]]; then
  deny "OpenManager Guardrail: chown -R 명령은 차단되었습니다."
fi

if [[ "$LOWER_COMMAND" =~ (^|[[:space:];&|])mkfs ]]; then
  deny "OpenManager Guardrail: 파일시스템 초기화 명령은 차단되었습니다."
fi

if [[ "$LOWER_COMMAND" =~ (^|[[:space:];&|])dd[[:space:]].*[[:space:]]of=/dev/ ]]; then
  deny "OpenManager Guardrail: 블록 디바이스 대상 dd 명령은 차단되었습니다."
fi

if [[ "$LOWER_COMMAND" =~ (^|[[:space:];&|])kubectl[[:space:]]+delete[[:space:]]+(namespace|ns|all|crd|pv|pvc)($|[[:space:]]) ]]; then
  deny "OpenManager Guardrail: Kubernetes 광역 삭제 명령은 차단되었습니다."
fi

if [[ "$LOWER_COMMAND" =~ (^|[[:space:];&|])kubectl[[:space:]]+delete[[:space:]].*[[:space:]]--all($|[[:space:]]) ]]; then
  deny "OpenManager Guardrail: kubectl delete --all 명령은 차단되었습니다."
fi

if [[ "$LOWER_COMMAND" =~ (^|[[:space:];&|])helm[[:space:]]+uninstall($|[[:space:]]) ]]; then
  deny "OpenManager Guardrail: helm uninstall 명령은 차단되었습니다."
fi

if [[ "$LOWER_COMMAND" =~ (^|[[:space:];&|])docker[[:space:]]+system[[:space:]]+prune ]]; then
  deny "OpenManager Guardrail: docker system prune 명령은 차단되었습니다."
fi

if [[ "$LOWER_COMMAND" =~ (^|[[:space:];&|])docker[[:space:]]+volume[[:space:]]+(prune|rm) ]]; then
  deny "OpenManager Guardrail: docker volume 삭제 명령은 차단되었습니다."
fi

if [[ "$LOWER_COMMAND" =~ (^|[[:space:];&|])(shutdown|reboot|poweroff)($|[[:space:]]) ]]; then
  deny "OpenManager Guardrail: 시스템 종료 또는 재부팅 명령은 차단되었습니다."
fi

exit 0