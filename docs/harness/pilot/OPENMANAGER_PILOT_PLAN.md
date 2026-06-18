# OpenManager Pilot Plan

## 문서 목적

본 문서는 OpenManager HarnessOps v2 기준으로 Pilot 기능을 선정하고 적용 계획을 정의한다.

Pilot 적용은 실제 구현 자체보다 HarnessOps 절차가 OpenManager 작업에 적용 가능한지 검증하는 데 목적이 있다.

## Pilot 기본 정보

| 항목 | 내용 |
|---|---|
| Pilot 명 | OpenManager Dashboard 카드 로딩 상태 개선 검토 |
| Pilot 유형 | Frontend |
| 관련 단계 | 19단계 |
| 기준 요청 | Jira Issue 또는 내부 샘플 요청 |
| 작업 브랜치 | `feature/om-harness-bootstrap` |
| 적용 방식 | 계획 수립 후 사용자 승인 기반 적용 |
| 실제 구현 여부 | 사용자 승인 후 진행 |

## Pilot 후보

19단계에서 검토할 수 있는 Pilot 후보는 다음과 같다.

| 후보 | 영역 | 설명 | 우선순위 |
|---|---|---|---:|
| Dashboard 카드 로딩 상태 개선 | Frontend | 로딩, 빈 데이터, 오류 상태 표시 개선 검토 | 1 |
| Alert 조회 API 개선 | Backend | 상태, 심각도, 시간 조건 필터 검토 | 2 |
| OTel Pipeline 설정 개선 | OTel | Receiver, Processor, Exporter 설정 영향 검토 | 3 |
| Kubernetes Values 개선 | Deploy | Resource, Probe, Env 설정 검토 | 4 |

## 선정 Pilot

선정 Pilot은 다음과 같다.

```text
[Pilot][Frontend] OpenManager Dashboard 카드 로딩 상태 개선 검토
```

선정 사유는 다음과 같다.

| 기준 | 설명 |
|---|---|
| 운영 영향도 | 낮음 |
| 변경 범위 | Frontend 중심으로 제한 가능 |
| Search-First 적합성 | 기존 Component 구조 분석 가능 |
| 검증 용이성 | 화면 상태 기준으로 확인 가능 |
| HarnessOps 절차 검증 | Spec, Search-First, Change Plan, Quality Gate 연결 가능 |

## 요청 배경

Dashboard 화면에서 데이터 로딩 중 사용자가 현재 상태를 명확하게 알 수 있도록 개선할 필요가 있는지 검토한다.

실제 구현 전에는 기존 Dashboard Component 구조, API 호출 상태, Error 처리 방식, Empty State 처리 방식을 먼저 확인한다.

## Pilot 목표

Pilot 목표는 다음과 같다.

```text
- 기존 Dashboard Component 구조를 확인한다.
- 로딩 상태, 빈 데이터 상태, 오류 상태 처리 방식을 분석한다.
- 개선 필요 여부를 판단한다.
- 실제 구현 전 Change Plan을 작성한다.
- 사용자 승인 없이는 구현하지 않는다.
```

## 적용 범위

| 영역 | 적용 여부 | 설명 |
|---|---:|---|
| Frontend React | 적용 | Dashboard Component 구조 확인 |
| Backend Go | 제외 | API 변경 없음 |
| OTel Pipeline | 제외 | 수집 파이프라인 변경 없음 |
| ClickHouse | 제외 | DB 변경 없음 |
| Docker | 제외 | 이미지 빌드 변경 없음 |
| Kubernetes / Helm | 제외 | 배포 설정 변경 없음 |
| HarnessOps | 적용 | Pilot 절차 검증 |

## 제외 범위

다음 항목은 이번 Pilot 계획에서 제외한다.

- 실제 운영 배포
- Backend API 변경
- DB Schema 변경
- OTel Pipeline 변경
- Kubernetes Manifest 변경
- 실제 고객 데이터 사용
- 사용자 승인 없는 코드 구현
- Jira Issue 수정 또는 상태 변경

## 참조 Workflow

Pilot 적용 시 다음 Workflow를 따른다.

```text
docs/harness/workflows/jira-issue-workflow.md
docs/harness/workflows/search-first-analysis-workflow.md
docs/harness/workflows/change-plan-workflow.md
docs/harness/workflows/implementation-validation-workflow.md
docs/harness/workflows/quality-gate-workflow.md
docs/harness/workflows/change-history-workflow.md
docs/harness/workflows/tool-usage-audit-workflow.md
```

## 참조 Template

Pilot 적용 시 다음 Template을 사용한다.

```text
docs/harness/templates/jira-issue-analysis-template.md
docs/harness/templates/spec-request-common.md
docs/harness/templates/search-first-analysis-template.md
docs/harness/templates/change-plan-template.md
docs/harness/templates/pilot-result-template.md
docs/harness/templates/change-history-template.md
docs/harness/templates/tool-usage-audit-template.md
```

## Pilot 수행 절차

Pilot 수행 절차는 다음과 같다.

```text
1. Jira Issue 또는 내부 요청 확인
2. 요청 목적 요약
3. Pilot 후보와 범위 확정
4. 관련 Rule / Skill / Agent 확인
5. Search-First 분석 수행
6. 변경 필요 여부 판단
7. Change Plan 작성
8. 사용자 승인 확인
9. 승인 시 구현 또는 검증 수행
10. Quality Gate 실행
11. Pilot 결과 기록
12. Change History와 Tool Usage Audit 기록
```

## 사용자 승인 필요 조건

다음 경우에는 사용자 승인이 필요하다.

| 상황 | 승인 필요 |
|---|---:|
| 실제 소스코드 수정 | 필요 |
| 신규 파일 생성 | 필요 |
| 기존 API 영향 | 필요 |
| DB 영향 | 필요 |
| 배포 설정 영향 | 필요 |
| 운영 명령 실행 | 필요 |
| 외부 도구 Write 작업 | 필요 |

## 완료 기준

Pilot 계획 완료 기준은 다음과 같다.

| 항목 | 기준 |
|---|---|
| Pilot 후보 선정 | 완료 |
| 적용 범위 정의 | 완료 |
| 제외 범위 정의 | 완료 |
| 참조 Workflow 연결 | 완료 |
| 참조 Template 연결 | 완료 |
| 사용자 승인 기준 정의 | 완료 |
| 실제 구현 제한 기준 | 완료 |

## 결론

본 Pilot은 OpenManager Dashboard Frontend 개선 가능성을 검토하기 위한 HarnessOps v2 절차 검증용 작업이다.

실제 구현은 Search-First 분석과 Change Plan 작성 후 사용자 승인에 따라 진행한다.