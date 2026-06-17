---
name: OpenManager Harness Operation
description: OpenManager Claude Code 하네스의 운영 적용 기준, 유지관리 상태, Release Checklist, 정기 Review 결과를 정리할 때 사용한다.
when_to_use: OpenManager 하네스를 실제 개발 운영에 적용하기 전, 하네스 변경 Release 전, 정기 유지관리 리뷰 또는 운영 적용 상태를 점검해야 할 때 사용한다.
disable-model-invocation: true
allowed-tools: Read Grep Glob Bash
---

# OpenManager Harness Operation Skill

## 목적

OpenManager Claude Code 하네스의 운영 적용 상태와 유지관리 상태를 점검한다.

이 Skill은 다음 항목을 정리할 때 사용한다.

- 하네스 운영 적용 가능 여부
- 하네스 Release 전 점검 결과
- Rule / Skill / Agent / Workflow 유지관리 상태
- Hook / Guardrail 보존 여부
- Quality Gate와 Audit Trail 연결 상태
- 사용자 승인 필요 항목
- 개선 필요 사항

## 사용 방식

사용자가 다음과 같이 직접 호출한다.

```text
/om-harness-operation 15단계 운영 적용 기준을 기준으로 하네스 운영 상태를 점검해 주세요.
```

```text
/om-harness-operation 하네스 Release Checklist 기준으로 운영 적용 가능 여부를 정리해 주세요.
```

```text
/om-harness-operation Rule, Skill, Agent, Workflow 유지관리 상태를 리뷰해 주세요.
```

```text
/om-harness-operation Commit 전에 하네스 운영 기준과 민감 파일 포함 여부를 확인해 주세요.
```

## 참조 문서

| 구분 | 경로 |
|---|---|
| Harness Operation Policy | `docs/harness/operations/harness-operation-policy.md` |
| Harness Maintenance RunBook | `docs/harness/operations/harness-maintenance-runbook.md` |
| Harness Release Checklist Template | `docs/harness/templates/harness-release-checklist-template.md` |
| Harness Maintenance Review Template | `docs/harness/templates/harness-maintenance-review-template.md` |
| Harness Operation Inventory | `docs/harness/HARNESS_OPERATION_INVENTORY.md` |

## 관련 기존 Workflow

| Workflow | 목적 |
|---|---|
| Spec 기반 요청 정리 | 구현 요청 목적과 범위 정리 |
| Search-First Analysis | 기존 구현 검색과 영향 분석 |
| Change Plan | 구현 전 변경 계획 수립 |
| Implementation Validation | 구현 후 검증 결과 정리 |
| Quality Gate | Commit / Push 전 품질 기준 확인 |
| Change History | 변경 이력 기록 |
| Tool Usage Audit | Tool 사용 로그 감사 |
| Scenario Validation | 대표 시나리오 기반 하네스 검증 |

## 관련 기존 Skill

| Skill | 운영 기준 |
|---|---|
| `om-project-context` | 프로젝트 기준 확인 |
| `om-rule-router` | 요청 유형별 Rule 선택 |
| `om-spec-request` | Spec 기반 요청 정리 |
| `om-search-first-analysis` | 기존 구현 검색과 영향 분석 |
| `om-change-plan` | 변경 전 계획 수립 |
| `om-change-risk-review` | 위험 요소 검토 |
| `om-validation-plan` | 검증 계획 수립 |
| `om-implementation-validation` | 구현 후 검증 |
| `om-quality-gate` | Commit 전 품질 확인 |
| `om-change-history` | 변경 이력 기록 |
| `om-tool-audit` | Tool 사용 감사 |
| `om-scenario-validation` | 대표 시나리오 검증 |
| `om-harness-operation` | 운영 적용과 유지관리 상태 점검 |

## 수행 절차

1. 운영 점검 목적을 확인한다.
2. 대상 변경 또는 Release 범위를 확인한다.
3. 하네스 구성 요소 영향 여부를 확인한다.
4. Rule, Skill, Agent, Hook, Workflow, Template, Inventory 상태를 점검한다.
5. 민감 파일과 Secret 포함 여부를 확인한다.
6. 기존 SigNoz Playwright Agent 보존 여부를 확인한다.
7. 기존 Hook 파일 보존 여부를 확인한다.
8. 단계 전용 점검 스크립트 실행 결과를 확인한다.
9. Quality Gate와 Audit Trail 연결 여부를 확인한다.
10. 사용자 승인 필요 항목을 정리한다.
11. 운영 적용 가능 여부를 판단한다.
12. 개선 필요 항목을 정리한다.

## 운영 적용 점검 항목

