# OpenManager Improvement Requirements Selection

## 문서 목적

본 문서는 OpenManager 개선 요구사항 후보 중 실제 Spec으로 정리할 대상을 선정하기 위한 기준 문서이다.

23단계에서는 Feature List에 등록된 후보 중 1건을 선정하고, 선정 사유, 제외 범위, 영향 영역, 후속 절차를 정리한다.

## 기준 단계

| 항목 | 내용 |
|---|---|
| 기준 단계 | 23단계 |
| 단계명 | 개선 요구사항 선정 및 Spec 정리 |
| 기준 Feature List | `docs/harness/features/OPENMANAGER_FEATURE_LIST.md` |
| 기준 Skill | `.claude/skills/om-requirements-collector/SKILL.md` |
| 실제 구현 여부 | 미수행 |
| 구현 전제 | Search-First와 Change Plan 후 사용자 승인 필요 |

## 개선 요구사항 후보

Feature List 기준 주요 후보는 다음과 같다.

| Feature ID | 영역 | 기능명 | 상태 | 우선순위 | 영향 영역 | 비고 |
|---|---|---|---|---|---|---|
| OM-FEAT-001 | Dashboard | 서비스별 상태 요약 | 후보 | 높음 | Frontend, Backend | Dashboard 핵심 후보 |
| OM-FEAT-002 | Alert | 장애 알람 목록 조회 | 후보 | 높음 | Frontend, Backend, ClickHouse | API와 데이터 영향 가능 |
| OM-FEAT-003 | OTel Pipeline | 수집 상태 확인 | 후보 | 중간 | OTel, Backend | Pipeline 영향 가능 |
| OM-FEAT-004 | Kubernetes | 클러스터 상태 요약 | 후보 | 중간 | Backend, Frontend, Kubernetes | K8s 연동 영향 |
| OM-FEAT-005 | Audit | 변경 이력 조회 | 후보 | 중간 | Backend, Frontend, Audit | 감사 기능 후보 |
| OM-FEAT-006 | Dashboard | Dashboard 카드 로딩 상태 개선 | 후보 | 중간 | Frontend | Pilot 연계 후보 |

## 선정 요구사항

23단계에서 선정한 개선 요구사항은 다음과 같다.

| 항목 | 내용 |
|---|---|
| 선정 Feature ID | OM-FEAT-006 |
| 선정 기능명 | Dashboard 카드 로딩 상태 개선 |
| 기능 영역 | Dashboard |
| 개선 유형 | Frontend UX 개선 |
| 우선순위 | 중간 |
| 영향 영역 | Frontend |
| 선정 상태 | Spec 정리 대상 |
| 실제 구현 여부 | 미수행 |

## 선정 사유

OM-FEAT-006을 선정한 사유는 다음과 같다.

| 기준 | 판단 | 설명 |
|---|---|---|
| 사용자 가치 | 높음 | 로딩, 빈 데이터, 오류 상태를 명확히 보여주면 사용성이 개선된다. |
| 구현 범위 | 낮음 | Frontend 중심으로 제한 가능하다. |
| 운영 영향 | 낮음 | Backend, DB, 배포 변경 없이 검토 가능하다. |
| 검증 가능성 | 높음 | Loading, Empty, Error 상태별 확인이 가능하다. |
| Pilot 연계 | 높음 | 19단계 Pilot 후보와 연결된다. |
| 위험도 | 낮음 | 운영 데이터 변경이나 배포 영향이 없다. |
| 학습 효과 | 높음 | Requirements, Spec, Search-First, Change Plan 흐름을 실습하기 좋다. |

## 제외한 후보와 사유

| Feature ID | 기능명 | 제외 사유 |
|---|---|---|
| OM-FEAT-001 | 서비스별 상태 요약 | Backend API와 데이터 집계 영향 가능성이 있어 초기 Spec 대상으로는 범위가 넓다. |
| OM-FEAT-002 | 장애 알람 목록 조회 | ClickHouse Query와 API 영향 가능성이 있어 Search-First 이후 별도 단계가 적합하다. |
| OM-FEAT-003 | 수집 상태 확인 | OTel Pipeline 영향이 있어 운영 영향 검토가 필요하다. |
| OM-FEAT-004 | 클러스터 상태 요약 | Kubernetes 연동 범위가 커질 수 있다. |
| OM-FEAT-005 | 변경 이력 조회 | Audit 저장 구조와 권한 정책 검토가 필요하다. |

## 요구사항 요약

선정 요구사항의 요약은 다음과 같다.

```text
OpenManager Dashboard 화면에서 카드 데이터가 로딩 중이거나, 데이터가 없거나, 오류가 발생했을 때 사용자가 현재 상태를 명확히 알 수 있도록 상태 표현 방식을 개선한다.
```

## 기능 요구사항

| ID | 요구사항 | 우선순위 |
|---|---|---|
| FR-001 | Dashboard 카드에 Loading 상태를 표시한다. | 높음 |
| FR-002 | 조회 결과가 없을 때 Empty 상태를 표시한다. | 높음 |
| FR-003 | API 또는 데이터 조회 오류 시 Error 상태를 표시한다. | 높음 |
| FR-004 | 상태별 메시지를 사용자 친화적으로 표시한다. | 중간 |

## 화면 요구사항

