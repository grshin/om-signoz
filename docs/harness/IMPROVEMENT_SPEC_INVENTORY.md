# OpenManager Improvement Spec Inventory

## 문서 목적

본 문서는 OpenManager HarnessOps 23단계의 개선 요구사항 선정 및 Spec 정리 관련 산출물과 관리 기준을 정리한다.

## 23단계 산출물 목록

| 구분 | 파일 | 역할 |
|---|---|---|
| Selection | `docs/harness/improvement/IMPROVEMENT_REQUIREMENTS_SELECTION.md` | 개선 요구사항 후보와 선정 결과 정리 |
| Spec | `docs/harness/specs/OPENMANAGER_SELECTED_SPEC.md` | 선정 개선 요구사항 Spec |
| Template | `docs/harness/templates/improvement-selection-template.md` | 개선 요구사항 선정 템플릿 |
| Template | `docs/harness/templates/openmanager-spec-template.md` | OpenManager Spec 작성 템플릿 |
| Skill | `.claude/skills/om-improvement-spec-review/SKILL.md` | 개선 요구사항 및 Spec 검토 Skill |
| Script | `docs/harness/scripts/check-step23-improvement-spec.sh` | 23단계 산출물 점검 스크립트 |

## 관련 선행 산출물

| 구분 | 파일 | 역할 |
|---|---|---|
| Feature List | `docs/harness/features/OPENMANAGER_FEATURE_LIST.md` | 개선 후보 기능 목록 |
| Requirements Skill | `.claude/skills/om-requirements-collector/SKILL.md` | 요구사항 수집 Skill |
| Requirements Template | `docs/harness/templates/requirements-collection-template.md` | 요구사항 수집 결과 양식 |
| Pilot Plan | `docs/harness/pilot/OPENMANAGER_PILOT_PLAN.md` | Pilot 후보와 기준 |
| Metrics | `docs/harness/metrics/HARNESSOPS_METRICS.md` | 운영 지표 기준 |

## 선정 Feature

23단계 기본 선정 Feature는 다음과 같다.

| 항목 | 내용 |
|---|---|
| Feature ID | OM-FEAT-006 |
| 기능명 | Dashboard 카드 로딩 상태 개선 |
| 기능 영역 | Dashboard |
| 개선 유형 | Frontend UX 개선 |
| 상태 | Spec 정리 대상 |

## 점검 기준

23단계 완료 시 다음을 확인한다.

| 항목 | 기준 |
|---|---|
| 개선 요구사항 선정 문서 | 존재하고 비어 있지 않아야 함 |
| Spec 문서 | 존재하고 비어 있지 않아야 함 |
| 선정 템플릿 | 존재하고 비어 있지 않아야 함 |
| Spec 템플릿 | 존재하고 비어 있지 않아야 함 |
| Spec 검토 Skill | YAML frontmatter와 본문이 있어야 함 |
| Inventory | 존재하고 비어 있지 않아야 함 |
| 점검 스크립트 | 실행 가능해야 함 |
| Feature List | 선행 산출물로 존재해야 함 |
| 실제 소스코드 변경 | 없어야 함 |

## 운영 기준

개선 요구사항 선정과 Spec 정리는 다음 기준으로 운영한다.

```text
- Feature List에서 후보를 먼저 확인한다.
- 중복 기능 여부를 확인한다.
- 선정 사유와 제외 사유를 명확히 작성한다.
- Spec에는 목표와 비목표를 모두 작성한다.
- Acceptance Criteria는 검증 가능한 문장으로 작성한다.
- 실제 구현은 Search-First와 Change Plan 이후 사용자 승인 후 진행한다.
```

## 금지 사항

다음 작업은 금지한다.

- Feature List 확인 없이 개선 요구사항 선정
- 선정 사유 없이 Spec 작성
- 비목표 없이 구현 범위 확정
- Acceptance Criteria 없이 구현 진행
- 사용자 승인 없는 소스코드 수정
- 민감 정보 기록
- Jira Issue 수정 또는 댓글 작성