---
name: OpenManager Jira Read-only Analysis
description: OpenManager HarnessOps에서 Jira Issue를 Read-only MCP 기준으로 조회하고, 요구사항, 영향도, Spec 연결 여부를 분석할 때 사용한다.
when_to_use: Jira Issue, Jira MCP, Read-only MCP, Issue 분석, 요구사항 분석, Spec 요청 정리, Search-First 연결이 필요할 때 사용한다.
allowed-tools: Read Grep Glob Bash
---

# OpenManager Jira Read-only Analysis Skill

## 목적

OpenManager HarnessOps 환경에서 Jira Issue를 읽기 전용으로 분석하고, 개발 요청 흐름에 연결한다.

이 Skill은 Jira Issue를 수정하지 않는다.

## 참조 문서

우선 다음 문서를 확인한다.

```text
docs/harness/mcp/JIRA_MCP_POLICY.md
docs/harness/mcp/READ_ONLY_MCP_POLICY.md
docs/harness/workflows/jira-issue-workflow.md
docs/harness/templates/jira-issue-analysis-template.md
docs/harness/JIRA_MCP_INVENTORY.md
```

## 분석 대상

다음 항목을 분석한다.

| 대상 | 분석 내용 |
|---|---|
| Jira Issue Summary | 요청 제목과 목적 |
| Jira Issue Description | 상세 요구사항 |
| Acceptance Criteria | 완료 조건 |
| Labels | 작업 유형 분류 |
| Components | 영향 영역 |
| Linked Issues | 관련 요청 |
| Comments | 필요한 경우 요약 |
| Status | 현재 진행 상태 |
| Priority | 우선순위 |

## 수행 절차

요청을 받으면 다음 순서로 진행한다.

1. 사용자 요청에서 Jira Issue Key 또는 URL을 식별한다.
2. Jira MCP 사용이 Read-only 범위인지 확인한다.
3. Issue 조회 또는 검색만 수행한다.
4. Issue 내용을 요약한다.
5. 요청 유형을 분류한다.
6. 영향 영역을 정리한다.
7. 관련 Rule, Skill, Agent를 제안한다.
8. Spec 요청 정리 필요 여부를 판단한다.
9. Search-First 분석 필요 여부를 판단한다.
10. 사용자 승인 필요 사항을 정리한다.

## 출력 형식

```text
OpenManager Jira Read-only 분석 결과

1. Jira Issue 식별
- Issue Key:
- Issue Type:
- Status:
- Priority:

2. 요청 요약
-

3. 요구사항 정리
- 기능 요구사항:
- 비기능 요구사항:
- 제외 범위:
- 확인 필요 사항:

4. 영향 영역
- Backend:
- Frontend:
- OTel Pipeline:
- Deploy:
- Harness:
- Documentation:

5. 관련 HarnessOps 기준
- Rule:
- Skill:
- Agent:
- Workflow:

6. Read-only MCP 사용 판단
- 허용 여부:
- 사용 도구 유형:
- 금지 도구 여부:

7. 다음 단계
- Spec 요청 정리:
- Search-First 분석:
- Change Plan:
- 사용자 승인:

8. 결론
- 진행 가능 여부:
- 사용자 확인 필요 사항:
- 후속 조치:
```

## 금지 사항

- Jira Issue를 생성하지 않는다.
- Jira Issue를 수정하지 않는다.
- Jira Issue 상태를 변경하지 않는다.
- Jira 댓글을 작성하지 않는다.
- Jira 첨부파일을 업로드하지 않는다.
- 민감 정보를 그대로 출력하지 않는다.
- Jira 조회 결과만으로 바로 구현하지 않는다.
- 사용자 승인 없이 Change Plan 이후 단계로 넘어가지 않는다.