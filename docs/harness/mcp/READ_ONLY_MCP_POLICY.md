# OpenManager Read-only MCP Policy

## 문서 목적

본 문서는 OpenManager HarnessOps v2 환경에서 외부 MCP 도구를 Read-only 기준으로 사용하는 정책을 정의한다.

Read-only MCP는 외부 시스템의 데이터를 조회하고 분석하는 데만 사용하며, 외부 시스템의 상태나 데이터를 변경하지 않는다.

## 적용 대상

본 정책은 다음 외부 도구에 적용할 수 있다.

| 도구 | Read-only 사용 예 |
|---|---|
| Jira | Issue 조회, 검색, 요약 |
| Confluence | 문서 조회, 요약 |
| GitHub | Issue, PR, 파일 조회 |
| Sentry | Error 조회, 이벤트 분석 |
| Monitoring | Alert, Metric, Log 조회 |

18단계에서는 Jira를 우선 적용 대상으로 한다.

## Read-only 기본 원칙

Read-only MCP 사용 원칙은 다음과 같다.

1. 외부 시스템의 데이터를 변경하지 않는다.
2. 조회 결과를 근거로 바로 구현하지 않는다.
3. 조회 결과는 Spec, Search-First, Change Plan의 입력으로만 사용한다.
4. 민감 정보는 그대로 복사하지 않는다.
5. 외부 도구 호출 목적과 결과를 감사 가능하게 기록한다.
6. Write 기능이 가능한 MCP 서버라도 정책상 Read-only 도구만 사용한다.
7. Write 도구가 필요한 경우 별도 승인 Workflow를 먼저 구성한다.

## 허용 작업

다음 작업은 허용한다.

| 작업 | 기준 |
|---|---|
| 검색 | 업무 요청 식별 목적 |
| 조회 | Issue, 문서, Alert 확인 목적 |
| 요약 | 요구사항 또는 장애 내용 파악 |
| 분류 | 작업 유형, 영향도, 우선순위 분류 |
| 링크 확인 | 관련 자료 연결 관계 확인 |
| 읽기 전용 분석 | Spec 또는 Change Plan 입력 생성 |

## 금지 작업

다음 작업은 금지한다.

| 작업 | 사유 |
|---|---|
| 생성 | 외부 시스템 상태 변경 |
| 수정 | 외부 시스템 데이터 변경 |
| 삭제 | 데이터 손실 위험 |
| 상태 변경 | Workflow 영향 |
| 댓글 작성 | 기록 변경 |
| 첨부파일 업로드 | 외부 시스템 변경 |
| 담당자 변경 | 업무 책임 변경 |
| 권한 변경 | 보안 영향 |

## MCP 도구 사용 판단 기준

MCP 도구를 호출하기 전 다음을 확인한다.

| 확인 항목 | 기준 |
|---|---|
| 도구 이름 | read, get, search, list, fetch 계열인지 확인 |
| 도구 목적 | 조회 또는 검색 목적인지 확인 |
| 대상 시스템 | Jira 또는 허용된 외부 도구인지 확인 |
| 데이터 변경 여부 | 변경 가능성이 있으면 중단 |
| 민감 정보 가능성 | Token, 개인정보, Credential 포함 여부 확인 |
| 사용자 승인 | 필요 시 먼저 확인 |

## 도구 이름 기준

다음 이름을 포함하는 도구는 Read-only 후보로 본다.

```text
read
get
search
list
fetch
find
lookup
```

다음 이름을 포함하는 도구는 사용하지 않는다.

```text
create
update
delete
remove
transition
comment
assign
upload
attach
edit
write
move
```

## 감사 기록 기준

Read-only MCP 사용 후 다음 항목을 기록한다.

| 항목 | 내용 |
|---|---|
| 호출 목적 | 왜 MCP를 사용했는지 |
| 대상 시스템 | Jira, Confluence 등 |
| 대상 객체 | Issue Key, 문서 제목 등 |
| 사용 도구 | MCP tool 이름 |
| 결과 요약 | 필요한 범위의 요약 |
| 민감 정보 포함 여부 | 있음 / 없음 |
| 후속 작업 | Spec, Search-First, Change Plan 연결 여부 |

## 예외 기준

Read-only MCP 정책의 예외는 기본적으로 허용하지 않는다.

Write 작업이 필요한 경우 다음을 먼저 수행한다.

1. 사용자에게 필요 사유 보고
2. 운영 영향도 분석
3. Guardrail 예외 승인 검토
4. Tool Usage Audit 기록 계획 작성
5. 별도 Write MCP Workflow 구성

## 금지 사항

다음 행위는 금지한다.

- Write 도구를 Read-only 작업처럼 호출
- Jira Issue 상태 변경
- Jira 댓글 작성
- 외부 시스템에 자동으로 데이터 생성
- 조회한 민감 정보를 그대로 문서화
- 인증 정보를 코드나 문서에 저장
- 사용자 승인 없이 외부 시스템 변경