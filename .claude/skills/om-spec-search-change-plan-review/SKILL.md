---
name: OpenManager Spec Search Change Plan Review
description: OpenManager HarnessOps에서 선정 Spec 기반 Search-First 분석과 Change Plan이 충분한지 검토할 때 사용한다.
when_to_use: 선정 Spec 기반 Search-First 분석, 기존 구조 확인, 변경 후보 검토, Change Plan 검토, 구현 전 사용자 승인 필요 사항 정리가 필요할 때 사용한다.
allowed-tools: Read Grep Glob Bash
---

# OpenManager Spec Search Change Plan Review Skill

## 목적

OpenManager 선정 Spec 기반 Search-First 분석과 Change Plan 품질을 검토한다.

이 Skill은 실제 구현을 수행하지 않는다.

기존 구조 분석이 충분한지, 변경 계획이 사용자 승인 전 검토 가능한 수준인지 확인한다.

## 참조 문서

우선 다음 문서를 확인한다.

```text
docs/harness/specs/OPENMANAGER_SELECTED_SPEC.md
docs/harness/search-first/OPENMANAGER_SPEC_SEARCH_FIRST_ANALYSIS.md
docs/harness/change-plan/OPENMANAGER_SPEC_CHANGE_PLAN.md
docs/harness/templates/spec-search-first-template.md
docs/harness/templates/spec-change-plan-template.md
docs/harness/SPEC_SEARCH_CHANGE_PLAN_INVENTORY.md
```

## 검토 대상

다음 항목을 검토한다.

| 대상 | 검토 내용 |
|---|---|
| 선정 Spec | 요구사항, 비목표, Acceptance Criteria |
| Search-First 분석 | 기존 구조 확인, 변경 후보, 영향 범위 |
| Change Plan | 변경 범위, 제외 범위, 검증 방법, Rollback 기준 |
| 사용자 승인 | 실제 구현 전 승인 필요 사항 |
| 위험도 | Frontend, Backend, DB, Deploy, 보안 영향 |
| 후속 단계 | 구현 가능 조건과 검증 기준 |

## 수행 절차

요청을 받으면 다음 순서로 진행한다.

1. 기준 Spec과 Feature ID를 확인한다.
2. Search-First 분석 문서가 있는지 확인한다.
3. 기존 구조 확인 항목이 충분한지 검토한다.
4. 변경 후보가 명확한지 검토한다.
5. Change Plan 문서가 있는지 확인한다.
6. 제외 범위가 명확한지 검토한다.
7. 검증 계획과 Rollback 기준이 있는지 확인한다.
8. 사용자 승인 필요 사항을 정리한다.
9. 실제 구현 가능 조건을 정리한다.

## 출력 형식

```text
OpenManager Spec Search-First / Change Plan 검토 결과

1. 기준 Spec
- Feature ID:
- Spec ID:
- 기능명:

2. Search-First 검토
- 기존 구조 확인:
- 검색 키워드:
- 변경 후보:
- 부족한 항목:

3. Change Plan 검토
- 변경 범위:
- 제외 범위:
- 검증 계획:
- Rollback 기준:
- 사용자 승인 필요 사항:

4. 위험도
- Frontend:
- Backend:
- DB:
- Deploy:
- 보안:

5. 다음 단계
- 구현 가능 여부:
- 구현 전 보완 사항:
- 사용자 승인 필요 여부:

6. 결론
-
```

## 금지 사항

- Search-First 검토 단계에서 실제 파일을 수정하지 않는다.
- Change Plan만으로 구현을 자동 진행하지 않는다.
- 사용자 승인 없이 소스코드를 수정하지 않는다.
- Backend, DB, Deploy 변경을 임의로 포함하지 않는다.
- 민감 정보, 고객사 실명, Token, Secret을 기록하지 않는다.
- Jira Issue를 수정하거나 댓글을 작성하지 않는다.