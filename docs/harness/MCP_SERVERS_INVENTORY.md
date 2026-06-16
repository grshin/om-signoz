# OpenManager MCP Servers Inventory

## 1. 문서 목적

본 문서는 OpenManager Claude Code 하네스에서 사용하는 MCP 서버의 등록 현황, Scope, 인증 상태, 사용 목적, 위험도를 기록한다.

07단계에서는 Project 공유 MCP 서버를 바로 연결하지 않고, 정책과 Inventory 체계를 먼저 구성한다.

## 2. 현재 기준

| 항목 | 값 |
|---|---|
| 프로젝트 | OpenManager Observability Engine 고도화 |
| 저장소 | SigNoz OSS Fork 기반 |
| 작업 브랜치 | feature/om-harness-bootstrap |
| Project MCP 파일 | `.mcp.json` |
| Project MCP 기본값 | 빈 `mcpServers` |
| 개인 MCP 저장 위치 | `~/.claude.json` |
| 인증 확인 명령 | `/mcp` |
| CLI 확인 명령 | `claude mcp list` |

## 3. MCP Scope 기준

| Scope | 저장 위치 | Git 포함 | OpenManager 사용 기준 |
|---|---|---:|---|
| local | `~/.claude.json`의 현재 프로젝트 항목 | 아니오 | 개인 검증용 |
| project | `.mcp.json` | 예 | 팀 공통 승인 서버 |
| user | `~/.claude.json` | 아니오 | 개인 공통 도구 |

## 4. 현재 Project Scope MCP 서버

07단계 초기 기준으로 Project Scope MCP 서버는 등록하지 않는다.

| 서버명 | Transport | Scope | 인증 | 상태 | 사용 목적 | 위험도 | 비고 |
|---|---|---|---|---|---|---|---|
| 없음 | - | project | - | 미등록 | 정책만 구성 | 낮음 | `.mcp.json`은 빈 서버 목록 유지 |

## 5. `/status` 기준 인증 필요 서버

Claude Code `/status`에서 `MCP servers: 3 need auth`가 표시된 경우, 아래 표에 서버명을 확인 후 기록한다.

| 서버명 | Scope | Transport | 인증 방식 | 사용 목적 | 처리 방향 |
|---|---|---|---|---|---|
| 확인 필요 | 확인 필요 | 확인 필요 | 확인 필요 | 확인 필요 | `/mcp`에서 상세 확인 |
| 확인 필요 | 확인 필요 | 확인 필요 | 확인 필요 | 확인 필요 | `/mcp`에서 상세 확인 |
| 확인 필요 | 확인 필요 | 확인 필요 | 확인 필요 | 확인 필요 | `/mcp`에서 상세 확인 |

## 6. 후보 MCP 서버 검토표

향후 연결 후보가 생기면 아래 표에 기록한다.

| 후보 서버 | 출처 | Transport | 필요 권한 | 인증 방식 | 사용 목적 | 승인 여부 |
|---|---|---|---|---|---|---|
| GitHub MCP | 공식/신뢰 출처 확인 필요 | http | repo read 중심 | OAuth 또는 PAT | Issue/PR 조회 | 미정 |
| Sentry MCP | 공식/신뢰 출처 확인 필요 | http | project read 중심 | OAuth | 오류 조회 | 미정 |
| PostgreSQL MCP | 내부 검토 필요 | stdio | read-only DB | DSN 환경 변수 | Schema 조회 | 미정 |

## 7. 등록 전 확인 체크리스트

Project Scope MCP 서버를 `.mcp.json`에 추가하기 전에 아래 항목을 확인한다.

| 체크 | 항목 |
|---|---|
| [ ] | OpenManager 개발 목적과 직접 관련 있는가 |
| [ ] | 서버 출처가 신뢰 가능한가 |
| [ ] | 인증 정보가 `.mcp.json`에 직접 포함되지 않는가 |
| [ ] | Read-only 권한으로 시작 가능한가 |
| [ ] | 쓰기 작업은 사용자 승인 대상으로 분리되어 있는가 |
| [ ] | 운영 환경에 직접 영향을 주지 않는가 |
| [ ] | Prompt Injection 위험을 검토했는가 |
| [ ] | 제거 방법이 명확한가 |
| [ ] | 07단계 점검 스크립트를 통과하는가 |

## 8. 제거 절차

MCP 서버 제거가 필요한 경우 아래 절차를 따른다.

### Project Scope 서버

```bash
claude mcp remove <server-name>