# OpenManager Requirements Candidates

## 1. 문서 정보

| 항목 | 내용 |
|---|---|
| 작성일 | YYYY-MM-DD |
| 작성자 | grshin |
| 출처 | SigNoz OSS Feature Inventory, OpenManager Feature Gap Analysis |
| 목적 | HarnessOps 바이브 코딩 Pilot 후보 선정을 위한 요구사항 후보 목록 작성 |
| 코드 수정 여부 | 수정하지 않음 |

## 2. 요구사항 후보 요약

| ID | 요구사항명 | 유형 | 우선순위 | Pilot 후보 |
|---|---|---|---|---|
| OM-REQ-001 | OTel Collector OpenManager 설정 Template 보강 | 설정 / 문서 개선 | High | 예 |
| OM-REQ-002 | OpenManager 기본 Alert Rule 예시 보강 | 설정 / 문서 개선 | High | 예 |
| OM-REQ-003 | Dashboard / Alert 화면 운영자 안내 문구 보강 | UI 개선 | High | 예 |
| OM-REQ-004 | Metrics 관제 지표 설명 문서 보강 | 문서 개선 | Medium | 조건부 |
| OM-REQ-005 | Deploy / Helm values 설명 보강 | 운영 문서 개선 | Medium | 조건부 |
| OM-REQ-006 | Query Service API 응답 개선 후보 분석 | API 분석 | Low | 아니오 |
| OM-REQ-007 | Auth / RBAC 개선 후보 분석 | 보안 / 권한 분석 | Low | 아니오 |

## 3. 요구사항 후보 상세

## 3.1 OM-REQ-001 — OTel Collector OpenManager 설정 Template 보강

| 항목 | 내용 |
|---|---|
| 요구사항 ID | OM-REQ-001 |
| 요구사항명 | OTel Collector OpenManager 설정 Template 보강 |
| 출처 | SigNoz OTel Collector 기능 분석 |
| 관련 SigNoz 기능 | OTel Collector, Deploy / Helm |
| 관련 OpenManager 영역 | OTel / Deploy / Docs |
| 요구사항 유형 | 설정 개선 / 문서 개선 / HarnessOps 검증용 Pilot |
| 우선순위 | High |
| Pilot 후보 여부 | 예 |

### 현재 상태

SigNoz OSS는 OTel Collector 기반 수집 구조를 제공한다.
OpenManager 관점에서는 VM, Kubernetes, GPU, Network, Application 관제를 위한 Collector 설정 예시와 운영 설명이 추가로 필요하다.

### 문제점 또는 개선 필요성

OpenManager 고객 환경에서는 어떤 Receiver, Processor, Exporter를 어떤 관제 목적에 사용해야 하는지 명확한 Template이 필요하다.

### 기대 결과

운영자가 OpenManager 관제 목적에 맞는 Collector 설정 예시를 빠르게 이해하고 적용할 수 있다.

### Acceptance Criteria 후보

| 번호 | Acceptance Criteria |
|---|---|
| AC-01 | OpenManager 관점의 OTel Collector 설정 Template이 작성되어야 한다. |
| AC-02 | Receiver / Processor / Exporter의 역할 설명이 포함되어야 한다. |
| AC-03 | 운영 환경 적용 시 주의사항이 포함되어야 한다. |
| AC-04 | 실제 Secret 값이나 고객 환경 정보는 포함하지 않아야 한다. |
| AC-05 | Quality Gate와 Tool Usage Audit 기록이 가능해야 한다. |

### 영향 범위 후보

| 영역 | 영향 여부 | 설명 |
|---|---|---|
| Backend | 없음 | 코드 수정 없음 |
| Frontend | 없음 | 코드 수정 없음 |
| OTel Pipeline | 있음 | 설정 Template 관점 |
| Deploy / Helm | 있음 | values 또는 예시 설정 연계 가능 |
| DB Schema | 없음 | 변경 없음 |
| API Contract | 없음 | 변경 없음 |
| 권한 / 보안 | 확인 필요 | Secret 예시 처리 주의 |
| 문서 | 있음 | 문서 추가 |
| 테스트 | 있음 | 문서 검증 / 설정 문법 검토 |
| Hook / Guardrail | 있음 | Secret 유사 문자열 검출 확인 가능 |

