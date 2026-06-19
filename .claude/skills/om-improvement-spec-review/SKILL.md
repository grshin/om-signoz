---
name: OpenManager Improvement Spec Review
description: OpenManager HarnessOps에서 개선 요구사항 후보를 선정하고 Spec 문서가 충분한지 검토할 때 사용한다.
when_to_use: 개선 요구사항 선정, Feature List 후보 검토, Spec 정리, Acceptance Criteria 검토, Search-First 전 Spec 품질 검토가 필요할 때 사용한다.
allowed-tools: Read Grep Glob Bash
---

# OpenManager Improvement Spec Review Skill

## 목적

OpenManager 개선 요구사항 선정 결과와 Spec 문서의 품질을 검토한다.

이 Skill은 실제 구현을 수행하지 않는다.

Spec이 Search-First 분석과 Change Plan으로 넘어갈 수 있을 만큼 명확한지 확인한다.

## 참조 문서

우선 다음 문서를 확인한다.

```text
docs/harness/improvement/IMPROVEMENT_REQUIREMENTS_SELECTION.md
docs/harness/specs/OPENMANAGER_SELECTED_SPEC.md
docs/harness/templates/improvement-selection-template.md
docs/harness/templates/openmanager-spec-template.md
docs/harness/features/OPENMANAGER_FEATURE_LIST.md
docs/harness/IMPROVEMENT_SPEC_INVENTORY.md
```

## 검토 대상

다음 항목을 검토한다.

| 대상 | 검토 내용 |
|---|---|
| 개선 요구사항 선정 문서 | 후보, 선정 사유, 제외 사유, 다음 단계 |
| Spec 문서 | 배경, 목표, 비목표, 요구사항, Acceptance Criteria |
| Feature List | 관련 Feature ID와 중복 여부 |
| 영향 범위 | Frontend, Backend, DB, OTel, Deploy 영향 |
| 사용자 승인 | 실제 구현 전 승인 필요 사항 |
| 후속 단계 | Search-First와 Change Plan 필요 여부 |

## 수행 절차

요청을 받으면 다음 순서로 진행한다.

1. 선정된 Feature ID를 확인한다.
2. 선정 사유가 명확한지 확인한다.
3. 제외 범위가 명확한지 확인한다.
4. 기능 요구사항이 구체적인지 확인한다.
5. 화면, API, 데이터, 권한 요구사항이 분리되어 있는지 확인한다.
6. 비기능 요구사항이 포함되어 있는지 확인한다.
7. Acceptance Criteria가 검증 가능한지 확인한다.
8. Search-First 확인 항목이 충분한지 확인한다.
9. Change Plan으로 넘어갈 수 있는지 판단한다.
10. 사용자 승인 필요 사항을 정리한다.

## 출력 형식

```text
OpenManager 개선 요구사항 / Spec 검토 결과

1. 선정 Feature
- Feature ID:
- 기능명:
- 선정 사유 적정성:

2. Spec 완성도
- 배경:
- 목표:
- 비목표:
- 기능 요구사항:
- 화면 요구사항:
- API 요구사항:
- 데이터 요구사항:
- 비기능 요구사항:

3. Acceptance Criteria 검토
-

4. 영향 범위 검토
-

5. 부족한 항목
-

6. 다음 단계
- Search-First 필요 여부:
- Change Plan 필요 여부:
- 사용자 승인 필요 여부:

7. 결론
- Spec 진행 가능 여부:
- 보완 필요 사항:
```

## 금지 사항

- Spec 검토 단계에서 실제 파일을 구현하지 않는다.
- Feature List 상태를 임의로 변경하지 않는다.
- 사용자 승인 없이 소스코드를 수정하지 않는다.
- 모호한 요구사항을 임의로 확정하지 않는다.
- 민감 정보, 고객사 실명, Token, Secret을 기록하지 않는다.
- Jira Issue를 수정하거나 댓글을 작성하지 않는다.