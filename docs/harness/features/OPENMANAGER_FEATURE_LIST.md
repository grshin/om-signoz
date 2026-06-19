# OpenManager Feature List

## 문서 목적

본 문서는 OpenManager 기능 목록을 관리하기 위한 기준 문서이다.

사용자 요청, Jira Issue, 회의 메모, 고객 요청에서 도출된 기능 후보를 누적 관리하고, Spec, Search-First, Change Plan, Pilot 적용으로 연결한다.

이 문서는 단순 아이디어 목록이 아니라 OpenManager 제품 기능의 기준 목록으로 사용한다.

## 기능 관리 원칙

OpenManager 기능은 다음 원칙으로 관리한다.

```text
- 요구사항 수집 결과를 기반으로 기능을 등록한다.
- 동일 기능을 중복 등록하지 않는다.
- 기능마다 Feature ID를 부여한다.
- 기능 영역과 영향 영역을 분리한다.
- 상태와 우선순위를 명확히 관리한다.
- 관련 Jira Issue, Requirements, Spec, Search-First, Change Plan을 연결한다.
- 구현 완료 전에는 완료 상태로 표시하지 않는다.
```

## 기능 상태 기준

| 상태 | 설명 |
|---|---|
| 후보 | 요청은 있으나 분석 전 |
| 분석중 | Requirements Collector 또는 Search-First 진행 중 |
| 계획 | Change Plan 작성 대상 |
| 구현중 | 사용자 승인 후 구현 진행 중 |
| 완료 | 구현 및 검증 완료 |
| 보류 | 범위, 일정, 우선순위 사유로 보류 |
| 제외 | 현재 OpenManager 범위에서 제외 |

## 기능 영역 기준

| 영역 | 설명 |
|---|---|
| Dashboard | 상태 요약, 주요 지표, 시각화 |
| Alert | 장애 알림, 알람 조회, 알람 상태 관리 |
| Observability | Metric, Log, Trace 조회와 분석 |
| OTel Pipeline | OpenTelemetry 수집, 처리, 전달 상태 |
| Service / Application | 서비스, 애플리케이션 단위 관리 |
| Kubernetes | Cluster, Node, Pod, Namespace 상태 |
| Infrastructure | VM, Host, Network, Storage 상태 |
| User / Auth | 사용자, 권한, 인증, 역할 |
| Settings | 설정, 정책, 임계치, 환경값 |
| Audit | 변경 이력, 감사 로그, 도구 사용 이력 |
| Report | 리포트, 통계, 다운로드 |
| HarnessOps | Rule, Skill, Agent, Workflow, Guardrail |

## 기능 목록

| Feature ID | 영역 | 기능명 | 설명 | 상태 | 우선순위 | 영향 영역 | 요청 출처 | 관련 Issue | 관련 문서 |
|---|---|---|---|---|---|---|---|---|---|
| OM-FEAT-001 | Dashboard | 서비스별 상태 요약 | 서비스별 정상, 주의, 장애 상태를 대시보드에서 요약 표시 | 후보 | 높음 | Frontend, Backend | 내부 요청 | | |
| OM-FEAT-002 | Alert | 장애 알람 목록 조회 | 장애 알람을 상태, 심각도, 시간 기준으로 조회 | 후보 | 높음 | Frontend, Backend, ClickHouse | 내부 요청 | | |
| OM-FEAT-003 | OTel Pipeline | 수집 상태 확인 | OTel Collector 수집 상태와 오류를 확인 | 후보 | 중간 | OTel, Backend | 내부 요청 | | |
| OM-FEAT-004 | Kubernetes | 클러스터 상태 요약 | Kubernetes Node, Pod, Namespace 상태를 요약 표시 | 후보 | 중간 | Backend, Frontend, Kubernetes | 내부 요청 | | |
| OM-FEAT-005 | Audit | 변경 이력 조회 | OpenManager 설정 변경 이력을 조회 | 후보 | 중간 | Backend, Frontend, Audit | 내부 요청 | | |
| OM-FEAT-006 | Dashboard | Dashboard 카드 로딩 상태 개선 | 로딩, 빈 데이터, 오류 상태를 구분하여 표시 | 후보 | 중간 | Frontend | Pilot 후보 | | `docs/harness/pilot/OPENMANAGER_PILOT_PLAN.md` |
| OM-FEAT-007 | Settings | 알람 임계치 설정 | 알람 발생 기준과 임계치를 설정 | 후보 | 중간 | Frontend, Backend, Settings | 내부 요청 | | |
| OM-FEAT-008 | Report | 장애 현황 리포트 | 장애 발생 현황을 기간별로 조회하고 리포트화 | 후보 | 낮음 | Frontend, Backend, Report | 내부 요청 | | |

