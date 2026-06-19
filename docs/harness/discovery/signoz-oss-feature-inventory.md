# SigNoz OSS Feature Inventory

## 1. 문서 정보

| 항목 | 내용 |
|---|---|
| 작성일 | YYYY-MM-DD |
| 작성자 | grshin |
| 분석 대상 저장소 | https://github.com/grshin/om-signoz |
| 기준 브랜치 | feature/om-harness-bootstrap |
| 분석 목적 | OpenManager HarnessOps 바이브 코딩 요구사항 수집을 위한 SigNoz OSS 기능 영역 분석 |
| 코드 수정 여부 | 수정하지 않음 |

## 2. 분석 기준

본 문서는 fork한 SigNoz OSS를 OpenManager 관점에서 분석하기 위한 1차 기능 인벤토리이다.

분석 기준은 다음과 같다.

| 기준 | 설명 |
|---|---|
| 그대로 활용 가능 | SigNoz OSS 기능을 OpenManager에서 별도 수정 없이 활용 가능 |
| 설정으로 해결 가능 | Dashboard, Alert Rule, OTel 설정, Helm values 등 설정 변경으로 활용 가능 |
| OpenManager 확장 필요 | OM 전용 UI, API, Adapter, Control Plane 등 확장 구현 필요 |
| SigNoz API 활용 가능 | SigNoz 기존 API를 활용하여 OM 기능 구현 가능 |
| SigNoz OSS Patch 필요 | OSS 원본 코드 수정이 필요할 가능성이 있음 |
| 보류 또는 제외 | 위험도, 범위, 가치 측면에서 현 단계 적용 제외 |

## 3. 기능 영역 요약

| 구분 | 기능 영역 | 주요 설명 | OpenManager 활용 가능성 | 우선 분석 여부 |
|---|---|---|---|---|
| 1 | Dashboard | 관제 화면, Panel, Widget, Query 기반 시각화 | 높음 | 예 |
| 2 | Metrics | Metric 조회, 집계, 필터링, 시계열 분석 | 높음 | 예 |
| 3 | Traces | Trace 조회, Span 상세, 서비스 간 호출 분석 | 보통 | 예 |
| 4 | Logs | 로그 검색, 필터, 상세 조회 | 보통 | 예 |
| 5 | Alerts | Alert Rule, 조건, Notification Channel | 높음 | 예 |
| 6 | OTel Collector | 수집 Pipeline, Receiver, Processor, Exporter | 높음 | 예 |
| 7 | Query Service | Backend API, Query 처리, 데이터 조회 | 보통 | 예 |
| 8 | Frontend UI | 메뉴, 화면, 컴포넌트, 사용자 인터랙션 | 높음 | 예 |
| 9 | Deploy / Helm | 설치, 배포, values, chart, docker compose | 높음 | 예 |
| 10 | Auth / RBAC | 인증, 사용자, 권한 관리 | 보통 | 보류 |
| 11 | Enterprise / EE | Enterprise 전용 기능 | 낮음 | 제외 |
| 12 | Docs / Examples | 설치 문서, 설정 예제, 운영 가이드 | 높음 | 예 |

## 4. 기능별 상세 분석

## 4.1 Dashboard

| 항목 | 내용 |
|---|---|
| 기능 설명 | Metrics, Logs, Traces 기반의 관제 화면과 Panel을 구성하는 기능 |
| OpenManager 활용 가능성 | 높음 |
| 관련 영역 | Frontend UI, Query, Metrics, Logs |
| OpenManager 관점 | OM 전용 관제 대시보드, GPU / Kubernetes / VM / Network 관제 화면으로 확장 가능 |
| 개선 필요성 | OM 전용 메뉴, 안내 문구, 기본 Dashboard Template, 관제 지표 설명 보강 필요 |
| HarnessOps 바이브 코딩 후보 여부 | 적합 |

### 관련 파일 확인 후보

    frontend/
    pkg/
    query-service/
    ee/
    docs/

### OpenManager 판단

| 분류 | 판단 |
|---|---|
| 그대로 활용 | 가능 |
| 설정으로 해결 | 일부 가능 |
| OpenManager 확장 | 필요 |
| SigNoz API 활용 | 가능 |
| SigNoz OSS 직접 수정 | 최소화 |
| 수정 금지 또는 보류 | EE 영역은 보류 |

## 4.2 Metrics

