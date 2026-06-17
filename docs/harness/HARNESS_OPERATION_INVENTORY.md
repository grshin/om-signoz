# OpenManager Harness Operation Inventory

## 문서 목적

본 문서는 OpenManager Claude Code 하네스의 운영 적용 기준과 유지관리 체계를 관리한다.

15단계에서는 01~14단계에서 구성한 하네스 산출물을 실제 OpenManager 고도화 작업에 적용하기 위한 운영 기준, 유지관리 주기, 승인 기준, Release 기준을 정의한다.

## 15단계 생성 문서

| 문서 | 경로 | 목적 |
|---|---|---|
| Harness Operation Policy | `docs/harness/operations/harness-operation-policy.md` | 하네스 운영 적용 기준 정의 |
| Harness Maintenance RunBook | `docs/harness/operations/harness-maintenance-runbook.md` | Rule, Skill, Agent, Workflow 유지관리 절차 정의 |

## 15단계 생성 Template

| Template | 경로 | 목적 |
|---|---|---|
| Harness Release Checklist Template | `docs/harness/templates/harness-release-checklist-template.md` | 하네스 운영 적용 또는 변경 전 점검 양식 |
| Harness Maintenance Review Template | `docs/harness/templates/harness-maintenance-review-template.md` | 정기 유지관리 리뷰 양식 |

## 15단계 생성 Skill

| Skill | 경로 | 역할 |
|---|---|---|
| `om-harness-operation` | `.claude/skills/om-harness-operation/SKILL.md` | 하네스 운영 적용 상태와 유지관리 상태 점검 |

## 15단계 생성 Script

| Script | 경로 | 역할 |
|---|---|---|
| 15단계 전용 점검 스크립트 | `docs/harness/scripts/check-step15-harness-operation.sh` | 15단계 산출물만 점검 |

## 하네스 운영 흐름

OpenManager 고도화 작업은 아래 흐름을 기준으로 운영한다.

```text
사용자 요청
→ 요청 유형 분류
→ Spec 기반 요청 정리
→ Rule 선택
→ Search-First 분석
→ Change Plan 작성
→ 구현
→ Implementation Validation
→ Quality Gate
→ Change History
→ Tool Usage Audit
→ Commit
→ Push
```

대표 시나리오 또는 하네스 변경 전에는 아래 흐름을 추가 적용한다.

```text
Scenario Validation
→ Harness Operation Review
→ Release Checklist
```

## 운영 적용 대상

| 대상 | 운영 기준 |
|---|---|
| Backend Go 변경 | Backend Rule과 Backend Reviewer 적용 |
| Frontend React 변경 | Frontend Rule과 Frontend Reviewer 적용 |
| OTel Pipeline 변경 | OTel Rule, cardinality, ClickHouse 영향 확인 |
| Kubernetes / Helm 변경 | Deploy Rule, 사용자 승인, Tool Audit 적용 |
| Harness 변경 | 기존 Agent, Hook, settings 보존 확인 |
| 문서 변경 | 변경 목적과 영향 범위에 따라 선택 적용 |
| Git Commit / Push | Quality Gate와 사용자 승인 기준 적용 |

## 주요 Inventory 연결

| Inventory | 역할 |
|---|---|
| `MCP_SERVERS_INVENTORY.md` | MCP 서버와 외부 도구 사용 정책 관리 |
| `QUALITY_GATES_INVENTORY.md` | 구현 검증과 Commit 전 품질 기준 관리 |
| `AUDIT_TRAIL_INVENTORY.md` | 변경 이력과 Tool 사용 감사 기준 관리 |
| `SCENARIO_VALIDATION_INVENTORY.md` | 대표 시나리오 검증 기준 관리 |
| `HARNESS_OPERATION_INVENTORY.md` | 운영 적용과 유지관리 기준 관리 |

## 운영 기준 문서 연결

| 구분 | 문서 |
|---|---|
| 운영 정책 | `docs/harness/operations/harness-operation-policy.md` |
| 유지관리 RunBook | `docs/harness/operations/harness-maintenance-runbook.md` |
| Release Checklist | `docs/harness/templates/harness-release-checklist-template.md` |
| Maintenance Review | `docs/harness/templates/harness-maintenance-review-template.md` |
| Scenario Validation | `docs/harness/workflows/scenario-validation-workflow.md` |
| Change History | `docs/harness/workflows/change-history-workflow.md` |
| Tool Usage Audit | `docs/harness/workflows/tool-usage-audit-workflow.md` |
| Quality Gate | `docs/harness/workflows/quality-gate-workflow.md` |
| Implementation Validation | `docs/harness/workflows/implementation-validation-workflow.md` |

## Skill 운영 기준

| Skill | 운영 적용 시점 |
|---|---|
| `om-project-context` | 프로젝트 기준 확인 시 |
| `om-rule-router` | 요청 유형별 Rule 선택 시 |
| `om-spec-request` | 구현 요청을 Spec으로 정리할 때 |
| `om-search-first-analysis` | 기존 구현과 영향 범위 분석 시 |
| `om-change-plan` | 변경 전 계획 수립 시 |
| `om-change-risk-review` | 위험도 검토 시 |
| `om-validation-plan` | 구현 전 검증 계획 수립 시 |
| `om-implementation-validation` | 구현 후 검증 결과 정리 시 |
| `om-quality-gate` | Commit / Push 전 품질 점검 시 |
| `om-change-history` | 변경 이력 기록 시 |
| `om-tool-audit` | Tool 사용 로그 감사 시 |
| `om-scenario-validation` | 대표 시나리오 검증 시 |
| `om-harness-operation` | 운영 적용과 유지관리 점검 시 |