| ID | 요구사항 | 비고 |
|---|---|---|
| UI-001 | Loading 상태에서는 Skeleton, Spinner 또는 상태 메시지를 표시한다. | 기존 UI 패턴 우선 |
| UI-002 | Empty 상태에서는 데이터 없음 메시지를 표시한다. | 사용자 행동 안내 포함 가능 |
| UI-003 | Error 상태에서는 오류 메시지와 재시도 안내를 표시한다. | API 변경 없이 가능 여부 확인 |
| UI-004 | 기존 Dashboard 레이아웃을 변경하지 않는다. | 범위 제한 |

## API 요구사항

| ID | 요구사항 | 비고 |
|---|---|---|
| API-001 | 신규 API는 추가하지 않는다. | 23단계 기준 |
| API-002 | 기존 API 응답 상태를 활용한다. | Search-First에서 확인 |
| API-003 | API 에러 처리 방식은 기존 Frontend 패턴을 우선 따른다. | 구현 전 확인 필요 |

## 데이터 요구사항

| ID | 요구사항 | 비고 |
|---|---|---|
| DATA-001 | 신규 데이터 저장은 하지 않는다. | DB 영향 제외 |
| DATA-002 | 기존 조회 결과의 유무만 판단한다. | Empty 상태 기준 |
| DATA-003 | 실제 고객 데이터는 사용하지 않는다. | 테스트 데이터 또는 Mock 기준 |

## 권한 요구사항

| ID | 요구사항 | 비고 |
|---|---|---|
| AUTH-001 | 기존 Dashboard 접근 권한을 그대로 따른다. | 신규 권한 없음 |
| AUTH-002 | 권한 정책 변경은 제외한다. | 범위 제외 |

## 비기능 요구사항

| ID | 구분 | 요구사항 |
|---|---|---|
| NFR-001 | 사용성 | 사용자가 로딩, 빈 데이터, 오류 상태를 구분할 수 있어야 한다. |
| NFR-002 | 안정성 | 오류 상태에서도 화면 전체가 깨지지 않아야 한다. |
| NFR-003 | 유지보수성 | 기존 Component 패턴을 우선 사용해야 한다. |
| NFR-004 | 성능 | 상태 표시로 인해 불필요한 API 호출이 증가하면 안 된다. |

## 제외 범위

이번 Spec에서 제외하는 범위는 다음과 같다.

```text
- Backend API 변경
- DB Schema 변경
- ClickHouse Query 변경
- OTel Pipeline 변경
- Kubernetes / Helm 변경
- 운영 배포
- 권한 정책 변경
- 디자인 시스템 신규 도입
```

## 확인 필요 사항

| 번호 | 질문 | 확인 대상 | 상태 |
|---:|---|---|---|
| 1 | 기존 Dashboard 카드 Component가 어디에 있는가? | 개발자 | 미확인 |
| 2 | 기존 Loading / Empty / Error 상태 처리 패턴이 있는가? | 개발자 | 미확인 |
| 3 | API 오류를 카드 단위로 처리하는가, 화면 단위로 처리하는가? | 개발자 | 미확인 |
| 4 | 상태 메시지는 기존 다국어 또는 문구 정책을 따르는가? | PM / 개발자 | 미확인 |
| 5 | Mock 데이터 기반 검증이 가능한가? | 개발자 | 미확인 |

## Acceptance Criteria 초안

| ID | 완료 기준 | 검증 방법 |
|---|---|---|
| AC-001 | 데이터 로딩 중 Dashboard 카드가 Loading 상태를 표시한다. | 수동 UI 확인 또는 테스트 |
| AC-002 | 데이터가 없을 때 Empty 상태 메시지를 표시한다. | Mock 또는 API 응답 기준 확인 |
| AC-003 | 오류 발생 시 Error 상태 메시지를 표시한다. | 오류 응답 시나리오 확인 |
| AC-004 | 기존 Dashboard 레이아웃이 깨지지 않는다. | 화면 수동 확인 |
| AC-005 | Backend, DB, 배포 파일 변경 없이 처리 가능 여부를 확인한다. | Git 변경 파일 확인 |

## 다음 단계

| 단계 | 필요 여부 | 비고 |
|---|---:|---|
| Spec 정리 | 필요 | `docs/harness/specs/OPENMANAGER_SELECTED_SPEC.md` 작성 |
| Search-First 분석 | 필요 | 기존 Dashboard 구조 확인 |
| Change Plan 작성 | 필요 | 구현 전 변경 대상 확정 |
| 사용자 승인 | 필요 | 실제 파일 수정 전 승인 |
| 구현 | 승인 후 | 24단계 또는 별도 구현 단계 |
| Validation Plan | 필요 | Frontend 검증 기준 정리 |
| Change Risk Review | 필요 | Commit 전 검토 |

## 결론

23단계에서는 `OM-FEAT-006 — Dashboard 카드 로딩 상태 개선`을 개선 요구사항으로 선정한다.

선정 사유는 운영 영향이 낮고, Frontend 중심으로 범위를 제한할 수 있으며, 19단계 Pilot과 연결되고, Spec → Search-First → Change Plan 흐름을 검증하기에 적합하기 때문이다.

실제 구현은 수행하지 않으며, 다음 단계에서 Search-First 분석과 Change Plan 작성 후 사용자 승인에 따라 진행한다.