# OpenManager Workflows Inventory

## 문서 목적

본 문서는 OpenManager Claude Code 하네스에서 사용하는 Workflow의 목록, 목적, 관련 Template, 관련 Skill, 관련 Agent, 관련 Rule을 관리한다.

11단계에서는 구현 전 검색·분석과 변경 계획 수립을 위한 Search-First Workflow를 구성한다.

## 11단계 생성 Workflow

| Workflow | 경로 | 목적 |
|---|---|---|
| Search-First Analysis Workflow | `docs/harness/workflows/search-first-analysis-workflow.md` | 구현 전 기존 소스, 문서, Rule, Skill, Agent를 먼저 검색하고 분석 |
| Change Plan Workflow | `docs/harness/workflows/change-plan-workflow.md` | Search-First 분석 결과를 바탕으로 구현 전 변경 계획 작성 |

## 11단계 생성 Template

| Template | 경로 | 목적 |
|---|---|---|
| Search-First Analysis Template | `docs/harness/templates/search-first-analysis-template.md` | 검색 결과, 기존 구현, 영향 범위, 위험 요소 정리 |
| Change Plan Template | `docs/harness/templates/change-plan-template.md` | 변경 대상, 변경 방식, 위험도, 검증 계획, 승인 항목 정리 |

## 11단계 생성 Skill

| Skill | 경로 | 역할 |
|---|---|---|
| `om-search-first-analysis` | `.claude/skills/om-search-first-analysis/SKILL.md` | 구현 전 기존 구현과 영향 범위 분석 |
| `om-change-plan` | `.claude/skills/om-change-plan/SKILL.md` | 구현 전 변경 계획 작성 |

## 관련 기존 Skill

| Skill | 역할 |
|---|---|
| `om-project-context` | OpenManager 프로젝트 기준 확인 |
| `om-rule-router` | 변경 영역에 맞는 Rule 선택 |
| `om-validation-plan` | 검증 계획 수립 |
| `om-change-risk-review` | 변경 위험 검토 |
| `om-spec-request` | 10단계 Spec 기반 요청 정리 |

## 관련 Agent

| 요청 유형 | 관련 Agent |
|---|---|
| Architecture | `om-architecture-reviewer` |
| Backend Go | `om-backend-go-reviewer` |
| Frontend React | `om-frontend-react-reviewer` |
| OTel Pipeline | `om-otel-pipeline-reviewer` |
| Deploy Kubernetes | `om-deploy-kubernetes-reviewer` |
| Security / Quality | `om-security-quality-reviewer` |

## 관련 Rule

### 공통 Rule

| Rule | 목적 |
|---|---|
| `.claude/rules/om/architecture.md` | OpenManager 구조와 설계 기준 |
| `.claude/rules/om/upstream-boundary.md` | SigNoz upstream 충돌 방지 |
| `.claude/rules/om/security-policy.md` | 보안과 민감 정보 보호 |
| `.claude/rules/om/quality-gate.md` | 검증과 품질 기준 |

### 경로별 Rule

| Rule | 목적 |
|---|---|
| `.claude/rules/om/backend-go.md` | Go backend 변경 기준 |
| `.claude/rules/om/frontend-react.md` | React frontend 변경 기준 |
| `.claude/rules/om/otel-pipeline.md` | OTel pipeline 변경 기준 |
| `.claude/rules/om/deploy-kubernetes.md` | Docker, Kubernetes, Helm 변경 기준 |

## 사용 기준

| 상황 | 사용할 Workflow |
|---|---|
| 구현 전에 기존 구현을 먼저 찾아야 함 | Search-First Analysis Workflow |
| 여러 파일을 수정해야 함 | Change Plan Workflow |
| Backend와 Frontend가 함께 변경됨 | Search-First Analysis + Change Plan |
| OTel 또는 ClickHouse 영향이 있음 | Search-First Analysis + Change Plan |
| Kubernetes 또는 Helm 변경이 있음 | Search-First Analysis + Change Plan |
| 운영 영향이 있음 | Search-First Analysis + Change Plan + 사용자 승인 |
| 단순 문서 수정 | 필요 시 선택 적용 |

## 운영 원칙

- 구현보다 검색을 먼저 수행한다.
- 수정보다 변경 계획을 먼저 작성한다.
- 운영 영향이 있으면 사용자 승인을 먼저 받는다.
- Secret, `.env`, key, pem, 개인 설정 파일은 읽지 않는다.
- Git Commit / Push는 사용자가 명시적으로 요청하거나 승인한 경우에만 수행한다.
- 단계별 점검 스크립트는 현재 단계 전용으로만 작성한다.
- 통합 점검 스크립트는 작성하지 않는다.
- 기존 SigNoz Playwright Agent는 수정하지 않는다.

## 11단계 완료 기준

| 항목 | 완료 기준 |
|---|---|
| Workflow 문서 | Search-First Analysis, Change Plan Workflow 생성 |
| Template | Search-First Analysis, Change Plan Template 생성 |
| Skill | `om-search-first-analysis`, `om-change-plan` Skill 생성 |
| Inventory | `WORKFLOWS_INVENTORY.md` 작성 |
| 점검 스크립트 | `check-step11-search-first-workflow.sh` 단독 실행 가능 |
| 기존 Agent | SigNoz Playwright Agent 미수정 |
| 보안 | 개인 설정과 Secret 미포함 |