# OpenManager Feature Gap Analysis

## 1. 문서 정보

| 항목 | 내용 |
|---|---|
| 작성일 | YYYY-MM-DD |
| 작성자 | grshin |
| 분석 기준 | SigNoz OSS Feature Inventory |
| 분석 목적 | OpenManager 관점에서 SigNoz OSS 기능의 활용 가능성, 개선 필요성, 신규 요구사항 후보를 도출 |
| 코드 수정 여부 | 수정하지 않음 |

## 2. Gap 분석 기준

| 분류 | 설명 |
|---|---|
| Gap 없음 | 현재 SigNoz 기능을 그대로 활용 가능 |
| 설정 Gap | Dashboard, Alert, OTel 설정 등 설정 보강 필요 |
| UI Gap | 화면, 메뉴, 문구, 사용자 흐름 개선 필요 |
| API Gap | OpenManager 전용 API 또는 Adapter API 필요 |
| 운영 Gap | 배포, 설치, 운영 절차, RunBook 보강 필요 |
| 보안 Gap | 권한, 인증, Secret, 운영 명령 통제 검토 필요 |
| 검증 Gap | 테스트, Quality Gate, 시나리오 검증 부족 |
| 하네스 Gap | Rule, Skill, Agent, Hook, Workflow 보강 필요 |

## 3. 기능 영역별 Gap 분석

| 기능 영역 | 현재 활용 가능성 | Gap 유형 | OpenManager 개선 방향 | 우선순위 |
|---|---|---|---|---|
| Dashboard | 높음 | UI Gap / 설정 Gap | OM 관제 지표 설명, 기본 Dashboard Template, 운영자 안내 문구 보강 | High |
| Metrics | 높음 | 설정 Gap / 문서 Gap | OM 관제 지표 목록, Query 예시, 지표 설명 문서화 | High |
| Traces | 보통 | UI Gap / 문서 Gap | 장애 분석 시나리오, 서비스 영향도 설명 보강 | Medium |
| Logs | 보통 | UI Gap / 문서 Gap | 운영 로그 검색 가이드, 필터 예시 보강 | Medium |
| Alerts | 높음 | 설정 Gap / 운영 Gap | OM 기본 Alert Rule 예시, 운영 기준, 알림 시나리오 보강 | High |
| OTel Collector | 높음 | 설정 Gap / 운영 Gap | OM Collector 설정 Template, Receiver / Processor / Exporter 구성 예시 보강 | High |
| Query Service | 보통 | API Gap / 검증 Gap | OM Adapter API 또는 API 응답 확장 가능성 분석 | Low |
| Frontend UI | 높음 | UI Gap | OpenManager 용어, 안내 문구, 메뉴 구조, 도움말 개선 | Medium |
| Deploy / Helm | 높음 | 운영 Gap / 문서 Gap | 고객 환경별 values 설명, 설치 가이드, 운영 RunBook 보강 | Medium |
| Auth / RBAC | 보통 | 보안 Gap | 현 단계에서는 분석만 수행하고 직접 수정 보류 | Low |

## 4. OpenManager 관점 주요 Gap

## 4.1 관제 지표 설명 부족

SigNoz는 Observability 플랫폼으로 Metrics, Logs, Traces 기능을 제공하지만, OpenManager 고객 관점에서는 지표의 운영 의미를 설명하는 문서와 안내가 필요하다.

### 개선 방향

| 항목 | 내용 |
|---|---|
| 개선 방식 | 문서 / Template 보강 |
| 구현 난이도 | 낮음 |
| 검증 가능성 | 높음 |
| HarnessOps 바이브 코딩 적합성 | 높음 |

## 4.2 OpenManager 기본 Dashboard / Alert Rule Template 부족

OpenManager에서 바로 활용할 수 있는 기본 Dashboard, Alert Rule, OTel Collector Template이 필요하다.

### 개선 방향

| 항목 | 내용 |
|---|---|
| 개선 방식 | 설정 Template / 문서 보강 |
| 구현 난이도 | 낮음 |
| 검증 가능성 | 높음 |
| HarnessOps 바이브 코딩 적합성 | 높음 |

## 4.3 OpenManager 운영자용 안내 문구 부족

SigNoz UI는 일반 Observability 사용자를 기준으로 구성되어 있으므로, OpenManager 운영자 관점의 안내 문구나 도움말이 부족할 수 있다.

