# OpenManager Jira MCP Inventory

## 문서 목적

본 문서는 OpenManager HarnessOps v2의 Jira MCP 관련 산출물과 관리 기준을 정리한다.

## Jira MCP 산출물 목록

| 구분 | 파일 | 역할 |
|---|---|---|
| Policy | `docs/harness/mcp/JIRA_MCP_POLICY.md` | Jira MCP 사용 정책 |
| Policy | `docs/harness/mcp/READ_ONLY_MCP_POLICY.md` | Read-only MCP 사용 정책 |
| Workflow | `docs/harness/workflows/jira-issue-workflow.md` | Jira Issue 기반 개발 요청 흐름 |
| Template | `docs/harness/templates/jira-issue-analysis-template.md` | Jira Issue 분석 결과 기록 양식 |
| Skill | `.claude/skills/om-jira-readonly-analysis/SKILL.md` | Jira Issue 읽기 전용 분석 Skill |
| Script | `docs/harness/scripts/check-step18-jira-mcp.sh` | 18단계 산출물 점검 스크립트 |

## MCP 연동 기준

| 항목 | 기준 |
|---|---|
| 기본 Scope | local |
| Project Scope | 별도 승인 후 사용 |
| 기본 사용 모드 | Read-only |
| 허용 도구 | read, get, search, list, fetch 계열 |
| 금지 도구 | create, update, delete, transition, comment, assign 계열 |
| 인증 정보 | Git 저장 금지 |
| Token | 문서와 로그에 출력 금지 |

## Jira MCP 사용 목적

Jira MCP는 다음 목적으로 사용한다.

| 목적 | 설명 |
|---|---|
| Issue 조회 | Issue Key 기반 요구사항 확인 |
| Issue 검색 | 관련 Issue 탐색 |
| 요구사항 분석 | Summary, Description, Acceptance Criteria 정리 |
| 영향도 분류 | Backend, Frontend, OTel, Deploy 영향 분류 |
| Spec 연결 | Spec 요청 템플릿으로 전환 |
| Workflow 연결 | Search-First, Change Plan으로 연결 |

## 관련 문서

Jira MCP는 다음 문서와 함께 사용한다.

```text
docs/harness/MCP_POLICY.md
docs/harness/MCP_SERVERS_INVENTORY.md
docs/harness/HOOKOPS_INVENTORY.md
docs/harness/QUALITY_GATES_INVENTORY.md
docs/harness/AUDIT_TRAIL_INVENTORY.md
docs/harness/templates/spec-request-common.md
docs/harness/workflows/search-first-analysis-workflow.md
docs/harness/workflows/change-plan-workflow.md
```

## 점검 기준

18단계 완료 시 다음을 확인한다.

| 항목 | 기준 |
|---|---|
| Jira MCP Policy | 존재하고 비어 있지 않아야 함 |
| Read-only MCP Policy | 존재하고 비어 있지 않아야 함 |
| Jira Issue Workflow | 존재하고 비어 있지 않아야 함 |
| Jira Issue Analysis Template | 존재하고 비어 있지 않아야 함 |
| om-jira-readonly-analysis Skill | YAML frontmatter와 본문이 있어야 함 |
| 점검 스크립트 | 실행 가능해야 함 |
| 인증 정보 | Git에 포함되지 않아야 함 |
| MCP 등록 | Local scope 우선 사용 |

## 운영 기준

Jira MCP는 다음 시점에 점검한다.

| 시점 | 점검 내용 |
|---|---|
| MCP 등록 전 | Scope와 인증 방식 확인 |
| Jira 조회 전 | Read-only 목적 확인 |
| Issue 분석 후 | 민감 정보 포함 여부 확인 |
| 구현 전 | Spec, Search-First, Change Plan 연결 여부 확인 |
| Commit 전 | Jira 분석 결과와 Change History 연결 여부 확인 |
| 월 1회 | MCP 권한과 감사 로그 검토 |

## 금지 사항

다음 변경은 사용자 승인 없이 수행하지 않는다.

- Project scope MCP 등록
- Jira Write 도구 사용
- Jira Issue 수정
- Jira 상태 변경
- Jira 댓글 작성
- API Token 문서화
- MCP 인증 정보를 Git에 저장