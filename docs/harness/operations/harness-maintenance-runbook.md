# OpenManager Harness Maintenance RunBook

## 문서 목적

본 문서는 OpenManager Claude Code 하네스를 지속적으로 유지관리하기 위한 RunBook을 정의한다.

하네스 유지관리는 다음 원칙을 따른다.

- Rule, Skill, Agent, Workflow는 변경 이력을 남긴다.
- 변경 전 기존 구조를 검색한다.
- 변경 전 Change Plan을 작성한다.
- 변경 후 단계 전용 점검 스크립트를 실행한다.
- 기존 SigNoz Playwright Agent와 기존 Hook은 임의 수정하지 않는다.
- 운영 기준 변경은 사용자 승인을 받은 후 반영한다.

## 유지관리 대상

| 대상 | 위치 | 유지관리 기준 |
|---|---|---|
| Steering | `CLAUDE.md` | 프로젝트 목적, 보존 원칙, 작업 방식 최신화 |
| Rule | `.claude/rules/om/` | 변경 영역별 기준 보완 |
| Skill | `.claude/skills/` | 수동 호출 목적과 allowed-tools 검토 |
| Agent | `.claude/agents/om/` | 전문 검토 역할과 경계 보완 |
| Hook | `.claude/hooks/om/` | 위험 명령, 민감 파일, Tool 로그 기준 관리 |
| Workflow | `docs/harness/workflows/` | 작업 절차와 검증 흐름 보완 |
| Template | `docs/harness/templates/` | 기록 양식과 검토 항목 보완 |
| Scenario | `docs/harness/scenarios/` | 대표 시나리오 보강 |
| Inventory | `docs/harness/*INVENTORY.md` | 산출물 목록과 운영 기준 최신화 |
| Script | `docs/harness/scripts/` | 단계별 점검 스크립트 유지 |

## 유지관리 주기

| 주기 | 점검 항목 |
|---|---|
| 매 작업 전 | 요청 유형, Rule, Skill, Agent 적용 여부 확인 |
| Commit 전 | Quality Gate와 민감 파일 확인 |
| Push 전 | 사용자 승인과 대상 브랜치 확인 |
| 주 1회 | 최근 변경 이력과 Tool 사용 감사 결과 확인 |
| 월 1회 | Rule, Skill, Agent, Workflow 정합성 검토 |
| 주요 변경 전 | Scenario Validation 재검토 |
| 운영 적용 전 | Harness Release Checklist 수행 |

## 유지관리 기본 절차

```text
1. 유지관리 요청 접수
2. 변경 대상 분류
3. 기존 파일 검색
4. 영향 범위 확인
5. Change Plan 작성
6. 사용자 승인 필요 여부 판단
7. 변경 수행
8. 단계 전용 점검 스크립트 실행
9. Implementation Validation 수행
10. Quality Gate 수행
11. Change History 작성
12. Tool Usage Audit 수행
13. Commit / Push
```

## Rule 유지관리 기준

Rule 변경 시 다음 항목을 확인한다.

| 항목 | 확인 내용 |
|---|---|
| 변경 사유 | 기존 Rule로 부족한 기준이 무엇인지 |
| 적용 범위 | 공통 Rule인지 경로별 Rule인지 |
| 충돌 여부 | 기존 Rule과 상충하지 않는지 |
| 보안 영향 | 권한, Secret, 운영 명령 기준 영향 |
| 검증 기준 | 어떤 점검으로 정상 여부를 확인할지 |

Rule 변경 시 기존 Rule을 삭제하기보다 보완하는 방식을 우선한다.

## Skill 유지관리 기준

Skill 변경 시 다음 항목을 확인한다.

| 항목 | 확인 내용 |
|---|---|
| 목적 | Skill이 수행하는 역할이 명확한지 |
| 호출 방식 | 사용자가 직접 호출하는 형태인지 |
| allowed-tools | 불필요한 Tool 권한이 포함되지 않았는지 |
| disable-model-invocation | 수동 호출 기준이 필요한지 |
| 참조 문서 | 관련 Workflow, Template, Inventory와 연결되는지 |
| 출력 형식 | 운영자가 재사용 가능한 형식인지 |

Skill에는 불필요한 `Write`, `Edit`, 운영 명령 권한을 넣지 않는다.

## Agent 유지관리 기준

Agent 변경 시 다음 항목을 확인한다.

| 항목 | 확인 내용 |
|---|---|
| 역할 | 특정 전문 영역에 집중하는지 |
| 책임 경계 | 다른 Agent와 역할이 중복되지 않는지 |
| 검토 기준 | Rule, Workflow, Quality Gate와 연결되는지 |
| upstream 보존 | SigNoz 원본 구조 훼손 위험이 없는지 |
| 보안 기준 | Secret, 인증, 운영 명령 기준을 따르는지 |

