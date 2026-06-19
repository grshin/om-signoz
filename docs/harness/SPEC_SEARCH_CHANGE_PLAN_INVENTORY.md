# OpenManager Spec Search Change Plan Inventory

## 문서 목적

본 문서는 OpenManager HarnessOps 24단계의 선정 Spec 기반 Search-First 분석 및 Change Plan 관련 산출물과 관리 기준을 정리한다.

## 24단계 산출물 목록

| 구분 | 파일 | 역할 |
|---|---|---|
| Search-First | `docs/harness/search-first/OPENMANAGER_SPEC_SEARCH_FIRST_ANALYSIS.md` | 선정 Spec 기반 기존 구조 분석 |
| Change Plan | `docs/harness/change-plan/OPENMANAGER_SPEC_CHANGE_PLAN.md` | 구현 전 변경 계획 |
| Template | `docs/harness/templates/spec-search-first-template.md` | 선정 Spec 기반 Search-First 템플릿 |
| Template | `docs/harness/templates/spec-change-plan-template.md` | 선정 Spec 기반 Change Plan 템플릿 |
| Skill | `.claude/skills/om-spec-search-change-plan-review/SKILL.md` | Search-First / Change Plan 검토 Skill |
| Script | `docs/harness/scripts/check-step24-spec-search-change-plan.sh` | 24단계 산출물 점검 스크립트 |

## 관련 선행 산출물

| 구분 | 파일 | 역할 |
|---|---|---|
| Improvement Selection | `docs/harness/improvement/IMPROVEMENT_REQUIREMENTS_SELECTION.md` | 개선 요구사항 선정 문서 |
| Selected Spec | `docs/harness/specs/OPENMANAGER_SELECTED_SPEC.md` | 기준 Spec |
| Feature List | `docs/harness/features/OPENMANAGER_FEATURE_LIST.md` | 관련 Feature 관리 |
| Improvement Spec Inventory | `docs/harness/IMPROVEMENT_SPEC_INVENTORY.md` | 23단계 산출물 관리 |

## 기준 Feature

24단계 기준 Feature는 다음과 같다.

| 항목 | 내용 |
|---|---|
| Feature ID | OM-FEAT-006 |
| 기능명 | Dashboard 카드 로딩 상태 개선 |
| 기능 영역 | Dashboard |
| 개선 유형 | Frontend UX 개선 |
| 현재 단계 | Search-First 분석 및 Change Plan 작성 |

## 점검 기준

24단계 완료 시 다음을 확인한다.

| 항목 | 기준 |
|---|---|
| Search-First 분석 문서 | 존재하고 비어 있지 않아야 함 |
| Change Plan 문서 | 존재하고 비어 있지 않아야 함 |
| Search-First 템플릿 | 존재하고 비어 있지 않아야 함 |
| Change Plan 템플릿 | 존재하고 비어 있지 않아야 함 |
| 검토 Skill | YAML frontmatter와 본문이 있어야 함 |
| Inventory | 존재하고 비어 있지 않아야 함 |
| 점검 스크립트 | 실행 가능해야 함 |
| 23단계 Spec | 선행 산출물로 존재해야 함 |
| 실제 소스코드 변경 | 없어야 함 |

## 운영 기준

24단계 운영 기준은 다음과 같다.

```text
- 선정 Spec을 기준으로 기존 구조를 먼저 확인한다.
- Search-First 단계에서 파일을 수정하지 않는다.
- 변경 후보를 식별하되 확정은 Change Plan에서 한다.
- Change Plan에는 변경 범위, 제외 범위, 검증 방법, Rollback 기준을 포함한다.
- 실제 구현은 사용자 승인 후 진행한다.
```

## 금지 사항

다음 작업은 금지한다.

- Search-First 없이 구현
- Change Plan 없이 구현
- 사용자 승인 없는 소스코드 수정
- Backend, DB, Deploy 변경을 임의 포함
- 민감 정보 기록
- Jira Issue 수정 또는 댓글 작성