## 기능 등록 기준

새 기능은 다음 조건을 만족할 때 등록한다.

| 조건 | 기준 |
|---|---|
| 요청 배경 | 왜 필요한지 설명 가능 |
| 기능 목적 | 무엇을 해결하는지 설명 가능 |
| 기능 영역 | Dashboard, Alert 등 영역 분류 가능 |
| 영향 영역 | Frontend, Backend, OTel, ClickHouse 등 영향 판단 가능 |
| 중복 여부 | 기존 Feature ID와 중복되지 않음 |
| 다음 단계 | Spec 또는 Search-First로 연결 가능 |

## 기능 등록 전 확인 사항

| 확인 항목 | 기준 |
|---|---|
| 중복 기능 여부 | 기존 Feature ID 확인 |
| 요청 출처 | Jira Issue, 내부 요청, 회의 메모 등 |
| 영향 영역 | Frontend, Backend, OTel, ClickHouse 등 |
| 우선순위 | 높음, 중간, 낮음 |
| 사용자 승인 필요 여부 | 필요 / 불필요 |
| 관련 문서 | Requirements, Spec, Search-First, Change Plan 연결 여부 |

## Feature ID 부여 기준

Feature ID는 다음 형식을 사용한다.

```text
OM-FEAT-001
OM-FEAT-002
OM-FEAT-003
```

부여 기준은 다음과 같다.

| 항목 | 기준 |
|---|---|
| Prefix | `OM-FEAT` |
| 번호 | 3자리 숫자 |
| 중복 | 허용하지 않음 |
| 삭제 | 삭제하지 않고 상태를 제외 또는 보류로 변경 |
| 완료 | 구현 및 검증 완료 후 완료로 변경 |

## 기능 상태 변경 기준

| 상태 변경 | 조건 |
|---|---|
| 후보 → 분석중 | Requirements Collector 또는 Search-First 시작 |
| 분석중 → 계획 | Change Plan 필요성이 확인됨 |
| 계획 → 구현중 | 사용자 승인 후 구현 시작 |
| 구현중 → 완료 | 구현, 검증 완료 |
| 후보 / 분석중 → 보류 | 범위, 일정, 우선순위 사유로 보류 |
| 후보 / 분석중 → 제외 | OpenManager 범위에서 제외 확정 |

## 관련 문서

Feature List는 다음 문서와 함께 사용한다.

```text
docs/harness/templates/requirements-collection-template.md
docs/harness/templates/spec-request-common.md
docs/harness/workflows/search-first-analysis-workflow.md
docs/harness/workflows/change-plan-workflow.md
docs/harness/pilot/OPENMANAGER_PILOT_PLAN.md
docs/harness/SKILLS_INVENTORY.md
```

## 운영 기준

Feature List 운영 기준은 다음과 같다.

```text
- 요구사항 수집 후 신규 기능 후보를 등록한다.
- 기존 기능과 중복되는 경우 신규 등록하지 않고 기존 Feature를 갱신한다.
- Feature 상태 변경 시 관련 근거 문서를 남긴다.
- 사용자 승인 없이 구현중 상태로 변경하지 않는다.
- 구현 완료 전 완료 상태로 변경하지 않는다.
- 고객사 실명, Token, Secret, Credential은 기록하지 않는다.
```

## 금지 사항

다음 작업은 금지한다.

- 요구사항 분석 없이 기능을 확정하지 않는다.
- 동일 기능을 중복 등록하지 않는다.
- 구현 완료 전 상태를 완료로 표시하지 않는다.
- 사용자 승인 없이 구현중 상태로 변경하지 않는다.
- 고객사 실명, Token, Secret, Credential을 기록하지 않는다.
- Jira Issue 내용을 그대로 복사하지 않는다.
- Feature List를 단순 아이디어 메모장처럼 사용하지 않는다.