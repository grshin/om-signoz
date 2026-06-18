---
name: OpenManager Pilot Application
description: OpenManager HarnessOps에서 Pilot 기능 후보를 선정하고, Spec, Search-First, Change Plan, Validation, Quality Gate 흐름에 맞게 적용 여부를 검토할 때 사용한다.
when_to_use: OpenManager Pilot, Pilot 기능 적용, HarnessOps v2 검증, Jira Issue 기반 Pilot, Search-First, Change Plan, Quality Gate 연결이 필요할 때 사용한다.
allowed-tools: Read Grep Glob Bash
---

# OpenManager Pilot Application Skill

## 목적

OpenManager HarnessOps 환경에서 Pilot 기능 적용 가능성을 검토하고, 실제 구현 전 필요한 절차를 정리한다.

이 Skill은 사용자 승인 없이 실제 소스코드를 수정하지 않는다.

## 참조 문서

우선 다음 문서를 확인한다.

```text
docs/harness/pilot/OPENMANAGER_PILOT_PLAN.md
docs/harness/pilot/OPENMANAGER_PILOT_RESULT.md
docs/harness/templates/pilot-result-template.md
docs/harness/PILOT_INVENTORY.md
docs/harness/workflows/jira-issue-workflow.md
docs/harness/workflows/search-first-analysis-workflow.md
docs/harness/workflows/change-plan-workflow.md
docs/harness/workflows/implementation-validation-workflow.md
docs/harness/workflows/quality-gate-workflow.md
```

## 검토 대상

다음 항목을 검토한다.

| 대상 | 검토 내용 |
|---|---|
| Pilot 요청 | 요청 목적과 기대 결과 |
| Pilot 유형 | Backend, Frontend, OTel, Deploy, Harness 분류 |
| 적용 범위 | 실제 변경 대상과 제외 범위 |
| 기존 구조 | Search-First 분석 필요 여부 |
| 변경 계획 | Change Plan 필요 여부 |
| 검증 기준 | Validation, Quality Gate 필요 여부 |
| 사용자 승인 | 구현 전 승인 필요 여부 |
| 감사 기록 | Change History, Tool Usage Audit 필요 여부 |

## 수행 절차

요청을 받으면 다음 순서로 진행한다.

1. Pilot 요청을 요약한다.
2. Pilot 유형을 분류한다.
3. 적용 범위와 제외 범위를 구분한다.
4. 관련 Rule, Skill, Agent, Workflow를 확인한다.
5. Search-First 분석 필요 여부를 판단한다.
6. Change Plan 작성 필요 여부를 판단한다.
7. 실제 구현 전 사용자 승인 필요 여부를 판단한다.
8. 검증 및 Quality Gate 기준을 정리한다.
9. Pilot Result Template 기준으로 결과를 정리한다.

## 출력 형식

```text
OpenManager Pilot 적용 검토 결과

1. Pilot 요청 요약
-

2. Pilot 유형
- Backend / Frontend / OTel Pipeline / Deploy / Harness / Documentation:

3. 적용 범위
- 포함:
- 제외:

4. 관련 HarnessOps 기준
- Rule:
- Skill:
- Agent:
- Workflow:

5. 선행 분석 필요 여부
- Jira Issue 분석:
- Spec 요청 정리:
- Search-First 분석:
- Change Plan:

6. 사용자 승인 필요 여부
- 필요 / 불필요:
- 사유:

7. 검증 기준
- Validation:
- Quality Gate:
- Change History:
- Tool Usage Audit:

8. 결론
- 진행 가능 여부:
- 실제 구현 가능 조건:
- 후속 조치:
```

## 금지 사항

- 사용자 승인 없이 실제 소스코드를 수정하지 않는다.
- Search-First 없이 구현 계획을 확정하지 않는다.
- Change Plan 없이 운영 영향 변경을 제안하지 않는다.
- 민감 정보를 Pilot 문서에 기록하지 않는다.
- Jira Issue를 수정하거나 상태를 변경하지 않는다.
- 하네스 변경과 기능 구현을 하나의 Commit에 섞지 않는다.