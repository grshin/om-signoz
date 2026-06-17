---
name: OpenManager Scenario Validation
description: OpenManager 대표 시나리오를 기준으로 Rule, Skill, Agent, Workflow 적용 흐름과 위험 요소, 승인 필요 항목을 검증할 때 사용한다.
when_to_use: Backend API, Frontend Dashboard, OTel Pipeline, Kubernetes Deploy, Harness 변경 시나리오를 기준으로 OpenManager Claude Code 하네스 동작을 검증해야 할 때 사용한다.
disable-model-invocation: true
allowed-tools: Read Grep Glob Bash
---

# OpenManager Scenario Validation Skill

## 목적

OpenManager Claude Code 하네스가 대표 변경 시나리오에서 정상적으로 동작하는지 검증한다.

이 Skill은 실제 소스 변경이나 배포를 수행하지 않고, 시나리오 기준으로 다음 항목을 확인한다.

- 요청 유형 분류
- 적용 Rule 선택
- 관련 Skill 선택
- 관련 Agent 선택
- Workflow 적용 흐름
- 위험 요소 식별
- 사용자 승인 필요 항목
- 금지 작업 미실행 여부

## 사용 방식

사용자가 다음과 같이 직접 호출한다.

```text
/om-scenario-validation Backend API 변경 시나리오 기준으로 하네스 흐름을 검증해 주세요.
```

```text
/om-scenario-validation OTel Pipeline 변경 시나리오에서 적용 Rule, Skill, Agent를 확인해 주세요.
```

```text
/om-scenario-validation Kubernetes 배포 변경 시나리오 기준으로 승인 필요 항목을 정리해 주세요.
```

```text
/om-scenario-validation Harness 변경 시나리오 기준으로 기존 Agent와 Hook 보존 여부를 검증해 주세요.
```

## 참조 Workflow 및 Template

| 구분 | 경로 |
|---|---|
| Scenario Validation Workflow | `docs/harness/workflows/scenario-validation-workflow.md` |
| Scenario Validation Template | `docs/harness/templates/scenario-validation-template.md` |

## 참조 Scenario

| 시나리오 | 경로 |
|---|---|
| Backend API 변경 | `docs/harness/scenarios/om-backend-api-change-scenario.md` |
| Frontend Dashboard 변경 | `docs/harness/scenarios/om-frontend-dashboard-change-scenario.md` |
| OTel Pipeline 변경 | `docs/harness/scenarios/om-otel-pipeline-change-scenario.md` |
| Kubernetes 배포 변경 | `docs/harness/scenarios/om-deploy-kubernetes-change-scenario.md` |
| Harness 변경 | `docs/harness/scenarios/om-harness-change-scenario.md` |

## 수행 절차

1. 검증할 대표 시나리오를 선택한다.
2. 사용자 요청 예시를 확인한다.
3. 요청 유형을 분류한다.
4. 공통 Rule과 경로별 Rule을 선택한다.
5. 관련 Skill을 선택한다.
6. 관련 Agent를 선택한다.
7. Workflow 적용 흐름을 확인한다.
8. Search-First 분석 필요 여부를 판단한다.
9. Change Plan 필요 여부를 판단한다.
10. 구현 검증과 Quality Gate 기준을 확인한다.
11. Change History와 Tool Usage Audit 기록 항목을 확인한다.
12. 위험 요소와 사용자 승인 필요 항목을 정리한다.
13. 금지 작업이 실행되지 않았는지 확인한다.
14. 시나리오 검증 결과를 PASS, WARN, FAIL로 정리한다.

## 요청 유형 분류 기준

| 요청 유형 | 판단 기준 |
|---|---|
| Backend Go | Go API, service, query, model, storage 변경 |
| Frontend React | UI, dashboard, component, route, state, API client 변경 |
| OTel Pipeline | collector, receiver, processor, exporter, telemetry attribute 변경 |
| ClickHouse | table, view, query, retention, aggregation 변경 |
| Deploy Kubernetes | Docker, Kubernetes, Helm, values, manifest 변경 |
| Harness | `.claude`, Rule, Skill, Agent, Hook, Workflow, Template 변경 |
| Docs | 문서 또는 템플릿 변경 |
| Security / Quality | Secret, 인증, 권한, 품질 게이트, 검증 기준 변경 |
| Architecture | 구조, 책임 분리, upstream 경계 영향 |

## 공통 Rule 선택 기준

| Rule | 적용 기준 |
|---|---|
| `.claude/rules/om/architecture.md` | 모든 시나리오에서 구조와 책임 확인 |
| `.claude/rules/om/upstream-boundary.md` | SigNoz 원본 구조와 충돌 가능성이 있는 경우 |
| `.claude/rules/om/security-policy.md` | Secret, 인증, 민감 정보, 권한 영향이 있는 경우 |
| `.claude/rules/om/quality-gate.md` | 구현 검증, Commit, Push 판단이 필요한 경우 |

