#!/usr/bin/env bash

set -u

INPUT="$(cat)"

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/openmanager/claude-code"
LOG_FILE="${STATE_DIR}/tool-usage.jsonl"

mkdir -p "$STATE_DIR" 2>/dev/null || exit 0

EVENT="$(printf '%s' "$INPUT" | jq -r '.hook_event_name // ""' 2>/dev/null)"
SESSION_ID="$(printf '%s' "$INPUT" | jq -r '.session_id // ""' 2>/dev/null)"
CWD_VALUE="$(printf '%s' "$INPUT" | jq -r '.cwd // ""' 2>/dev/null)"
PERMISSION_MODE="$(printf '%s' "$INPUT" | jq -r '.permission_mode // ""' 2>/dev/null)"
TOOL_NAME="$(printf '%s' "$INPUT" | jq -r '.tool_name // ""' 2>/dev/null)"
TOOL_USE_ID="$(printf '%s' "$INPUT" | jq -r '.tool_use_id // ""' 2>/dev/null)"
DURATION_MS="$(printf '%s' "$INPUT" | jq -r '.duration_ms // ""' 2>/dev/null)"
ERROR_VALUE="$(printf '%s' "$INPUT" | jq -r '.error // ""' 2>/dev/null)"
COMMAND_VALUE="$(printf '%s' "$INPUT" | jq -r '.tool_input.command // ""' 2>/dev/null)"
FILE_PATH_VALUE="$(printf '%s' "$INPUT" | jq -r '.tool_input.file_path // ""' 2>/dev/null)"
URL_VALUE="$(printf '%s' "$INPUT" | jq -r '.tool_input.url // ""' 2>/dev/null)"

safe_hash() {
  local raw_value="$1"

  if [ -z "$raw_value" ]; then
    printf '\n'
    return 0
  fi

  printf '%s' "$raw_value" | sha256sum | awk '{print $1}'
}

command_family() {
  local raw_command="$1"

  if [ -z "$raw_command" ]; then
    printf '\n'
    return 0
  fi

  printf '%s' "$raw_command" \
    | tr '\n' ' ' \
    | awk '{print $1}' \
    | sed -E 's/[^A-Za-z0-9_.:-]/_/g' \
    | cut -c 1-80
}

path_class() {
  local path_value="$1"
  local home_dir="${HOME:-/home/grshin}"

  if [ -z "$path_value" ]; then
    printf 'none\n'
    return 0
  fi

  case "$path_value" in
    */.env|*/.env.*|*/.npmrc|*/.pypirc|*/.netrc|*/credentials|*/credentials.*|*/kubeconfig|*/kubeconfig.*|*/id_rsa|*/id_ed25519)
      printf 'sensitive\n'
      return 0
      ;;
  esac

  if [[ "$path_value" == "$home_dir/.ssh/"* ]]; then
    printf 'sensitive\n'
    return 0
  fi

  if [[ "$path_value" == "$home_dir/.aws/"* ]]; then
    printf 'sensitive\n'
    return 0
  fi

  if [[ "$path_value" == "$home_dir/.kube/"* ]]; then
    printf 'sensitive\n'
    return 0
  fi

  if [[ "$path_value" =~ \.(pem|key|p12|pfx|jks|keystore)$ ]]; then
    printf 'sensitive\n'
    return 0
  fi

  printf 'normal\n'
}

url_host() {
  local raw_url="$1"

  if [ -z "$raw_url" ]; then
    printf '\n'
    return 0
  fi

  printf '%s' "$raw_url" \
    | sed -E 's#^[a-zA-Z][a-zA-Z0-9+.-]*://##' \
    | cut -d '/' -f 1 \
    | cut -d '@' -f 2 \
    | cut -d ':' -f 1 \
    | sed -E 's/[^A-Za-z0-9_.-]/_/g' \
    | cut -c 1-120
}

TS="$(date -Iseconds)"
COMMAND_HASH="$(safe_hash "$COMMAND_VALUE")"
COMMAND_FAMILY="$(command_family "$COMMAND_VALUE")"
FILE_PATH_CLASS="$(path_class "$FILE_PATH_VALUE")"
URL_HOST="$(url_host "$URL_VALUE")"

jq -nc \
  --arg ts "$TS" \
  --arg event "$EVENT" \
  --arg session_id "$SESSION_ID" \
  --arg cwd "$CWD_VALUE" \
  --arg permission_mode "$PERMISSION_MODE" \
  --arg tool_name "$TOOL_NAME" \
  --arg tool_use_id "$TOOL_USE_ID" \
  --arg duration_ms "$DURATION_MS" \
  --arg error_present "$([ -n "$ERROR_VALUE" ] && printf 'true' || printf 'false')" \
  --arg command_family "$COMMAND_FAMILY" \
  --arg command_sha256 "$COMMAND_HASH" \
  --arg file_path_class "$FILE_PATH_CLASS" \
  --arg url_host "$URL_HOST" \
  '{
    ts: $ts,
    event: $event,
    session_id: $session_id,
    cwd: $cwd,
    permission_mode: $permission_mode,
    tool_name: $tool_name,
    tool_use_id: $tool_use_id,
    duration_ms: $duration_ms,
    error_present: ($error_present == "true"),
    command_family: $command_family,
    command_sha256: $command_sha256,
    file_path_class: $file_path_class,
    url_host: $url_host
  }' >> "$LOG_FILE" 2>/dev/null || exit 0

chmod 600 "$LOG_FILE" 2>/dev/null || true

exit 0