기존 SigNoz Playwright Agent는 OpenManager 하네스 유지관리 과정에서 수정하지 않는다.

## Workflow 유지관리 기준

Workflow 변경 시 다음 항목을 확인한다.

| 항목 | 확인 내용 |
|---|---|
| 절차 명확성 | 작업 순서가 명확한지 |
| 입력 기준 | 어떤 요청에서 사용하는지 |
| 출력 기준 | 어떤 형식으로 결과를 남기는지 |
| 승인 기준 | 사용자 승인이 필요한 시점이 명시되어 있는지 |
| Audit 연결 | Change History와 Tool Usage Audit에 연결되는지 |

## Template 유지관리 기준

Template 변경 시 다음 항목을 확인한다.

| 항목 | 확인 내용 |
|---|---|
| 기록 항목 | 운영에 필요한 항목이 빠지지 않았는지 |
| 중복 여부 | 기존 Template과 과도하게 중복되지 않는지 |
| 보안 기준 | Secret 원문 기록을 요구하지 않는지 |
| 검증 기준 | PASS, WARN, FAIL 기준이 명확한지 |
| 재사용성 | 실제 작업 결과에 바로 사용할 수 있는지 |

## Hook 유지관리 기준

Hook 변경은 위험도가 높은 작업으로 분류한다.

Hook 변경 전에는 다음 항목을 반드시 정리한다.

| 항목 | 확인 내용 |
|---|---|
| 변경 사유 | 기존 Hook으로 처리할 수 없는 이유 |
| 차단 영향 | 정상 명령이 과도하게 차단되지 않는지 |
| 보안 영향 | 위험 명령과 민감 파일 보호가 약화되지 않는지 |
| 로그 영향 | Tool 사용 로그 누락 가능성 |
| 검증 방법 | 차단, 허용, 로그 기록 테스트 방법 |
| 사용자 승인 | Hook 변경 승인 여부 |

Hook 변경은 기존 동작을 약화시키지 않는 방향으로 수행한다.

## Inventory 유지관리 기준

Inventory는 하네스 운영 기준의 기준표 역할을 한다.

| Inventory | 관리 대상 |
|---|---|
| MCP Inventory | MCP 서버와 외부 도구 사용 정책 |
| Quality Gates Inventory | 구현 검증과 Commit 전 품질 기준 |
| Audit Trail Inventory | 변경 이력과 Tool 사용 감사 기준 |
| Scenario Validation Inventory | 대표 시나리오 기반 검증 기준 |
| Harness Operation Inventory | 운영 적용과 유지관리 기준 |

Inventory 문서는 신규 Workflow, Skill, Scenario가 추가될 때 함께 갱신한다.

## 운영 장애 또는 오동작 대응

하네스가 기대와 다르게 동작하면 아래 순서로 확인한다.

```text
1. 현재 요청 유형 확인
2. 적용 Rule 확인
3. 호출한 Skill 확인
4. 사용한 Agent 확인
5. 관련 Workflow 확인
6. Hook 차단 여부 확인
7. Tool 사용 로그 확인
8. 변경 파일 범위 확인
9. Quality Gate 결과 확인
10. Change History 기록 확인
```

## 유지관리 시 금지 사항

- 기존 SigNoz Playwright Agent를 임의 수정하지 않는다.
- 기존 Hook 파일을 승인 없이 수정하지 않는다.
- `.claude/settings.local.json`을 Git에 포함하지 않는다.
- Secret 원문을 문서나 로그에 기록하지 않는다.
- 운영 명령을 검증 목적으로 실행하지 않는다.
- 통합 점검 스크립트를 작성하지 않는다.
- 현재 유지관리 범위 밖의 파일을 함께 변경하지 않는다.

## 유지관리 결과 기록

유지관리 결과는 아래 형식으로 정리한다.

```text
OpenManager Harness Maintenance 결과

1. 유지관리 대상
-

2. 변경 사유
-

3. 변경 파일
- 생성:
- 수정:
- 삭제:
- 제외:

4. 영향 범위
- Rule:
- Skill:
- Agent:
- Workflow:
- Hook:
- 운영 영향:

5. 검증 결과
- 단계 전용 점검:
- Quality Gate:
- Tool Audit:

6. 보안 확인
- 민감 파일:
- Secret 원문:
- 개인 설정:

7. 사용자 승인 필요 사항
-

8. Commit / Push 정보
-
```