## Agent 운영 기준

| Agent | 운영 적용 기준 |
|---|---|
| `om-architecture-reviewer` | 구조, 책임, upstream 경계 검토 |
| `om-backend-go-reviewer` | Backend Go API, service, query 변경 검토 |
| `om-frontend-react-reviewer` | React UI, state, component 변경 검토 |
| `om-otel-pipeline-reviewer` | OTel Pipeline, ClickHouse, cardinality 검토 |
| `om-deploy-kubernetes-reviewer` | Kubernetes, Helm, Docker 변경 검토 |
| `om-security-quality-reviewer` | Secret, 권한, 품질, 운영 위험 검토 |

## 보존 대상

아래 파일은 하네스 운영 중 기본적으로 보존한다.

### 기존 SigNoz Playwright Agent

```text
.claude/agents/playwright-test-planner.md
.claude/agents/playwright-test-generator.md
.claude/agents/playwright-test-healer.md
```

### 기존 Hook

```text
.claude/hooks/om/om-block-dangerous-bash.sh
.claude/hooks/om/om-protect-sensitive-files.sh
.claude/hooks/om/om-log-tool-usage.sh
```

### 개인 설정 및 민감 파일

```text
.claude/settings.local.json
.env
.pem
.key
.p12
.pfx
id_rsa
id_ed25519
.kube
.aws
.ssh
claude.json
```

## 유지관리 주기

| 주기 | 점검 대상 |
|---|---|
| 매 작업 전 | 요청 유형, Rule, Skill, Agent 적용 기준 |
| 구현 전 | Search-First, Change Plan, 승인 필요 항목 |
| Commit 전 | Implementation Validation, Quality Gate, 민감 파일 |
| Push 전 | 사용자 승인, 대상 브랜치, 원격 반영 대상 |
| 주 1회 | 최근 변경 이력, Tool Usage Audit 결과 |
| 월 1회 | Rule, Skill, Agent, Workflow, Template 정합성 |
| 주요 변경 전 | Scenario Validation, Release Checklist |
| 운영 적용 전 | Harness Operation Review |

## 승인 필요 기준

| 항목 | 승인 필요 사유 |
|---|---|
| Git Push | 원격 저장소 이력 변경 |
| 기존 SigNoz Playwright Agent 변경 | 기존 기능 영향 가능 |
| 기존 Hook 변경 | Guardrail 동작 영향 |
| Tool 권한 확대 | 보안 위험 증가 |
| Kubernetes / Helm 명령 실행 | 클러스터 또는 릴리스 변경 |
| Secret 또는 인증 설정 변경 | 민감 정보와 권한 영향 |
| DB schema 또는 ClickHouse table 변경 | 저장 구조와 query 영향 |
| upstream 구조 변경 | SigNoz 원본 구조 충돌 가능성 |
| 대량 파일 변경 | 영향 범위 확대 |

## 운영 명령 제한 기준

아래 명령은 사용자 승인 없이 실행하지 않는다.

```text
kubectl apply
kubectl delete
kubectl rollout
helm upgrade
helm uninstall
docker compose down
docker compose up -d
docker stop
docker rm
git push
git reset --hard
git clean -fdx
```

## 운영 적용 결과 분류

| 결과 | 의미 | 처리 |
|---|---|---|
| PASS | 운영 적용 기준 충족 | 진행 가능 |
| WARN | 확인 필요 항목 있음 | 사용자 확인 또는 보완 |
| FAIL | 운영 적용 기준 미충족 | 보완 후 재검토 |
| N/A | 해당 없음 | 사유 기록 |

## Release 판단 기준

| 판단 | 기준 |
|---|---|
| 가능 | FAIL 없음, 민감 파일 없음, 승인 필요 항목 처리됨 |
| 보류 | WARN이 있고 사용자 확인이 필요함 |
| 불가 | FAIL이 있거나 민감 파일, Secret, 승인 없는 운영 명령이 포함됨 |

## 운영 원칙

- 하네스 운영 기준은 OpenManager 고도화 작업의 기본 작업 방식으로 적용한다.
- 구현 전 기존 구조를 먼저 확인한다.
- 변경 전 Change Plan을 작성한다.
- 구현 후 검증과 Quality Gate를 수행한다.
- 변경 이력과 Tool 사용 감사 결과를 기록한다.
- 사용자 승인 없이 운영 명령을 실행하지 않는다.
- 사용자 승인 없이 Git Push를 실행하지 않는다.
- Secret 원문은 읽거나 기록하지 않는다.
- 개인 설정 파일은 Git에 포함하지 않는다.
- 기존 SigNoz Playwright Agent는 임의 수정하지 않는다.
- 기존 Hook 파일은 임의 수정하지 않는다.
- 통합 점검 스크립트는 작성하지 않는다.
- 단계별 점검 스크립트는 해당 단계 산출물만 점검한다.