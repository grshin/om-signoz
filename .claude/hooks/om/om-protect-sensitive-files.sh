#!/usr/bin/env bash

set -u

INPUT="$(cat)"

EVENT="$(printf '%s' "$INPUT" | jq -r '.hook_event_name // ""' 2>/dev/null)"
TOOL_NAME="$(printf '%s' "$INPUT" | jq -r '.tool_name // ""' 2>/dev/null)"
CWD_VALUE="$(printf '%s' "$INPUT" | jq -r '.cwd // ""' 2>/dev/null)"
FILE_PATH="$(printf '%s' "$INPUT" | jq -r '.tool_input.file_path // ""' 2>/dev/null)"

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

normalize_path() {
  local raw_path="$1"
  local base_dir="$2"

  if [ -z "$raw_path" ]; then
    printf '\n'
    return 0
  fi

  if [[ "$raw_path" == ~/* ]]; then
    raw_path="${HOME}${raw_path#~}"
  fi

  if [[ "$raw_path" != /* ]]; then
    if [ -n "$base_dir" ]; then
      raw_path="${base_dir}/${raw_path}"
    else
      raw_path="${PWD}/${raw_path}"
    fi
  fi

  realpath -m "$raw_path" 2>/dev/null || printf '%s\n' "$raw_path"
}

is_sensitive_path() {
  local path_value="$1"
  local home_dir="${HOME:-/home/grshin}"

  if [ -z "$path_value" ]; then
    return 1
  fi

  case "$path_value" in
    */.env|*/.env.*)
      return 0
      ;;
    */.npmrc|*/.pypirc|*/.netrc)
      return 0
      ;;
    */.docker/config.json)
      return 0
      ;;
    */kubeconfig|*/kubeconfig.*)
      return 0
      ;;
    */credentials|*/credentials.*)
      return 0
      ;;
    */id_rsa|*/id_rsa.pub|*/id_ed25519|*/id_ed25519.pub)
      return 0
      ;;
    */.claude/settings.local.json)
      return 0
      ;;
  esac

  if [[ "$path_value" == "$home_dir/.ssh/"* ]]; then
    return 0
  fi

  if [[ "$path_value" == "$home_dir/.aws/"* ]]; then
    return 0
  fi

  if [[ "$path_value" == "$home_dir/.kube/"* ]]; then
    return 0
  fi

  if [[ "$path_value" == "$home_dir/.claude.json" ]]; then
    return 0
  fi

  if [[ "$path_value" == "$home_dir/.claude/settings.json" ]]; then
    return 0
  fi

  if [[ "$path_value" =~ \.(pem|key|p12|pfx|jks|keystore)$ ]]; then
    return 0
  fi

  return 1
}

if [ "$EVENT" != "PreToolUse" ]; then
  exit 0
fi

case "$TOOL_NAME" in
  Read|Edit|Write)
    ;;
  *)
    exit 0
    ;;
esac

NORMALIZED_FILE_PATH="$(normalize_path "$FILE_PATH" "$CWD_VALUE")"

if is_sensitive_path "$NORMALIZED_FILE_PATH"; then
  deny "OpenManager Guardrail: 민감 파일 또는 인증 정보 경로 접근이 차단되었습니다. 대상 경로: ${NORMALIZED_FILE_PATH}"
fi

exit 0