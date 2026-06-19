# HarnessOps Vibe Coding Requirements Workflow

## 1. 목적

이 Workflow는 fork한 SigNoz OSS 기능을 OpenManager 관점에서 분석하고, HarnessOps 바이브 코딩으로 검증할 수 있는 개선 요구사항 또는 신규 요구사항 후보를 수집하기 위한 절차이다.

이번 Workflow는 실제 코드 수정 전에 수행한다.

## 2. 적용 시점

다음 상황에서 이 Workflow를 사용한다.

    SigNoz OSS 기능을 OpenManager 관점에서 재분류할 때
    기존 기능 중 개선 필요 항목을 찾을 때
    OpenManager 전용 신규 요구사항 후보를 수집할 때
    HarnessOps 바이브 코딩 Pilot 후보를 선정할 때
    8단계 요구사항 수집 Skill을 실전 검증할 때

## 3. 기본 원칙

    기존 기능을 먼저 확인한다.
    기능 분석과 코드 수정을 분리한다.
    요구사항 후보는 작은 단위로 작성한다.
    SigNoz OSS 직접 수정은 마지막 수단으로 판단한다.
    OpenManager 확장 영역에서 해결 가능한지 먼저 검토한다.
    요구사항 후보는 검증 가능해야 한다.
    HarnessOps 바이브 코딩 후보는 Hook, Quality Gate, Audit까지 연결 가능해야 한다.

## 4. 사용 Skill

| Skill | 사용 목적 |
|---|---|
| om-requirements-collector | 기능 기반 요구사항 후보 수집 |
| om-project-context | OpenManager 기준 확인 |
| om-rule-router | 관련 Rule 확인 |
| om-spec-request | 요구사항 후보를 Spec 형태로 전환 |
| om-search-first-analysis | 관련 기존 구현 탐색 |
| om-change-risk-review | 위험도 검토 |
| om-validation-plan | 검증 계획 수립 |
| om-harness-operation | 운영 적용 가능성 확인 |

## 5. 수행 절차

### 5.1 프로젝트 기준 확인

OpenManager 프로젝트 목적, SigNoz OSS 기반 개발 원칙, 수정 금지 영역, 보안 기준을 확인한다.

확인 대상:

    CLAUDE.md
    AGENTS.md
    .claude/rules/om/
    docs/harness/HARNESS_OPERATION_INVENTORY.md
    docs/harness/QUALITY_GATES_INVENTORY.md
    docs/harness/AUDIT_TRAIL_INVENTORY.md

### 5.2 SigNoz OSS 기능 영역 탐색

다음 기능 영역을 1차로 분류한다.

| 기능 영역 | 확인 관점 |
|---|---|
| Dashboard | 대시보드 구성, 위젯, 차트, 저장 방식 |
| Metrics | 메트릭 조회, 필터, 집계 |
| Traces | Trace 조회, Span 상세, 서비스맵 |
| Logs | 로그 조회, 검색, 필터 |
| Alerts | 알림 Rule, Channel, 조건 설정 |
| OTel Collector | 수집 설정, Pipeline, Receiver / Processor / Exporter |
| Query Service | API, Query, Backend 처리 |
| Frontend UI | 화면, 메뉴, 컴포넌트 |
| Deploy / Helm | 설치, values, 배포 구성 |
| Auth / RBAC | 사용자, 권한, 인증 연동 |

### 5.3 기능 인벤토리 작성

`signoz-feature-inventory-template.md`를 사용하여 기능별 인벤토리를 작성한다.

작성 파일:

    docs/harness/discovery/signoz-oss-feature-inventory.md

작성 기준:

    기능명
    기능 설명
    관련 화면
    관련 API
    관련 파일
    OpenManager 활용 가능성
    개선 필요 여부
    SigNoz 직접 수정 필요 여부

### 5.4 OpenManager Gap 분석

SigNoz OSS 기능을 OpenManager 관점에서 아래 기준으로 분류한다.

| 분류 | 설명 |
|---|---|
| 그대로 활용 | 현재 기능을 그대로 사용할 수 있음 |
| 설정으로 해결 | 설정, Dashboard, Alert Rule, OTel 설정으로 해결 가능 |
| OpenManager 확장 | OM 전용 UI, API, Adapter, Control Plane에서 구현 가능 |
| SigNoz API 활용 | 기존 API를 호출하여 해결 가능 |
| OSS Patch 필요 | SigNoz OSS 직접 수정이 불가피할 수 있음 |
| 제외 / 보류 | 위험도 또는 가치 측면에서 제외 |

작성 파일:

    docs/harness/discovery/om-feature-gap-analysis.md

### 5.5 요구사항 후보 작성

