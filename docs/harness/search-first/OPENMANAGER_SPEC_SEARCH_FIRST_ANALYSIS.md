# OpenManager Spec Search-First Analysis

## 문서 목적

본 문서는 23단계에서 선정한 OpenManager 개선 Spec을 기준으로 실제 구현 전에 기존 코드와 문서 구조를 먼저 분석하기 위한 Search-First 결과 문서이다.

24단계에서는 실제 소스코드를 수정하지 않는다.

## 기준 정보

| 항목 | 내용 |
|---|---|
| 기준 단계 | 24단계 |
| 기준 Spec | `docs/harness/specs/OPENMANAGER_SELECTED_SPEC.md` |
| 관련 Feature ID | OM-FEAT-006 |
| 기능명 | Dashboard 카드 로딩 상태 개선 |
| 기능 영역 | Dashboard |
| 개선 유형 | Frontend UX 개선 |
| 실제 구현 여부 | 미수행 |
| 사용자 승인 필요 여부 | 필요 |

## 분석 대상 Spec 요약

선정 Spec의 핵심 요구사항은 다음과 같다.

```text
OpenManager Dashboard 카드에서 Loading, Empty, Error 상태를 명확히 구분하여 표시한다.
Backend, DB, ClickHouse, OTel Pipeline, Kubernetes / Helm 변경은 제외한다.
기존 Dashboard 레이아웃과 기존 UI 패턴을 최대한 유지한다.
```

## Search-First 분석 원칙

Search-First 분석은 다음 원칙을 따른다.

```text
- 파일을 바로 수정하지 않는다.
- 기존 Dashboard 구조를 먼저 확인한다.
- 기존 Loading / Empty / Error 처리 패턴을 먼저 확인한다.
- 기존 공통 Component를 우선 사용한다.
- 신규 Component 생성 여부는 Change Plan에서 판단한다.
- Backend, DB, 배포 영향이 있는 변경은 제외한다.
```

## 분석 대상 영역

| 영역 | 분석 여부 | 설명 |
|---|---:|---|
| Frontend React | 분석 | Dashboard Component와 상태 처리 패턴 확인 |
| Backend Go | 제외 | 신규 API 개발 제외 |
| ClickHouse | 제외 | Query 변경 제외 |
| OTel Pipeline | 제외 | 수집 파이프라인 변경 제외 |
| Kubernetes / Helm | 제외 | 배포 설정 변경 제외 |
| HarnessOps 문서 | 분석 | Spec과 Change Plan 연결 확인 |

## 검색 키워드 후보

기존 구조를 찾기 위한 키워드는 다음과 같다.

```text
Dashboard
Card
Loading
Skeleton
Spinner
Empty
No data
Error
Alert
Service
Status
Widget
Panel
```

## 권장 검색 명령

다음 명령으로 기존 구조를 읽기 전용으로 확인한다.

```bash
find frontend -maxdepth 4 -type f 2>/dev/null | grep -Ei 'dashboard|card|widget|panel' | head -100
```

```bash
grep -RInE "Loading|Skeleton|Spinner|Empty|No data|Error" frontend 2>/dev/null | head -100
```

```bash
grep -RInE "Dashboard|Card|Widget|Panel" frontend 2>/dev/null | head -100
```

SigNoz 구조에 따라 Frontend 경로가 다를 수 있으므로, `frontend` 경로가 없으면 먼저 상위 구조를 확인한다.

```bash
find . -maxdepth 2 -type d | sort
```

## 확인해야 할 파일 유형

Search-First에서 확인할 파일 유형은 다음과 같다.

| 유형 | 확인 내용 |
|---|---|
| Dashboard Page | Dashboard 화면 진입점 |
| Card Component | 카드 UI 구성 요소 |
| Widget Component | 지표 또는 상태 표시 단위 |
| Loading Component | 기존 Loading / Skeleton / Spinner |
| Empty State Component | 데이터 없음 표현 방식 |
| Error Component | 오류 표현 방식 |
| API Hook | 데이터 조회 상태 처리 |
| State Management | React Query, Redux, Context 등 |
| Test / Story | 상태별 검증 구조 |

## 예상 변경 후보

Search-First 전 예상 변경 후보는 다음과 같다.

| 후보 | 설명 | 실제 변경 여부 |
|---|---|---:|
| Dashboard Card Component | 카드 단위 상태 표시 가능성 확인 | 미정 |
| 공통 Loading Component | 기존 Loading 표현 재사용 가능성 확인 | 미정 |
| Empty State Component | 기존 Empty 표현 재사용 가능성 확인 | 미정 |
| Error State Component | 기존 Error 표현 재사용 가능성 확인 | 미정 |
| Dashboard 데이터 조회 Hook | loading, error, data 상태 확인 | 미정 |

## 기존 패턴 확인 결과

아래 항목은 Search-First 수행 후 작성한다.

| 확인 항목 | 결과 |
|---|---|
| Dashboard 관련 디렉터리 | 미확인 |
| 카드 Component 위치 | 미확인 |
| Loading 처리 패턴 | 미확인 |
| Empty 처리 패턴 | 미확인 |
| Error 처리 패턴 | 미확인 |
| 데이터 조회 Hook | 미확인 |
| 테스트 구조 | 미확인 |

## 영향 범위 판단

현재 Spec 기준 예상 영향 범위는 다음과 같다.

| 영역 | 영향 여부 | 판단 |
|---|---:|---|
| Frontend React | 있음 | Dashboard 카드 상태 표시 개선 가능성 |
| Backend Go | 없음 | 신규 API 제외 |
| ClickHouse | 없음 | Query 변경 제외 |
| OTel Pipeline | 없음 | 수집 파이프라인 변경 제외 |
| Kubernetes / Helm | 없음 | 배포 설정 변경 제외 |
| 문서 | 있음 | Search-First와 Change Plan 작성 |

## 위험도 판단

| 항목 | 위험도 | 설명 |
|---|---|---|
| 운영 영향 | 낮음 | 분석 단계이며 운영 변경 없음 |
| 소스 영향 | 없음 | 24단계에서는 소스 수정 없음 |
| Frontend 영향 | 중간 | 다음 구현 단계에서 Dashboard 화면 영향 가능 |
| Backend 영향 | 없음 | Backend 변경 제외 |
| DB 영향 | 없음 | DB 변경 제외 |
| 배포 영향 | 없음 | 배포 설정 변경 제외 |
| 보안 영향 | 낮음 | 민감 정보 출력 금지 |

## Search-First 결론

현재 단계에서는 실제 구현을 수행하지 않는다.

본 Spec은 Frontend 중심 개선으로 보이며, 다음 단계로 넘어가기 위해서는 기존 Dashboard Component 위치와 상태 처리 패턴을 먼저 확인해야 한다.

## Change Plan 필요 여부

| 항목 | 판단 |
|---|---|
| Change Plan 필요 여부 | 필요 |
| 사유 | 실제 Frontend 파일 변경 전 변경 대상, 검증 방법, Rollback 기준을 정의해야 함 |
| 사용자 승인 필요 여부 | 필요 |
| 구현 가능 여부 | Search-First 완료 및 사용자 승인 후 가능 |

## 다음 단계

```text
1. 기존 Dashboard 관련 파일 위치 확인
2. 기존 Loading / Empty / Error 처리 패턴 확인
3. 변경 후보 파일 확정
4. Change Plan 작성
5. 사용자 승인 후 구현 단계 진행
```