### 구현 방식 후보

| 방식 | 적합 여부 | 설명 |
|---|---|---|
| 설정 변경으로 해결 | 예 | Template과 예시 설정으로 처리 가능 |
| OpenManager 확장 영역에서 구현 | 예 | OM 문서 / Template으로 구성 가능 |
| Adapter API로 구현 | 아니오 | 필요 없음 |
| SigNoz API 활용 | 아니오 | 필요 없음 |
| SigNoz OSS 직접 수정 | 아니오 | 불필요 |
| 문서 또는 Template 보강 | 예 | 가장 적합 |

### 우선순위 평가

| 평가 항목 | 점수 | 설명 |
|---|---:|---|
| OpenManager 차별화 가치 | 5 | OM 관제 수집 체계와 직접 연결 |
| 구현 난이도 | 1 | 문서 / Template 중심 |
| 검증 용이성 | 5 | 파일 존재, Secret 여부, 문법 확인 가능 |
| 위험도 | 1 | 운영 영향 낮음 |
| HarnessOps 검증 적합성 | 5 | Spec, Search-First, Change Plan, Quality Gate 검증 가능 |

## 3.2 OM-REQ-002 — OpenManager 기본 Alert Rule 예시 보강

| 항목 | 내용 |
|---|---|
| 요구사항 ID | OM-REQ-002 |
| 요구사항명 | OpenManager 기본 Alert Rule 예시 보강 |
| 출처 | SigNoz Alerts 기능 분석 |
| 관련 SigNoz 기능 | Alerts |
| 관련 OpenManager 영역 | Alerts / Docs / Operations |
| 요구사항 유형 | 설정 개선 / 문서 개선 |
| 우선순위 | High |
| Pilot 후보 여부 | 예 |

### 현재 상태

SigNoz는 Alert Rule 기능을 제공한다.
OpenManager 관점에서는 운영 지표별 기본 Alert Rule 예시와 임계치 기준 설명이 필요하다.

### Acceptance Criteria 후보

| 번호 | Acceptance Criteria |
|---|---|
| AC-01 | OpenManager 운영 지표 기준 Alert Rule 예시가 작성되어야 한다. |
| AC-02 | CPU, Memory, Disk, Kubernetes, OTel Collector 상태 중 최소 3개 이상 예시가 포함되어야 한다. |
| AC-03 | 임계치 값은 예시임을 명시해야 한다. |
| AC-04 | 실제 고객 환경 값은 포함하지 않아야 한다. |

## 3.3 OM-REQ-003 — Dashboard / Alert 화면 운영자 안내 문구 보강

| 항목 | 내용 |
|---|---|
| 요구사항 ID | OM-REQ-003 |
| 요구사항명 | Dashboard / Alert 화면 운영자 안내 문구 보강 |
| 출처 | SigNoz Frontend UI 기능 분석 |
| 관련 SigNoz 기능 | Dashboard, Alerts, Frontend UI |
| 관련 OpenManager 영역 | Frontend |
| 요구사항 유형 | UI / UX 개선 |
| 우선순위 | High |
| Pilot 후보 여부 | 예 |

### 현재 상태

SigNoz UI는 Observability 플랫폼 일반 사용자 기준으로 구성되어 있다.
OpenManager에서는 운영자 관점의 설명, 안내 문구, 관제 지표 의미 설명이 필요할 수 있다.

### Acceptance Criteria 후보

| 번호 | Acceptance Criteria |
|---|---|
| AC-01 | 대상 화면의 기존 구현 위치가 Search-First로 식별되어야 한다. |
| AC-02 | OpenManager 안내 문구가 과도하게 UI를 침범하지 않아야 한다. |
| AC-03 | 기존 SigNoz 기능 동작을 변경하지 않아야 한다. |
| AC-04 | Frontend 빌드 또는 관련 검증 명령을 수행할 수 있어야 한다. |

