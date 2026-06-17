# OpenManager Scenario Validation Inventory

## 문서 목적

본 문서는 OpenManager Claude Code 하네스에서 사용하는 대표 시나리오 기반 검증 항목을 관리한다.

14단계에서는 Backend API, Frontend Dashboard, OTel Pipeline, Kubernetes Deploy, Harness 변경 시나리오를 기준으로 01~13단계에서 구성한 Rule, Skill, Agent, Workflow가 실제 작업 흐름에 맞게 연결되는지 확인한다.

## 14단계 생성 Workflow

| Workflow | 경로 | 목적 |
|---|---|---|
| Scenario Validation Workflow | `docs/harness/workflows/scenario-validation-workflow.md` | 대표 시나리오 기반 하네스 검증 절차 정의 |

## 14단계 생성 Template

| Template | 경로 | 목적 |
|---|---|---|
| Scenario Validation Template | `docs/harness/templates/scenario-validation-template.md` | 시나리오별 Rule, Skill, Agent, Workflow, 위험 요소, 승인 필요 항목 기록 |

## 14단계 생성 Skill

| Skill | 경로 | 역할 |
|---|---|---|
| `om-scenario-validation` | `.claude/skills/om-scenario-validation/SKILL.md` | 대표 시나리오 기준 하네스 적용 흐름 검증 |

## 14단계 대표 시나리오

| 시나리오 | 경로 | 검증 목적 |
|---|---|---|
| Backend API 변경 | `docs/harness/scenarios/om-backend-api-change-scenario.md` | Backend Go API 변경 흐름 검증 |
| Frontend Dashboard 변경 | `docs/harness/scenarios/om-frontend-dashboard-change-scenario.md` | React Dashboard 변경 흐름 검증 |
| OTel Pipeline 변경 | `docs/harness/scenarios/om-otel-pipeline-change-scenario.md` | OTel 수집, 처리, 저장 영향 분석 흐름 검증 |
| Kubernetes 배포 변경 | `docs/harness/scenarios/om-deploy-kubernetes-change-scenario.md` | Kubernetes / Helm 변경 승인과 검증 흐름 확인 |
| Harness 변경 | `docs/harness/scenarios/om-harness-change-scenario.md` | Rule, Skill, Workflow 등 하네스 자체 변경 검증 |

## 관련 기존 Workflow

| Workflow | 역할 |
|---|---|
| Spec 기반 요청 정리 | 요청 목적, 범위, 제외 대상 정리 |
| Search-First Analysis Workflow | 구현 전 기존 구조 검색과 영향 분석 |
| Change Plan Workflow | 구현 전 변경 대상, 위험도, 검증 계획 작성 |
| Implementation Validation Workflow | 구현 후 변경 범위, 문법, 테스트, 보안 검증 |
| Quality Gate Workflow | Commit / Push 전 품질 기준 확인 |
| Change History Workflow | 변경 작업 이력 기록 |
| Tool Usage Audit Workflow | Tool 사용 로그 기반 감사 추적 |

## 관련 기존 Skill

| Skill | 역할 |
|---|---|
| `om-project-context` | OpenManager 프로젝트 기준 확인 |
| `om-rule-router` | 변경 영역에 맞는 Rule 선택 |
| `om-spec-request` | Spec 기반 요청 정리 |
| `om-search-first-analysis` | 기존 구현 검색과 영향 분석 |
| `om-change-plan` | 구현 전 변경 계획 수립 |
| `om-change-risk-review` | 변경 위험 검토 |
| `om-validation-plan` | 검증 계획 수립 |
| `om-implementation-validation` | 구현 후 검증 결과 정리 |
| `om-quality-gate` | Commit / Push 전 품질 게이트 확인 |
| `om-change-history` | 변경 이력 기록 |
| `om-tool-audit` | Tool 사용 로그 감사 |
| `om-scenario-validation` | 대표 시나리오 검증 |

## 관련 Agent

| 요청 유형 | 관련 Agent |
|---|---|
| Architecture | `om-architecture-reviewer` |
| Backend Go | `om-backend-go-reviewer` |
| Frontend React | `om-frontend-react-reviewer` |
| OTel Pipeline | `om-otel-pipeline-reviewer` |
| Deploy Kubernetes | `om-deploy-kubernetes-reviewer` |
| Security / Quality | `om-security-quality-reviewer` |

## 시나리오별 적용 기준