| 항목 | 내용 |
|---|---|
| 기능 설명 | Metric 데이터 조회, 필터링, 집계, 시계열 분석 기능 |
| OpenManager 활용 가능성 | 높음 |
| 관련 영역 | Query Service, Frontend UI, OTel Collector, ClickHouse |
| OpenManager 관점 | Kubernetes, VM, GPU, Network, Application 지표 관제의 핵심 기반 |
| 개선 필요성 | OpenManager 관제 지표 용어, 기본 Query Template, 지표 설명 보강 필요 |
| HarnessOps 바이브 코딩 후보 여부 | 조건부 적합 |

### OpenManager 판단

| 분류 | 판단 |
|---|---|
| 그대로 활용 | 가능 |
| 설정으로 해결 | 일부 가능 |
| OpenManager 확장 | 필요 |
| SigNoz API 활용 | 가능 |
| SigNoz OSS 직접 수정 | 보류 |
| 수정 금지 또는 보류 | 대규모 Query Engine 변경은 보류 |

## 4.3 Traces

| 항목 | 내용 |
|---|---|
| 기능 설명 | Trace 조회, Span 상세, 서비스 간 호출 흐름 분석 |
| OpenManager 활용 가능성 | 보통 |
| 관련 영역 | Frontend UI, Query Service, OTel Pipeline |
| OpenManager 관점 | Application Observability 기능으로 활용 가능 |
| 개선 필요성 | OM 관점의 서비스 영향도, 장애 분석 안내 문구, 운영자용 설명 보강 가능 |
| HarnessOps 바이브 코딩 후보 여부 | 조건부 적합 |

## 4.4 Logs

| 항목 | 내용 |
|---|---|
| 기능 설명 | 로그 조회, 검색, 필터, 상세 확인 |
| OpenManager 활용 가능성 | 보통 |
| 관련 영역 | Frontend UI, Query Service, OTel Pipeline |
| OpenManager 관점 | 장애 분석, 이벤트 추적, 운영 로그 조회 기능으로 활용 가능 |
| 개선 필요성 | 로그 조회 UX, 검색 조건 안내, OM 운영 문서 보강 가능 |
| HarnessOps 바이브 코딩 후보 여부 | 조건부 적합 |

## 4.5 Alerts

| 항목 | 내용 |
|---|---|
| 기능 설명 | Alert Rule 생성, 조건 설정, 알림 채널 관리 |
| OpenManager 활용 가능성 | 높음 |
| 관련 영역 | Frontend UI, Backend API, Notification, Rule Engine |
| OpenManager 관점 | 공공 / 대기업 운영환경에서 임계치 기반 장애 알림, 운영 지표 알림으로 활용 가능 |
| 개선 필요성 | OpenManager 기본 Alert Rule Template, Alert 설명, 운영자 가이드 보강 필요 |
| HarnessOps 바이브 코딩 후보 여부 | 적합 |

### OpenManager 판단

| 분류 | 판단 |
|---|---|
| 그대로 활용 | 가능 |
| 설정으로 해결 | 가능 |
| OpenManager 확장 | 일부 필요 |
| SigNoz API 활용 | 가능 |
| SigNoz OSS 직접 수정 | 최소화 |
| 수정 금지 또는 보류 | 알림 발송 구조 대규모 변경은 보류 |

## 4.6 OTel Collector

| 항목 | 내용 |
|---|---|
| 기능 설명 | Telemetry 데이터 수집, 변환, Export Pipeline 구성 |
| OpenManager 활용 가능성 | 높음 |
| 관련 영역 | OTel Collector, Deploy, Helm, Config |
| OpenManager 관점 | VM, Kubernetes, GPU, Network, Application 관제 수집 표준으로 활용 가능 |
| 개선 필요성 | OpenManager용 Collector 설정 Template, Receiver / Processor / Exporter 설명 보강 필요 |
| HarnessOps 바이브 코딩 후보 여부 | 적합 |

## 4.7 Query Service

| 항목 | 내용 |
|---|---|
| 기능 설명 | Frontend 요청을 처리하고 ClickHouse 등 저장소에서 관측 데이터를 조회하는 Backend 영역 |
| OpenManager 활용 가능성 | 보통 |
| 관련 영역 | Backend Go, API, Query, Database |
| OpenManager 관점 | OM 전용 API 또는 Adapter API 설계 시 분석 필요 |
| 개선 필요성 | API 영향도 분석, 응답 필드 확장 가능성 검토 필요 |
| HarnessOps 바이브 코딩 후보 여부 | 신중 적용 |