| 항목 | 확인 내용 |
|---|---|
| 요청 범위 | 현재 요청 또는 현재 단계 범위에 한정되는지 |
| Rule | 공통 Rule과 경로별 Rule이 유지되는지 |
| Skill | Skill 목적과 allowed-tools가 적절한지 |
| Agent | Agent 역할과 책임 경계가 유지되는지 |
| Hook | 위험 명령 차단, 민감 파일 보호, Tool 로그 기준이 유지되는지 |
| Workflow | Spec, Search-First, Change Plan, Validation, Quality Gate 흐름이 연결되는지 |
| Template | 기록 항목과 PASS / WARN / FAIL 기준이 명확한지 |
| Inventory | 신규 산출물이 Inventory에 반영되는지 |
| Script | 현재 단계 전용 점검 스크립트가 존재하고 정상 실행되는지 |
| Audit | Change History와 Tool Usage Audit에 연결되는지 |

## Release 전 확인 명령

현재 Git 상태를 확인한다.

```text
git status --short
```

Stage 대상 파일을 확인한다.

```text
git diff --cached --name-only
```

민감 파일 포함 여부를 확인한다.

```text
git status --short | grep -E 'settings.local.json|\.env|\.pem|\.key|\.p12|\.pfx|id_rsa|id_ed25519|\.kube|\.aws|\.ssh|claude.json' || true
```

Stage에 민감 파일이 포함되었는지 확인한다.

```text
git diff --cached --name-only | grep -E 'settings.local.json|\.env|\.pem|\.key|\.p12|\.pfx|id_rsa|id_ed25519|\.kube|\.aws|\.ssh|claude.json' || true
```

기존 SigNoz Playwright Agent 변경 여부를 확인한다.

```text
git diff --name-only -- .claude/agents/playwright-test-planner.md .claude/agents/playwright-test-generator.md .claude/agents/playwright-test-healer.md
```

기존 Hook 파일 변경 여부를 확인한다.

```text
git diff --name-only -- .claude/hooks/om/om-block-dangerous-bash.sh .claude/hooks/om/om-protect-sensitive-files.sh .claude/hooks/om/om-log-tool-usage.sh
```

최근 Commit을 확인한다.

```text
git log --oneline --decorate -5
```

## 운영 적용 결과 분류

| 결과 | 의미 | 처리 |
|---|---|---|
| PASS | 운영 적용 기준 충족 | Commit 또는 Release 진행 가능 |
| WARN | 확인 필요 항목 있음 | 사유 기록 후 사용자 확인 |
| FAIL | 기준 미충족 | 보완 후 재점검 |
| N/A | 해당 없음 | 사유 기록 |

## 사용자 승인 필요 항목

아래 항목은 사용자 승인이 필요하다.

| 항목 | 승인 필요 사유 |
|---|---|
| Git Push | 원격 저장소 이력 변경 |
| 기존 Agent 변경 | 기존 SigNoz 또는 OM Agent 동작 영향 |
| 기존 Hook 변경 | Guardrail 동작 영향 |
| Tool 권한 확대 | 보안 위험 증가 |
| 운영 명령 실행 | 서비스 또는 클러스터 영향 |
| Secret 또는 인증 설정 변경 | 민감 정보와 권한 영향 |
| 대량 파일 변경 | 영향 범위 확대 |
| upstream 구조 변경 | SigNoz 원본 구조 충돌 가능성 |

## 출력 형식

```text
OpenManager Harness Operation 점검 결과

1. 점검 목적
-

2. 대상 범위
- 작업 단계:
- 대상 브랜치:
- 변경 대상:

3. 하네스 구성 요소 영향
- Rule:
- Skill:
- Agent:
- Hook:
- Workflow:
- Template:
- Inventory:
- Script:

4. 운영 적용 기준 확인
- Spec 흐름:
- Search-First:
- Change Plan:
- Implementation Validation:
- Quality Gate:
- Change History:
- Tool Usage Audit:
- Scenario Validation:

5. 보안 확인
- 민감 파일 포함 여부:
- Secret 원문 포함 여부:
- 개인 설정 파일 포함 여부:

6. 보존 확인
- 기존 SigNoz Playwright Agent:
- 기존 Hook:
- settings.local.json:

7. 점검 결과
- PASS:
- WARN:
- FAIL:
- N/A:

8. 사용자 승인 필요 사항
-

9. 운영 적용 판단
- 가능 / 보류 / 불가:

10. 개선 필요 사항
-
```

## 금지 사항

- Secret 원문을 출력하지 않는다.
- `.env`, key, pem, kubeconfig, credential 파일 내용을 읽지 않는다.
- 사용자 승인 없이 운영 명령을 실행하지 않는다.
- 사용자 승인 없이 Git Push를 실행하지 않는다.
- 기존 SigNoz Playwright Agent를 임의 수정하지 않는다.
- 기존 Hook 파일을 임의 수정하지 않는다.
- `.claude/settings.local.json`을 Git 추적 대상으로 만들지 않는다.
- 통합 점검 스크립트를 작성하지 않는다.
- 현재 점검 범위 밖의 파일을 함께 변경하지 않는다.