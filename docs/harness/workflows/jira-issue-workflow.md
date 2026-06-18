# OpenManager Jira Issue Workflow

## 문서 목적

본 문서는 Jira Issue를 OpenManager 개발 요청의 시작점으로 사용할 때의 표준 Workflow를 정의한다.

Jira Issue는 요구사항의 출처이지만, Jira Issue만으로 바로 구현하지 않는다.

반드시 다음 흐름을 따른다.

```text
Jira Issue 조회
→ Jira Issue 분석
→ Spec 요청 정리
→ Search-First 분석
→ Change Plan 작성
→ 사용자 승인
→ 구현 또는 검증
```

## 적용 대상

본 Workflow는 다음 유형의 Jira Issue에 적용한다.

| Issue 유형 | 적용 여부 |
|---|---:|
| 신규 기능 요청 | 적용 |
| 개선 요청 | 적용 |
| 버그 수정 요청 | 적용 |
| 운영 문의 | 선택 적용 |
| 장애 분석 요청 | 적용 |
| 단순 질의 | 선택 적용 |
| 긴급 운영 변경 | 별도 승인 필요 |

## 기본 원칙

Jira Issue Workflow는 다음 원칙을 따른다.

1. Jira Issue를 먼저 읽고 요약한다.
2. Issue의 요청 목적과 실제 변경 범위를 분리한다.
3. 불명확한 요구사항은 사용자에게 확인한다.
4. Jira Issue 조회 결과만으로 구현하지 않는다.
5. 관련 코드와 문서를 Search-First로 먼저 확인한다.
6. Change Plan 작성 후 사용자 승인 여부를 확인한다.
7. 구현 후에는 Quality Gate와 Change History를 남긴다.

## Workflow 단계

### 1단계. Jira Issue 식별

사용자가 Jira Issue Key 또는 URL을 제공한다.

예시는 다음과 같다.

```text
OM-123
PROJ-456
https://example.atlassian.net/browse/OM-123
```

확인 항목은 다음과 같다.

| 항목 | 내용 |
|---|---|
| Issue Key | |
| Project | |
| Issue Type | |
| Status | |
| Priority | |
| Assignee | |
| Reporter | |

### 2단계. Jira Issue Read-only 조회

MCP를 사용하여 Issue를 조회한다.

조회 기준은 다음과 같다.

| 항목 | 기준 |
|---|---|
| Summary | 요청 제목 파악 |
| Description | 요구사항 파악 |
| Acceptance Criteria | 완료 조건 파악 |
| Labels | 작업 유형 분류 |
| Components | 영향 영역 확인 |
| Linked Issues | 관련 작업 확인 |
| Comments | 필요한 경우 요약만 수행 |

Issue를 수정하지 않는다.

### 3단계. 요청 유형 분류

Jira Issue를 다음 유형 중 하나로 분류한다.

| 유형 | 기준 |
|---|---|
| Backend | API, Service, Query, Storage 변경 |
| Frontend | UI, Component, Route, State 변경 |
| OTel Pipeline | Receiver, Processor, Exporter, ClickHouse 영향 |
| Deploy | Docker, Kubernetes, Helm, Values 변경 |
| Harness | Rule, Skill, Agent, Workflow 변경 |
| Documentation | 문서, RunBook, Guide 변경 |

### 4단계. Spec 요청 정리

Jira Issue 분석 결과를 Spec 요청 템플릿으로 정리한다.

참조 템플릿은 다음과 같다.

```text
docs/harness/templates/spec-request-common.md
docs/harness/templates/spec-request-backend-go.md
docs/harness/templates/spec-request-frontend-react.md
docs/harness/templates/spec-request-otel-pipeline.md
docs/harness/templates/spec-request-deploy-kubernetes.md
```

### 5단계. Search-First 분석

구현 전에 기존 파일, 유사 기능, 기존 API, 문서, 테스트를 먼저 검색한다.

참조 Workflow는 다음과 같다.

```text
docs/harness/workflows/search-first-analysis-workflow.md
docs/harness/templates/search-first-analysis-template.md
```

### 6단계. Change Plan 작성

Search-First 분석 결과를 바탕으로 변경 계획을 작성한다.

참조 Workflow는 다음과 같다.

```text
docs/harness/workflows/change-plan-workflow.md
docs/harness/templates/change-plan-template.md
```

### 7단계. 사용자 승인 확인

다음 경우에는 사용자 승인이 필요하다.

| 상황 | 승인 필요 |
|---|---:|
| 신규 파일 생성 | 필요 |
| SigNoz OSS 원본 수정 | 필요 |
| API 호환성 영향 | 필요 |
| DB 또는 Storage 영향 | 필요 |
| 배포 설정 변경 | 필요 |
| 운영 명령 필요 | 필요 |
| 외부 도구 Write 작업 | 필요 |

### 8단계. 구현 및 검증

승인 후 구현한다.

구현 후 다음 절차를 따른다.

```text
Implementation Validation
→ Quality Gate
→ Change History
→ Tool Usage Audit
```

참조 문서는 다음과 같다.

```text
docs/harness/workflows/implementation-validation-workflow.md
docs/harness/workflows/quality-gate-workflow.md
docs/harness/workflows/change-history-workflow.md
docs/harness/workflows/tool-usage-audit-workflow.md
```

## Jira Issue 분석 결과 기록

Jira Issue 분석 결과는 다음 템플릿에 기록한다.

```text
docs/harness/templates/jira-issue-analysis-template.md
```

## 금지 사항

다음 행위는 금지한다.

- Jira Issue 조회 후 바로 구현
- Jira Issue 수정
- Jira 상태 변경
- Jira 댓글 작성
- Jira Issue의 민감 정보를 그대로 문서화
- 사용자 승인 없이 운영 영향 변경 수행