# OpenManager Jira MCP Policy

## 문서 목적

본 문서는 OpenManager HarnessOps v2 환경에서 Jira MCP를 사용하는 기준을 정의한다.

Jira MCP는 Jira Issue를 OpenManager 개발 요청의 입력으로 활용하기 위한 외부 도구 연동이다.

이번 정책의 기본 방향은 Read-only 사용이다.

## 적용 대상

본 정책은 다음 작업에 적용한다.

| 대상 | 적용 여부 |
|---|---:|
| Jira Issue 조회 | 적용 |
| Jira Issue 검색 | 적용 |
| Jira Issue 요약 | 적용 |
| Jira Issue 요구사항 분석 | 적용 |
| Jira Issue 기반 Spec 작성 | 적용 |
| Jira Issue 생성 | 금지 |
| Jira Issue 수정 | 금지 |
| Jira Issue 상태 변경 | 금지 |
| Jira 댓글 작성 | 금지 |
| Jira 첨부파일 업로드 | 금지 |

## 기본 원칙

Jira MCP 사용은 다음 원칙을 따른다.

1. Jira MCP는 기본적으로 Read-only로 사용한다.
2. Jira Issue는 개발 요청의 근거 자료로만 사용한다.
3. Jira 데이터를 조회한 뒤 바로 구현하지 않는다.
4. Jira Issue 분석 결과는 Spec, Search-First, Change Plan으로 연결한다.
5. Jira Issue 생성, 수정, 상태 변경, 댓글 작성은 수행하지 않는다.
6. 인증 정보, Token, OAuth Secret은 Git에 저장하지 않는다.
7. Jira에서 가져온 민감 정보는 필요한 범위로만 요약한다.
8. 외부 도구 접근 이력은 Tool Usage Audit 기준으로 기록한다.

## 허용 작업

다음 작업은 허용한다.

| 작업 | 기준 |
|---|---|
| Issue Key 기반 조회 | 사용자가 Issue Key를 제공한 경우 |
| JQL 또는 키워드 검색 | Read-only 검색 목적 |
| Issue 제목 요약 | 개발 요청 분류 목적 |
| Issue 설명 요약 | 요구사항 분석 목적 |
| Acceptance Criteria 추출 | Spec 작성 목적 |
| 관련 Component 확인 | 영향도 분석 목적 |
| Label 확인 | 작업 유형 분류 목적 |
| 담당자와 상태 확인 | 작업 흐름 파악 목적 |

## 금지 작업

다음 작업은 금지한다.

| 작업 | 사유 |
|---|---|
| Issue 생성 | Jira 데이터 변경 |
| Issue Summary 수정 | Jira 데이터 변경 |
| Issue Description 수정 | Jira 데이터 변경 |
| Issue Status 변경 | Workflow 상태 변경 |
| Assignee 변경 | 담당자 변경 |
| Label 추가 또는 삭제 | Jira 데이터 변경 |
| Comment 작성 | Jira 데이터 변경 |
| Attachment 추가 | Jira 데이터 변경 |
| Sprint 변경 | 일정과 계획 영향 |
| Priority 변경 | 업무 우선순위 영향 |

## 인증 및 Secret 관리

Jira MCP 인증은 다음 기준을 따른다.

| 항목 | 기준 |
|---|---|
| OAuth 인증 | 브라우저 기반 인증 사용 가능 |
| API Token | Admin이 허용한 경우에만 사용 |
| Token 저장 | Git 저장 금지 |
| Token 출력 | 터미널, 문서, 로그에 출력 금지 |
| `.env` 저장 | 금지 |
| `.claude/settings.local.json` | Git 추가 금지 |
| `.mcp.json` | Secret 없이 Project scope 공유 시에만 가능 |

## MCP Scope 기준

| Scope | 사용 기준 |
|---|---|
| local | 개인 개발환경에서 우선 사용 |
| user | 여러 프로젝트에서 개인적으로 사용할 때 사용 |
| project | 팀 공유가 필요하고 승인된 경우에만 사용 |

18단계에서는 기본적으로 Local scope를 사용한다.

Project scope MCP 등록은 팀 전체에 영향을 주므로 별도 승인 후 진행한다.

## Jira Issue 분석 결과 사용 기준

Jira Issue 분석 결과는 다음 문서와 연결한다.

```text
docs/harness/templates/jira-issue-analysis-template.md
docs/harness/templates/spec-request-common.md
docs/harness/workflows/search-first-analysis-workflow.md
docs/harness/workflows/change-plan-workflow.md
docs/harness/templates/change-history-template.md
docs/harness/templates/tool-usage-audit-template.md
```

## Jira 데이터 취급 기준

Jira Issue 안에 다음 정보가 포함될 수 있으므로 주의한다.

| 정보 유형 | 처리 기준 |
|---|---|
| 고객사명 | 필요한 경우 요약 |
| 내부 시스템명 | 필요한 경우 요약 |
| 계정 정보 | 출력 금지 |
| Token 또는 Key | 출력 금지 |
| 접속 URL | 필요한 범위만 기록 |
| 장애 내용 | 업무상 필요한 범위만 요약 |
| 개인정보 | 출력 금지 또는 비식별 처리 |

## 사용자 승인 기준

다음 경우에는 사용자 확인을 먼저 받는다.

- Jira Issue 내용이 불명확한 경우
- 요구사항과 구현 범위가 다른 경우
- 운영 영향이 있는 경우
- 보안 영향이 있는 경우
- Jira Issue에 민감 정보가 포함된 경우
- Jira Issue 기반으로 구현을 진행하려는 경우

## 금지 사항

다음 행위는 금지한다.

- Jira Issue를 직접 수정하는 MCP 도구 호출
- Jira 상태 변경
- Jira 댓글 작성
- Jira 첨부파일 업로드
- Jira Issue 내용을 그대로 외부 문서에 복사
- Token 또는 인증 정보를 문서화
- Jira 조회 후 사용자 승인 없이 구현 진행