## 경로별 Rule 선택 기준

| 변경 영역 | Rule |
|---|---|
| Backend Go | `.claude/rules/om/backend-go.md` |
| Frontend React | `.claude/rules/om/frontend-react.md` |
| OTel Pipeline | `.claude/rules/om/otel-pipeline.md` |
| Deploy Kubernetes | `.claude/rules/om/deploy-kubernetes.md` |

## 시나리오별 우선 Agent

| 시나리오 | 우선 Agent |
|---|---|
| Backend API 변경 | `om-backend-go-reviewer` |
| Frontend Dashboard 변경 | `om-frontend-react-reviewer` |
| OTel Pipeline 변경 | `om-otel-pipeline-reviewer` |
| Kubernetes 배포 변경 | `om-deploy-kubernetes-reviewer` |
| Harness 변경 | `om-architecture-reviewer`, `om-security-quality-reviewer` |

## 시나리오별 주요 검증 항목

| 시나리오 | 주요 검증 항목 |
|---|---|
| Backend API 변경 | API 영향, query 영향, response model, error handling, test 계획 |
| Frontend Dashboard 변경 | component, route, state, API client, loading/error/empty 처리 |
| OTel Pipeline 변경 | receiver, processor, exporter, ClickHouse, cardinality, retention |
| Kubernetes 배포 변경 | values, manifest, Secret 참조, resource, rollback, 운영 승인 |
| Harness 변경 | Rule, Skill, Agent, Workflow, Hook 보존, settings.local.json 미추적 |

## Workflow 흐름 확인 기준

| Workflow | 확인 내용 |
|---|---|
| Spec 기반 요청 정리 | 요청 목적, 범위, 제외 대상 정리 여부 |
| Search-First Analysis | 기존 구현 검색과 영향 분석 여부 |
| Change Plan | 변경 대상, 위험도, 검증 계획 정리 여부 |
| Implementation Validation | 구현 후 검증 항목 정의 여부 |
| Quality Gate | Commit / Push 전 품질 기준 정의 여부 |
| Change History | 변경 이력 기록 항목 정의 여부 |
| Tool Usage Audit | Tool 사용 로그와 위험 작업 확인 여부 |

## 승인 필요 항목 판단 기준

아래 항목은 사용자 승인이 필요하다.

| 항목 | 승인 필요 사유 |
|---|---|
| 운영 환경 영향 | 서비스 동작, 배포, 리소스 변경 가능성 |
| Kubernetes / Helm 적용 | 클러스터 리소스 변경 가능성 |
| Secret 또는 인증 설정 변경 | 민감 정보와 권한 영향 |
| DB schema 또는 ClickHouse table 변경 | 저장 구조와 query 영향 |
| 데이터 삭제 또는 migration | 데이터 손실 가능성 |
| upstream 구조 변경 | SigNoz 원본 구조와 충돌 가능성 |
| 기존 Agent 또는 Hook 수정 | 기존 하네스 동작 영향 |
| Tool 권한 확대 | 보안 영향 |
| Git Commit / Push | repository 이력 변경 |

## 출력 형식

```text
OpenManager Scenario Validation 결과

1. 시나리오명
-

2. 사용자 요청 예시
-

3. 요청 유형
- Backend:
- Frontend:
- OTel:
- Deploy:
- Harness:
- Docs:

4. 적용 Rule
- 공통 Rule:
- 경로별 Rule:

5. 관련 Skill
- Spec:
- Search-First:
- Change Plan:
- Validation:
- Quality Gate:
- Audit:

6. 관련 Agent
-

7. Workflow 적용 흐름
- Spec:
- Search-First:
- Change Plan:
- Implementation Validation:
- Quality Gate:
- Change History:
- Tool Usage Audit:

8. 위험 요소
- upstream:
- security:
- operation:
- quality:
- rollback:

9. 사용자 승인 필요 사항
-

10. 시나리오 검증 결과
- PASS:
- WARN:
- FAIL:
- 보완 필요 사항:
```

## 금지 사항

- 실제 소스 변경을 수행하지 않는다.
- 실제 배포 명령을 실행하지 않는다.
- Secret 원문을 조회하지 않는다.
- `.env`, key, pem, 개인 설정 파일을 읽지 않는다.
- 사용자 승인 없이 Git Commit 또는 Push를 실행하지 않는다.
- 기존 SigNoz Playwright Agent를 수정하지 않는다.
- 기존 Hook 파일을 수정하지 않는다.
- 통합 점검 스크립트를 작성하지 않는다.