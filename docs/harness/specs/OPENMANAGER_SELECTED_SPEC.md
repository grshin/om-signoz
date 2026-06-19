# OpenManager Selected Improvement Spec

## 문서 목적

본 문서는 23단계에서 선정한 OpenManager 개선 요구사항을 구현 전 Spec으로 정리한 문서이다.

이 Spec은 실제 구현 지시서가 아니라, Search-First 분석과 Change Plan 작성 전 요구사항을 명확히 하기 위한 기준 문서이다.

## Spec 기본 정보

| 항목 | 내용 |
|---|---|
| Spec ID | OM-SPEC-023-001 |
| 관련 단계 | 23단계 |
| 관련 Feature ID | OM-FEAT-006 |
| 기능명 | Dashboard 카드 로딩 상태 개선 |
| 기능 영역 | Dashboard |
| 개선 유형 | Frontend UX 개선 |
| 작성 상태 | Draft |
| 실제 구현 여부 | 미수행 |
| 사용자 승인 필요 여부 | 필요 |

## 요구사항 출처

| 항목 | 내용 |
|---|---|
| 기준 Feature List | `docs/harness/features/OPENMANAGER_FEATURE_LIST.md` |
| 개선 요구사항 선정 문서 | `docs/harness/improvement/IMPROVEMENT_REQUIREMENTS_SELECTION.md` |
| Pilot Plan | `docs/harness/pilot/OPENMANAGER_PILOT_PLAN.md` |
| Requirements Skill | `.claude/skills/om-requirements-collector/SKILL.md` |

## 배경

OpenManager Dashboard는 운영자가 서비스 상태, 장애 알람, 주요 지표를 빠르게 확인하는 화면이다.

Dashboard 카드에서 데이터를 조회하는 동안 상태가 명확하지 않거나, 데이터가 없거나, 오류가 발생했을 때 사용자가 현재 상황을 구분하기 어려울 수 있다.

따라서 Dashboard 카드 단위로 Loading, Empty, Error 상태를 명확히 표현할 수 있는지 검토한다.

## 목표

본 Spec의 목표는 다음과 같다.

```text
- Dashboard 카드의 상태 표현 기준을 정의한다.
- Loading, Empty, Error 상태를 구분한다.
- 기존 UI 구조를 최대한 유지한다.
- Backend, DB, 배포 변경 없이 Frontend 중심 개선 가능성을 확인한다.
- 구현 전 Search-First 분석과 Change Plan으로 연결한다.
```

## 비목표

이번 Spec의 비목표는 다음과 같다.

```text
- Backend API 신규 개발
- DB Schema 변경
- ClickHouse Query 변경
- OTel Pipeline 변경
- Kubernetes / Helm 변경
- Dashboard 전체 레이아웃 개편
- 디자인 시스템 신규 도입
- 운영 환경 배포
```

## 사용자 시나리오

### 시나리오 1. 데이터 로딩 중

운영자가 Dashboard 화면에 진입했을 때 카드 데이터가 아직 로딩 중이면, 사용자는 해당 카드가 데이터를 불러오는 중임을 알 수 있어야 한다.

```text
Given Dashboard 화면에 진입했을 때
When 카드 데이터가 아직 로딩 중이면
Then 카드에는 Loading 상태가 표시되어야 한다.
```

### 시나리오 2. 데이터 없음

운영자가 Dashboard를 조회했지만 특정 카드에 표시할 데이터가 없으면, 사용자는 장애가 아니라 데이터 없음 상태임을 알 수 있어야 한다.

```text
Given Dashboard 카드 조회가 완료되었을 때
When 표시할 데이터가 없으면
Then 카드에는 Empty 상태 메시지가 표시되어야 한다.
```

### 시나리오 3. 오류 발생

Dashboard 카드 데이터 조회 중 오류가 발생하면, 사용자는 화면이 멈춘 것이 아니라 오류가 발생했음을 알 수 있어야 한다.

```text
Given Dashboard 카드 데이터를 조회할 때
When API 오류 또는 데이터 처리 오류가 발생하면
Then 카드에는 Error 상태 메시지가 표시되어야 한다.
```

## 기능 요구사항

| ID | 요구사항 | 우선순위 |
|---|---|---|
| FR-001 | Dashboard 카드 단위 Loading 상태를 표시한다. | 높음 |
| FR-002 | Dashboard 카드 단위 Empty 상태를 표시한다. | 높음 |
| FR-003 | Dashboard 카드 단위 Error 상태를 표시한다. | 높음 |
| FR-004 | 상태 메시지는 기존 UI 문구 스타일과 일관되어야 한다. | 중간 |
| FR-005 | 기존 Dashboard 레이아웃은 유지한다. | 높음 |

## 화면 요구사항

| ID | 요구사항 | 설명 |
|---|---|---|
| UI-001 | Loading 표시 | 데이터 로딩 중임을 사용자가 인지할 수 있어야 한다. |
| UI-002 | Empty 표시 | 조회 결과가 없음을 명확히 보여야 한다. |
| UI-003 | Error 표시 | 오류 발생을 명확히 보여야 한다. |
| UI-004 | 카드 레이아웃 유지 | 카드 크기, 배치, 주요 구조를 유지한다. |
| UI-005 | 상태별 문구 | 상태별 메시지는 짧고 이해하기 쉽게 작성한다. |

## API 요구사항

| ID | 요구사항 | 설명 |
|---|---|---|
| API-001 | 신규 API를 추가하지 않는다. | 이번 Spec에서는 Frontend 상태 표현만 정의한다. |
| API-002 | 기존 API 응답 상태를 활용한다. | 기존 API의 loading, success, error 흐름을 확인한다. |
| API-003 | API Error 처리 방식은 기존 패턴을 따른다. | Search-First에서 기존 에러 처리 패턴을 확인한다. |