## 3.4 OM-REQ-004 — Metrics 관제 지표 설명 문서 보강

| 항목 | 내용 |
|---|---|
| 요구사항 ID | OM-REQ-004 |
| 요구사항명 | Metrics 관제 지표 설명 문서 보강 |
| 출처 | SigNoz Metrics 기능 분석 |
| 관련 SigNoz 기능 | Metrics |
| 관련 OpenManager 영역 | Docs / Metrics |
| 요구사항 유형 | 문서 개선 |
| 우선순위 | Medium |
| Pilot 후보 여부 | 조건부 |

## 3.5 OM-REQ-005 — Deploy / Helm values 설명 보강

| 항목 | 내용 |
|---|---|
| 요구사항 ID | OM-REQ-005 |
| 요구사항명 | Deploy / Helm values 설명 보강 |
| 출처 | SigNoz Deploy / Helm 분석 |
| 관련 SigNoz 기능 | Deploy / Helm |
| 관련 OpenManager 영역 | Deploy / Operations / Docs |
| 요구사항 유형 | 운영 문서 개선 |
| 우선순위 | Medium |
| Pilot 후보 여부 | 조건부 |

## 3.6 OM-REQ-006 — Query Service API 응답 개선 후보 분석

| 항목 | 내용 |
|---|---|
| 요구사항 ID | OM-REQ-006 |
| 요구사항명 | Query Service API 응답 개선 후보 분석 |
| 출처 | SigNoz Query Service 분석 |
| 관련 SigNoz 기능 | Query Service |
| 관련 OpenManager 영역 | Backend / API |
| 요구사항 유형 | API 분석 |
| 우선순위 | Low |
| Pilot 후보 여부 | 아니오 |

### 보류 사유

Backend API 변경은 영향 범위가 넓고 기존 기능 영향 가능성이 있으므로 초기 HarnessOps 바이브 코딩 Pilot에서는 제외한다.

## 3.7 OM-REQ-007 — Auth / RBAC 개선 후보 분석

| 항목 | 내용 |
|---|---|
| 요구사항 ID | OM-REQ-007 |
| 요구사항명 | Auth / RBAC 개선 후보 분석 |
| 출처 | SigNoz Auth / RBAC 기능 분석 |
| 관련 SigNoz 기능 | Auth / RBAC |
| 관련 OpenManager 영역 | Security / Auth |
| 요구사항 유형 | 보안 / 권한 분석 |
| 우선순위 | Low |
| Pilot 후보 여부 | 아니오 |

### 보류 사유

Auth / RBAC 변경은 보안 영향이 크므로 초기 Pilot에서는 분석만 수행하고 직접 구현하지 않는다.

## 4. Pilot 후보 선정 결과

| 순위 | 요구사항 ID | 요구사항명 | 선정 판단 |
|---:|---|---|---|
| 1 | OM-REQ-001 | OTel Collector OpenManager 설정 Template 보강 | 1차 Pilot 후보 |
| 2 | OM-REQ-002 | OpenManager 기본 Alert Rule 예시 보강 | 2차 후보 |
| 3 | OM-REQ-003 | Dashboard / Alert 화면 운영자 안내 문구 보강 | 3차 후보 |

## 5. 1차 결론

22단계 기준으로는 `OM-REQ-001 — OTel Collector OpenManager 설정 Template 보강`을 1차 HarnessOps 바이브 코딩 Pilot 후보로 선정한다.

이 후보는 실제 운영 코드에 직접 영향을 주지 않으면서도 다음 검증이 가능하다.

| 검증 항목 | 가능 여부 |
|---|---|
| Requirements Collector 사용 | 가능 |
| Spec 작성 | 가능 |
| Search-First 분석 | 가능 |
| Change Plan 작성 | 가능 |
| 문서 / Template 구현 | 가능 |
| Secret 검증 | 가능 |
| Quality Gate | 가능 |
| Change History | 가능 |
| Tool Usage Audit | 가능 |
| HookOps Runtime Audit | 가능 |