`om-requirement-candidate-template.md`를 사용하여 개선 또는 신규 요구사항 후보를 작성한다.

작성 파일:

    docs/harness/discovery/om-requirements-candidates.md

요구사항 후보는 작은 단위로 작성한다.

좋은 후보 예:

    특정 화면의 OpenManager 안내 문구 추가
    대시보드 카드 명칭 개선
    Alert Rule 작성 시 OM 기준 설명 추가
    OTel Collector 설정 Template 보강
    API 응답 필드 표시 개선
    문서 또는 운영 Template 개선

나쁜 후보 예:

    전체 UI 개편
    전체 Query Engine 구조 변경
    DB Schema 대규모 변경
    운영 배포 자동화 전면 수정
    인증 체계 전면 개편

### 5.6 HarnessOps 바이브 코딩 후보 선정

`harnessops-vibe-coding-candidate-template.md`를 사용하여 실제 Pilot 후보를 선정한다.

작성 파일:

    docs/harness/discovery/harnessops-vibe-coding-candidate.md

선정 기준:

| 기준 | 판단 |
|---|---|
| 작은 단위로 구현 가능 | 필수 |
| 기존 코드 Search-First 가능 | 필수 |
| 변경 범위 제한 가능 | 필수 |
| 검증 방법 명확 | 필수 |
| Hook / Quality Gate / Audit 연결 가능 | 권장 |
| OpenManager 가치 있음 | 필수 |
| 운영 위험 낮음 | 필수 |

### 5.7 후속 단계 연결

22단계 결과는 다음 단계로 연결한다.

| 후속 단계 | 연결 내용 |
|---|---|
| 23단계 | 선정 후보를 Spec과 Acceptance Criteria로 정리 |
| 24단계 | HarnessOps 바이브 코딩으로 실제 구현 |
| 25단계 | 구현 결과 검증 및 Quality Gate 수행 |
| 26단계 | HookOps 실측 로그 분석 |
| 27단계 | Pilot 결과 회고 및 하네스 개선 백로그 작성 |

## 6. Claude Code 호출 예시

### 6.1 요구사항 수집 Skill 호출

    /om-requirements-collector fork한 SigNoz OSS의 Dashboard, Alert, OTel Collector 기능을 OpenManager 관점에서 분석하고, HarnessOps 바이브 코딩으로 검증 가능한 개선 요구사항 후보를 수집해 주세요. 실제 코드는 수정하지 말고 기능 인벤토리, Gap 분석, 요구사항 후보, Pilot 후보로 나누어 정리해 주세요.

### 6.2 기능 인벤토리 작성 요청

    /om-requirements-collector SigNoz OSS의 주요 기능 영역을 Dashboard, Metrics, Traces, Logs, Alerts, OTel Collector, Query Service, Frontend UI, Deploy / Helm 기준으로 분류해 주세요. 각 기능이 OpenManager에서 그대로 활용 가능한지, 설정으로 해결 가능한지, OM 확장이 필요한지, SigNoz OSS 직접 수정이 필요한지 구분해 주세요.

### 6.3 바이브 코딩 후보 선정 요청

    /om-requirements-collector 수집한 요구사항 후보 중에서 HarnessOps 바이브 코딩 Pilot에 적합한 작은 개선 후보 3개를 선정해 주세요. 각 후보에 대해 구현 난이도, 검증 가능성, Hook / Quality Gate / Audit 연결 가능성, OpenManager 차별화 가치를 비교해 주세요.

## 7. 산출물 작성 기준

22단계 산출물은 모두 Markdown으로 작성한다.

    docs/harness/discovery/
    docs/harness/workflows/
    docs/harness/templates/

22단계에서는 실제 소스 파일을 수정하지 않는다.

소스 수정은 23단계에서 Spec과 Change Plan을 확정한 뒤 24단계에서 진행한다.

## 8. 금지 사항

    실제 코드 수정 금지
    운영 배포 명령 실행 금지
    Secret 원문 조회 금지
    기존 SigNoz Playwright Agent 수정 금지
    기존 Hook 파일 수정 금지
    .claude/settings.local.json Git 추적 금지
    Git Push 자동 실행 금지
    대규모 리팩토링 요구사항 후보 선정 금지

## 9. 결과 분류

22단계 결과는 아래 네 가지로 분류한다.

| 결과 | 설명 |
|---|---|
| 활용 가능 기능 | OpenManager에서 그대로 사용할 수 있는 기능 |
| 개선 필요 기능 | 작은 개선으로 OpenManager 가치를 높일 수 있는 기능 |
| 신규 요구사항 후보 | OpenManager 차별화를 위해 새로 정의할 기능 |
| 보류 또는 제외 | 위험도, 범위, 가치 측면에서 진행하지 않을 기능 |