## 4.8 Frontend UI

| 항목 | 내용 |
|---|---|
| 기능 설명 | SigNoz 사용자 화면, 메뉴, 컴포넌트, Form, Table, Chart |
| OpenManager 활용 가능성 | 높음 |
| 관련 영역 | React, TypeScript, Components, Routes |
| OpenManager 관점 | OpenManager 브랜드, 메뉴, 관제 화면, 운영자 UX 개선에 활용 가능 |
| 개선 필요성 | OM 전용 문구, 메뉴, 도움말, 기본 화면 구성 개선 가능 |
| HarnessOps 바이브 코딩 후보 여부 | 적합 |

## 4.9 Deploy / Helm

| 항목 | 내용 |
|---|---|
| 기능 설명 | Docker Compose, Helm Chart, Kubernetes 배포 설정 |
| OpenManager 활용 가능성 | 높음 |
| 관련 영역 | deploy, charts, docker, scripts |
| OpenManager 관점 | 고객 환경 배포 자동화, Kubernetes 설치, 운영 설정 표준화에 중요 |
| 개선 필요성 | OM 배포 가이드, values 설명, 운영 환경별 Template 보강 필요 |
| HarnessOps 바이브 코딩 후보 여부 | 조건부 적합 |

## 4.10 Auth / RBAC

| 항목 | 내용 |
|---|---|
| 기능 설명 | 사용자 인증, 권한, 접근 제어 |
| OpenManager 활용 가능성 | 보통 |
| 관련 영역 | Backend, Frontend, 설정, 외부 인증 |
| OpenManager 관점 | 공공 / 대기업 환경에서 중요하지만 변경 위험도 높음 |
| 개선 필요성 | 현 단계에서는 분석 중심, 직접 수정 보류 |
| HarnessOps 바이브 코딩 후보 여부 | 부적합 |

## 5. 1차 개선 후보

| 번호 | 개선 후보 | 유형 | 우선순위 | 근거 |
|---|---|---|---|---|
| 1 | Dashboard / Alert 화면의 OpenManager 운영 안내 문구 보강 | UI 개선 | High | 작은 단위로 구현 가능하고 검증이 쉬움 |
| 2 | OTel Collector 설정 Template 문서 보강 | 문서 / 설정 개선 | High | 코드 영향이 작고 OM 관제 시나리오와 직접 연결됨 |
| 3 | Alert Rule 기본 Template 또는 예시 문서 보강 | 문서 / 설정 개선 | Medium | 운영자 관점 가치가 높고 검증 가능 |
| 4 | Dashboard 기본 지표 설명 문서 보강 | 문서 개선 | Medium | OM 관제 지표와 연결 가능 |
| 5 | Frontend 메뉴 또는 도움말 영역에 OM 용어 반영 | UI 개선 | Medium | Search-First 분석 후 작은 변경 가능 |
| 6 | Query Service API 응답 필드 개선 후보 분석 | API 개선 | Low | 영향 범위 확인 전까지 보류 |

## 6. HarnessOps 바이브 코딩 후보 여부

| 항목 | 판단 |
|---|---|
| 작은 단위로 구현 가능한가 | 예 |
| Search-First 분석이 가능한가 | 예 |
| Change Plan으로 범위 제한이 가능한가 | 예 |
| 검증 방법이 명확한가 | 예 |
| Hook / Quality Gate / Audit 검증에 적합한가 | 예 |
| Pilot 후보로 적합한가 | 예 |

## 7. 1차 결론

22단계 기준으로는 Backend 구조나 DB Schema를 직접 수정하는 요구사항보다, Frontend UI 안내 문구, 운영 문서, OTel Collector 설정 Template, Alert Rule 예시 보강처럼 영향 범위가 작은 항목을 HarnessOps 바이브 코딩 Pilot 후보로 선정하는 것이 적합하다.

첫 번째 Pilot 후보는 다음 중 하나로 선정하는 것이 적절하다.

| 후보 | 추천도 |
|---|---|
| OTel Collector OpenManager 설정 Template 보강 | 높음 |
| Dashboard / Alert 화면 OM 안내 문구 보강 | 높음 |
| Alert Rule 운영 예시 문서 보강 | 보통 |