### 개선 방향

| 항목 | 내용 |
|---|---|
| 개선 방식 | Frontend UI 문구 개선 |
| 구현 난이도 | 낮음~중간 |
| 검증 가능성 | 높음 |
| HarnessOps 바이브 코딩 적합성 | 높음 |

## 4.4 OpenManager 배포 / 운영 기준 문서 부족

운영 환경별 설치, values, Collector 설정, Alert 기준, Quality Gate 기준을 OpenManager 관점으로 정리할 필요가 있다.

### 개선 방향

| 항목 | 내용 |
|---|---|
| 개선 방식 | 운영 문서 / RunBook 보강 |
| 구현 난이도 | 낮음 |
| 검증 가능성 | 높음 |
| HarnessOps 바이브 코딩 적합성 | 높음 |

## 4.5 API 확장 필요성은 있으나 초기 Pilot로는 부적합

Query Service 또는 Backend API 확장은 OpenManager 기능 고도화에 필요할 수 있으나, 영향 범위가 넓어 초기 HarnessOps 바이브 코딩 검증 대상으로는 적합하지 않다.

### 처리 방향

| 항목 | 내용 |
|---|---|
| 처리 방식 | 후속 분석 |
| 구현 난이도 | 중간~높음 |
| 검증 가능성 | 중간 |
| HarnessOps 바이브 코딩 적합성 | 낮음 |
| 현 단계 판단 | 보류 |

## 5. 개선 후보 우선순위

| 우선순위 | 개선 후보 | 유형 | 선정 근거 |
|---|---|---|---|
| High | OTel Collector OpenManager 설정 Template 보강 | 설정 / 문서 | OM 관제 수집 구조와 직접 연결되며 코드 영향이 작음 |
| High | Dashboard / Alert 운영자 안내 문구 보강 | UI / 문서 | 작은 단위로 구현 가능하고 검증이 쉬움 |
| High | OpenManager 기본 Alert Rule 예시 보강 | 설정 / 문서 | 운영 가치가 높고 HarnessOps 검증에 적합 |
| Medium | Metrics 관제 지표 설명 문서 보강 | 문서 | OM 관제 지표 체계와 연결 가능 |
| Medium | Deploy / Helm values 설명 보강 | 운영 문서 | 고객 환경 적용 시 필요 |
| Low | Query Service API 응답 개선 후보 분석 | API | 영향 범위가 넓어 후속 단계로 보류 |
| Low | Auth / RBAC 개선 | 보안 / 권한 | 위험도가 높아 초기 Pilot에서 제외 |

## 6. HarnessOps 바이브 코딩 Pilot 적합 후보

| 후보 | 적합성 | 사유 |
|---|---|---|
| OTel Collector OpenManager 설정 Template 보강 | 높음 | 소스 영향이 작고 검증 가능하며 OM 가치가 높음 |
| Alert Rule 예시 문서 보강 | 높음 | 운영자 가치가 높고 문서 기반 검증 가능 |
| Dashboard / Alert 화면 안내 문구 보강 | 중간~높음 | 실제 UI 변경을 통해 바이브 코딩 검증 가능 |
| Metrics 지표 설명 문서 보강 | 중간 | 문서 중심으로 안전하지만 구현 검증 효과는 제한적 |
| Backend API 변경 | 낮음 | 영향 범위가 넓어 초기 Pilot 부적합 |

## 7. 1차 결론

초기 HarnessOps 바이브 코딩 검증은 대규모 기능 개발보다 작은 단위의 개선에서 시작하는 것이 적절하다.

추천 순서는 다음과 같다.

| 순서 | 후보 |
|---:|---|
| 1 | OTel Collector OpenManager 설정 Template 보강 |
| 2 | Alert Rule 예시 문서 보강 |
| 3 | Dashboard / Alert 화면 안내 문구 보강 |

첫 번째 Pilot은 `OTel Collector OpenManager 설정 Template 보강`을 우선 검토한다.

이 후보는 다음 이유로 적합하다.

| 기준 | 판단 |
|---|---|
| 작은 단위 구현 | 가능 |
| Search-First 분석 | 가능 |
| Change Plan 작성 | 가능 |
| Hook 검증 | 가능 |
| Quality Gate 검증 | 가능 |
| Change History 작성 | 가능 |
| Tool Usage Audit 작성 | 가능 |
| 운영 위험 | 낮음 |