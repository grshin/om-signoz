# OpenManager Claude Code MCP 및 외부 도구 사용 정책

## 1. 목적

본 문서는 OpenManager 고도화 프로젝트에서 Claude Code가 MCP(Model Context Protocol) 서버와 외부 도구를 사용할 때 적용할 보안, 승인, 운영 기준을 정의한다.

OpenManager 프로젝트는 SigNoz OSS Fork 기반 Observability Engine 고도화 프로젝트이므로, MCP 서버는 개발 생산성을 높이기 위한 보조 수단으로만 사용한다. MCP 서버가 소스코드, 인증 정보, 배포 환경, 운영 데이터에 직접 영향을 줄 수 있으므로 기본 정책은 최소 권한, 명시적 승인, 감사 가능성을 원칙으로 한다.

## 2. 기본 원칙

| 원칙 | 설명 |
|---|---|
| 최소 권한 | MCP 서버는 필요한 범위의 도구와 데이터만 접근해야 한다. |
| 인증 정보 비저장 | Token, PAT, API Key, Client Secret은 Git 저장소에 저장하지 않는다. |
| Project 공유 제한 | 팀 공통 MCP 서버만 `.mcp.json`에 등록한다. |
| Local 우선 | 개인 실험용 MCP 서버는 local scope 또는 user scope로 관리한다. |
| 읽기 우선 | 최초 연결은 Read-only 또는 조회성 기능을 우선한다. |
| 쓰기 작업 승인 | Issue 생성, PR 생성, DB 변경, 배포 명령 등은 사용자의 명시적 승인을 받아야 한다. |
| Prompt Injection 주의 | 외부 콘텐츠를 읽는 MCP 서버는 prompt injection 위험이 있으므로 신뢰된 서버만 사용한다. |
| 감사 가능성 | 주요 MCP 사용은 Claude Code Hook 로그와 Git 변경 이력으로 추적 가능해야 한다. |

## 3. Scope 사용 기준

| Scope | 저장 위치 | Git 포함 여부 | 사용 기준 |
|---|---|---:|---|
| local | `~/.claude.json`의 현재 프로젝트 항목 | 제외 | 개인 실험, 개인 인증, 검증 전 서버 |
| project | 프로젝트 루트 `.mcp.json` | 포함 | 팀 공통으로 승인된 서버 |
| user | `~/.claude.json` | 제외 | 여러 프로젝트에서 개인이 사용하는 서버 |

OpenManager 프로젝트에서는 project scope MCP 서버를 추가할 때 반드시 본 문서의 승인 기준을 따른다.

## 4. 허용 후보 MCP 서버 유형

| 유형 | 예시 | 초기 정책 |
|---|---|---|
| GitHub 조회 | Issue, PR, Review 조회 | 조건부 허용 |
| GitHub 변경 | Issue 생성, PR 생성, Review 작성 | 승인 필요 |
| Monitoring 조회 | Sentry, Observability Dashboard 조회 | 조건부 허용 |
| 문서 조회 | 내부 문서, 공식 문서 조회 | 조건부 허용 |
| DB 조회 | Read-only 계정 기반 Schema/Data 조회 | 제한적 허용 |
| DB 변경 | INSERT, UPDATE, DELETE, DDL | 기본 금지 |
| 배포 도구 | Kubernetes, Helm, Docker 제어 | 기본 금지 |
| 브라우저 자동화 | Playwright, Puppeteer | 테스트 목적만 제한 허용 |
| 메신저/메일 | Slack, Gmail, Calendar | 개인 승인 필요 |
| 결제/계약/고객정보 | Stripe, CRM, ERP | 기본 금지 |

## 5. 금지 대상

다음 MCP 서버 또는 도구 사용은 기본 금지한다.

| 금지 항목 | 설명 |
|---|---|
| 운영 DB 쓰기 권한 | 운영 데이터 변경 위험 |
| 운영 Kubernetes 쓰기 권한 | 서비스 중단 위험 |
| 비밀정보 조회 도구 | Secret, Key, Token 직접 조회 위험 |
| 무검증 커뮤니티 MCP 서버 | 공급망 공격 및 prompt injection 위험 |
| 임의 Shell 실행 MCP 서버 | 로컬 명령 실행 위험 |
| 인증정보를 `.mcp.json`에 직접 포함하는 서버 | Git 유출 위험 |
| 외부 SaaS에 소스코드를 전송하는 서버 | 지식재산 유출 위험 |

## 6. 인증 정보 관리

인증 정보는 다음 위치에 저장하지 않는다.

```text
.mcp.json
.claude/settings.json
.claude/settings.local.json
docs/
.env
README.md
AGENTS.md
CLAUDE.md