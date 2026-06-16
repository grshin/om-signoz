# OpenManager Spec Templates Inventory

## 문서 목적

본 문서는 OpenManager Claude Code 하네스에서 사용하는 Spec 기반 개발 요청 템플릿의 목록, 목적, 적용 Rule, 관련 Skill, 관련 Agent를 관리한다.

10단계에서는 구현 전에 요청을 구조화하기 위한 템플릿을 구성한다.

## 10단계 생성 템플릿

| 템플릿 | 경로 | 목적 |
|---|---|---|
| Common Spec | `docs/harness/templates/spec-request-common.md` | 모든 개발 요청 공통 양식 |
| Backend Go Spec | `docs/harness/templates/spec-request-backend-go.md` | Go backend 변경 요청 |
| Frontend React Spec | `docs/harness/templates/spec-request-frontend-react.md` | React frontend 변경 요청 |
| OTel Pipeline Spec | `docs/harness/templates/spec-request-otel-pipeline.md` | OTel pipeline 변경 요청 |
| Deploy Kubernetes Spec | `docs/harness/templates/spec-request-deploy-kubernetes.md` | 배포 구성 변경 요청 |

## 관련 Skill

| Skill | 경로 | 역할 |
|---|---|---|
| `om-spec-request` | `.claude/skills/om-spec-request/SKILL.md` | 요청을 Spec 기반으로 구조화 |
| `om-project-context` | `.claude/skills/om-project-context/SKILL.md` | 프로젝트 맥락 정렬 |
| `om-rule-router` | `.claude/skills/om-rule-router/SKILL.md` | 적용 Rule 선택 |
| `om-validation-plan` | `.claude/skills/om-validation-plan/SKILL.md` | 검증 계획 수립 |
| `om-change-risk-review` | `.claude/skills/om-change-risk-review/SKILL.md` | 변경 위험 검토 |

## 관련 Agent

| 요청 유형 | 관련 Agent |
|---|---|
| Common | `om-architecture-reviewer`, `om-security-quality-reviewer` |
| Backend Go | `om-backend-go-reviewer`, `om-architecture-reviewer`, `om-security-quality-reviewer` |
| Frontend React | `om-frontend-react-reviewer`, `om-architecture-reviewer`, `om-security-quality-reviewer` |
| OTel Pipeline | `om-otel-pipeline-reviewer`, `om-backend-go-reviewer`, `om-deploy-kubernetes-reviewer` |
| Deploy Kubernetes | `om-deploy-kubernetes-reviewer`, `om-security-quality-reviewer` |

## 사용 기준

| 상황 | 사용할 템플릿 |
|---|---|
| 요청 범위가 불명확함 | Common Spec |
| API 또는 Go service 변경 | Backend Go Spec |
| UI 또는 React component 변경 | Frontend React Spec |
| Telemetry 수집·처리·저장 변경 | OTel Pipeline Spec |
| Kubernetes 또는 Helm 변경 | Deploy Kubernetes Spec |

## 운영 기준

- Spec을 먼저 작성한 뒤 구현 여부를 판단한다.
- Claude Code가 바로 구현하지 않도록 요청 문장에 명시한다.
- 관련 Rule, Skill, Agent를 먼저 정리한다.
- 운영 영향이 있으면 사용자 승인을 먼저 받는다.
- Git Commit / Push는 검증 후 Checkpoint에서만 수행한다.

## 10단계 완료 기준

| 항목 | 완료 기준 |
|---|---|
| Spec 템플릿 | 5개 템플릿 생성 완료 |
| Spec Skill | `om-spec-request` Skill 생성 완료 |
| Inventory | `SPEC_TEMPLATES_INVENTORY.md` 작성 |
| 점검 스크립트 | `check-step10-spec-templates.sh` 단독 실행 가능 |
| 기존 Agent | SigNoz Playwright Agent 미수정 |
| 보안 | 개인 설정과 Secret 미포함 |