## 데이터 요구사항

| ID | 요구사항 | 설명 |
|---|---|---|
| DATA-001 | 신규 저장 데이터 없음 | DB 또는 ClickHouse 저장 구조를 변경하지 않는다. |
| DATA-002 | 조회 결과 유무 판단 | 기존 응답의 배열 길이, null, undefined 등을 기준으로 Empty 상태를 판단한다. |
| DATA-003 | 테스트 데이터 사용 | 실제 고객 데이터 대신 Mock 또는 개발용 데이터를 사용한다. |

## 권한 요구사항

| ID | 요구사항 | 설명 |
|---|---|---|
| AUTH-001 | 기존 Dashboard 접근 권한 유지 | 신규 권한을 추가하지 않는다. |
| AUTH-002 | 권한 정책 변경 제외 | 권한 정책은 이번 Spec 범위가 아니다. |

## 비기능 요구사항

| ID | 구분 | 요구사항 |
|---|---|---|
| NFR-001 | 사용성 | 사용자는 Loading, Empty, Error 상태를 구분할 수 있어야 한다. |
| NFR-002 | 안정성 | 오류 상태에서도 Dashboard 전체 화면이 깨지지 않아야 한다. |
| NFR-003 | 유지보수성 | 기존 Component와 상태 관리 패턴을 우선 사용한다. |
| NFR-004 | 성능 | 상태 표시로 인해 불필요한 렌더링이나 API 호출이 증가하지 않아야 한다. |
| NFR-005 | 보안 | 민감 정보나 내부 오류 상세를 사용자 화면에 그대로 노출하지 않는다. |

## 영향 범위

| 영역 | 영향 여부 | 설명 |
|---|---:|---|
| Frontend React | 있음 | Dashboard 카드 Component 영향 가능 |
| Backend Go | 없음 | 신규 API 개발 제외 |
| ClickHouse | 없음 | Query 변경 제외 |
| OTel Pipeline | 없음 | 수집 파이프라인 변경 제외 |
| Kubernetes / Helm | 없음 | 배포 설정 변경 제외 |
| HarnessOps | 있음 | Spec, Search-First, Change Plan 흐름 검증 |
| 문서 / RunBook | 있음 | Spec과 결과 문서 작성 |

## Search-First 확인 항목

구현 전 Search-First에서 다음을 확인한다.

| 확인 항목 | 설명 |
|---|---|
| Dashboard 관련 디렉터리 | 기존 Dashboard Component 위치 확인 |
| 카드 Component 구조 | 공통 Card Component 존재 여부 |
| Loading 처리 패턴 | 기존 Skeleton, Spinner, Loading Component 사용 여부 |
| Empty 처리 패턴 | 데이터 없음 상태 처리 방식 |
| Error 처리 패턴 | API 오류 또는 화면 오류 처리 방식 |
| 상태 관리 방식 | React Query, Redux, Zustand, Context 등 사용 여부 |
| 테스트 구조 | 기존 테스트 또는 Storybook 존재 여부 |

## Change Plan 작성 기준

Search-First 이후 Change Plan에는 다음을 포함한다.

```text
- 변경 대상 파일
- 기존 Component 재사용 여부
- 신규 Component 필요 여부
- 상태별 UI 처리 방식
- 제외 범위
- 검증 방법
- Rollback 기준
- 사용자 승인 필요 사항
```

## Acceptance Criteria

| ID | 완료 기준 | 검증 방법 |
|---|---|---|
| AC-001 | Loading 중인 카드가 Loading 상태를 표시한다. | Mock 또는 개발 환경에서 수동 확인 |
| AC-002 | 데이터가 없는 카드가 Empty 상태를 표시한다. | 빈 응답 기준 수동 확인 |
| AC-003 | 오류가 발생한 카드가 Error 상태를 표시한다. | 오류 응답 Mock 또는 예외 상황 확인 |
| AC-004 | 기존 Dashboard 레이아웃이 유지된다. | 화면 비교 |
| AC-005 | Backend, DB, Kubernetes 파일이 변경되지 않는다. | Git 변경 파일 확인 |
| AC-006 | 구현 후 Validation Plan과 Change Risk Review를 수행한다. | 점검 결과 기록 |

## 사용자 승인 필요 사항

다음 작업 전에는 사용자 승인이 필요하다.

```text
- 실제 Frontend 파일 수정
- 신규 Component 생성
- 기존 공통 Component 수정
- 상태 메시지 문구 확정
- API 오류 처리 방식 변경
- 테스트 또는 Mock 데이터 추가
- Git Commit / Push
```

## 위험도 평가

| 항목 | 위험도 | 설명 |
|---|---|---|
| 운영 영향 | 낮음 | 운영 배포 없음 |
| Backend 영향 | 낮음 | API 변경 제외 |
| DB 영향 | 없음 | 데이터 저장 변경 없음 |
| Frontend 영향 | 중간 | Dashboard 화면 영향 가능 |
| 사용자 경험 영향 | 중간 | 상태 표현 방식 변경 |
| 보안 영향 | 낮음 | 민감 정보 표시 금지 기준 적용 |
| Rollback 난이도 | 낮음 | Frontend 변경 중심 |

## 결론

본 Spec은 `OM-FEAT-006 — Dashboard 카드 로딩 상태 개선`을 구현 전 단계에서 명확히 정의하기 위한 문서이다.

23단계에서는 실제 구현을 수행하지 않는다.

다음 단계에서는 본 Spec을 기준으로 Search-First 분석을 수행하고, 기존 Dashboard 구조를 확인한 뒤 Change Plan을 작성한다.