| 시나리오 | 주요 Rule | 주요 Agent | 주요 Skill |
|---|---|---|---|
| Backend API 변경 | `backend-go.md`, `architecture.md`, `quality-gate.md` | `om-backend-go-reviewer` | `om-spec-request`, `om-search-first-analysis`, `om-change-plan` |
| Frontend Dashboard 변경 | `frontend-react.md`, `architecture.md`, `quality-gate.md` | `om-frontend-react-reviewer` | `om-spec-request`, `om-search-first-analysis`, `om-validation-plan` |
| OTel Pipeline 변경 | `otel-pipeline.md`, `upstream-boundary.md`, `security-policy.md` | `om-otel-pipeline-reviewer` | `om-search-first-analysis`, `om-change-risk-review`, `om-validation-plan` |
| Kubernetes 배포 변경 | `deploy-kubernetes.md`, `security-policy.md`, `quality-gate.md` | `om-deploy-kubernetes-reviewer` | `om-search-first-analysis`, `om-change-plan`, `om-tool-audit` |
| Harness 변경 | `architecture.md`, `upstream-boundary.md`, `security-policy.md` | `om-architecture-reviewer`, `om-security-quality-reviewer` | `om-change-plan`, `om-implementation-validation`, `om-quality-gate` |

## 시나리오 검증 항목

| 검증 항목 | 통과 기준 |
|---|---|
| 요청 유형 분류 | 시나리오에 맞는 요청 유형이 선택됨 |
| Rule 선택 | 공통 Rule과 경로별 Rule이 적절히 연결됨 |
| Skill 선택 | 작업 흐름에 맞는 Skill이 선택됨 |
| Agent 선택 | 검토 영역에 맞는 전문 Agent가 선택됨 |
| Workflow 연결 | Spec, Search-First, Change Plan, Validation, Quality Gate, Audit Trail 흐름이 연결됨 |
| 위험 요소 식별 | upstream, security, operation, quality, rollback 위험이 식별됨 |
| 승인 필요 항목 | 운영 영향, Secret, DB, Git, 배포 관련 승인 필요 여부가 정의됨 |
| 금지 작업 미실행 | 실제 소스 변경, 배포 명령, Secret 조회가 수행되지 않음 |

## 금지 작업 기준

14단계 시나리오 검증에서는 아래 작업을 수행하지 않는다.

| 금지 작업 | 사유 |
|---|---|
| 실제 소스 변경 | 시나리오 기반 검증 단계이므로 변경하지 않음 |
| 실제 배포 명령 | 운영 영향 방지 |
| `kubectl apply` | 클러스터 변경 방지 |
| `helm upgrade` | 릴리스 변경 방지 |
| `kubectl delete` | 리소스 삭제 방지 |
| Secret 원문 조회 | 민감 정보 보호 |
| `.env`, key, pem 파일 읽기 | 민감 정보 보호 |
| 기존 SigNoz Playwright Agent 수정 | 기존 SigNoz 설정 보존 |
| 기존 Hook 파일 수정 | Guardrail 동작 보존 |
| 통합 점검 스크립트 작성 | 단계별 점검 원칙 준수 |

## 시나리오별 승인 필요 항목

| 시나리오 | 승인 필요 항목 |
|---|---|
| Backend API 변경 | API 응답 구조 변경, ClickHouse query 변경, DB schema 변경 |
| Frontend Dashboard 변경 | 신규 Backend API 필요, API 응답 구조 변경, 대시보드 UX 변경 |
| OTel Pipeline 변경 | Collector config 변경, ClickHouse table 변경, cardinality 증가 가능성 |
| Kubernetes 배포 변경 | `kubectl apply`, `helm upgrade`, Secret 변경, replica / resource 변경 |
| Harness 변경 | 기존 Agent 수정, 기존 Hook 수정, settings 변경, Tool 권한 확대 |

## 결과 분류 기준

| 결과 | 의미 | 처리 |
|---|---|---|
| PASS | 시나리오 기준 충족 | 다음 단계 진행 가능 |
| WARN | 확인이 필요한 항목 있음 | 보완 또는 사용자 확인 필요 |
| FAIL | 하네스 흐름 누락 또는 금지 작업 위험 있음 | 보완 후 재검증 |
| N/A | 해당 없음 | 사유 기록 |

## 운영 원칙

- 대표 시나리오는 실제 작업 전 하네스 흐름을 점검하기 위한 기준이다.
- 실제 소스 변경이나 운영 명령은 수행하지 않는다.
- 위험 작업은 승인 필요 항목으로만 기록한다.
- Secret 원문은 조회하거나 기록하지 않는다.
- 기존 SigNoz Playwright Agent는 수정하지 않는다.
- 기존 Hook 파일은 수정하지 않는다.
- 통합 점검 스크립트는 작성하지 않는다.
- 현재 단계 전용 점검 스크립트만 작성한다.