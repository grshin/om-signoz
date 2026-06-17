# OpenManager Harness Operation Policy

## 문서 목적

본 문서는 OpenManager Claude Code 하네스를 실제 OpenManager 고도화 작업에 적용하기 위한 운영 기준을 정의한다.

하네스 운영 기준은 다음 원칙을 따른다.

- 모든 구현 요청은 가능한 한 Spec 기반으로 정리한다.
- 기존 구현을 확인하지 않고 바로 수정하지 않는다.
- 변경 전 Search-First 분석과 Change Plan을 우선 수행한다.
- 구현 후 Implementation Validation과 Quality Gate를 수행한다.
- Commit 전 변경 범위, 민감 파일, 기존 Agent 보존 여부를 확인한다.
- Push 전 사용자 승인 여부를 확인한다.
- 변경 이력과 Tool 사용 감사 결과를 남긴다.
- Secret 원문, 인증 정보, 개인 설정 파일은 기록하거나 Git에 포함하지 않는다.

## 운영 적용 대상

| 대상 | 적용 기준 |
|---|---|
| Backend Go 변경 | Spec, Search-First, Change Plan, Backend Reviewer 적용 |
| Frontend React 변경 | Spec, Search-First, Change Plan, Frontend Reviewer 적용 |
| OTel Pipeline 변경 | Search-First, Change Risk Review, Validation Plan 적용 |
| Kubernetes / Helm 변경 | 운영 영향 분석, 사용자 승인, Tool Audit 적용 |
| Harness 변경 | 기존 Agent, Hook, settings 보존 확인 |
| 문서 변경 | 변경 목적과 영향 범위에 따라 선택 적용 |
| 단순 질의 | 하네스 Workflow 적용 제외 가능 |

## 기본 운영 흐름

OpenManager 개발 요청은 아래 흐름을 기준으로 진행한다.

```text
1. 사용자 요청 접수
2. 요청 유형 분류
3. Spec 기반 요청 정리
4. Rule 선택
5. Search-First 분석
6. Change Plan 작성
7. 사용자 승인 필요 여부 확인
8. 구현
9. Implementation Validation
10. Quality Gate
11. Change History 작성
12. Tool Usage Audit
13. Commit
14. Push
```

## 요청 유형 분류 기준

| 요청 유형 | 판단 기준 | 우선 적용 Agent |
|---|---|---|
| Backend Go | API, service, query, model, storage 변경 | `om-backend-go-reviewer` |
| Frontend React | dashboard, component, route, state, API client 변경 | `om-frontend-react-reviewer` |
| OTel Pipeline | receiver, processor, exporter, telemetry attribute 변경 | `om-otel-pipeline-reviewer` |
| Deploy Kubernetes | Docker, Kubernetes, Helm, values, manifest 변경 | `om-deploy-kubernetes-reviewer` |
| Harness | Rule, Skill, Agent, Hook, Workflow, Template 변경 | `om-architecture-reviewer`, `om-security-quality-reviewer` |
| Security / Quality | Secret, 인증, 권한, 품질 기준 변경 | `om-security-quality-reviewer` |
| Architecture | 구조, 책임 분리, upstream 경계 영향 | `om-architecture-reviewer` |

## Rule 적용 기준

### 공통 Rule

| Rule | 적용 기준 |
|---|---|
| `.claude/rules/om/architecture.md` | 구조, 책임, 변경 범위 판단 시 적용 |
| `.claude/rules/om/upstream-boundary.md` | SigNoz 원본 구조와 충돌 가능성이 있을 때 적용 |
| `.claude/rules/om/security-policy.md` | Secret, 인증, 권한, 민감 정보 관련 작업에 적용 |
| `.claude/rules/om/quality-gate.md` | 구현, 검증, Commit, Push 판단 시 적용 |

### 경로별 Rule

| Rule | 적용 기준 |
|---|---|
| `.claude/rules/om/backend-go.md` | Go Backend 변경 시 적용 |
| `.claude/rules/om/frontend-react.md` | React Frontend 변경 시 적용 |
| `.claude/rules/om/otel-pipeline.md` | OTel Pipeline 변경 시 적용 |
| `.claude/rules/om/deploy-kubernetes.md` | Kubernetes / Helm / Docker 변경 시 적용 |

## Skill 운영 기준

| Skill | 운영 기준 |
|---|---|
| `om-project-context` | 프로젝트 기준 확인 시 사용 |
| `om-rule-router` | 요청 유형별 Rule 선택 시 사용 |
| `om-spec-request` | 구현 요청을 Spec 형태로 정리할 때 사용 |
| `om-search-first-analysis` | 기존 구현 검색과 영향 분석 시 사용 |
| `om-change-plan` | 변경 전 계획 수립 시 사용 |
| `om-change-risk-review` | OTel, Deploy, 보안, 대량 변경 위험 검토 시 사용 |
| `om-validation-plan` | 구현 전 검증 계획 수립 시 사용 |
| `om-implementation-validation` | 구현 후 검증 결과 정리 시 사용 |
| `om-quality-gate` | Commit / Push 전 품질 확인 시 사용 |
| `om-change-history` | 변경 이력 기록 시 사용 |
| `om-tool-audit` | Tool 사용 로그 감사 시 사용 |
| `om-scenario-validation` | 대표 시나리오 기준 하네스 검증 시 사용 |
| `om-harness-operation` | 운영 적용 상태와 유지관리 검토 시 사용 |

## Commit 전 운영 기준

Commit 전에는 다음 항목을 확인한다.

| 항목 | 기준 |
|---|---|
| 변경 범위 | 현재 요청 또는 현재 단계 산출물만 포함 |
| 민감 파일 | `.env`, `.pem`, `.key`, `.kube`, `.aws`, `.ssh`, `settings.local.json` 미포함 |
| 기존 Agent | 기존 SigNoz Playwright Agent 미수정 |
| 기존 Hook | 위험 명령 차단, 민감 파일 보호, Tool 로그 Hook 미수정 |
| 검증 결과 | Implementation Validation 결과 확인 |
| Quality Gate | FAIL 없는 상태 확인 |
| Commit 메시지 | 단계 번호와 변경 목적 포함 |

## Push 전 운영 기준

Push 전에는 다음 항목을 확인한다.

| 항목 | 기준 |
|---|---|
| 대상 브랜치 | `feature/om-harness-bootstrap` 기준 |
| 사용자 승인 | Push 전 명시적 승인 확인 |
| Stage 파일 | 현재 작업 범위만 포함 |
| Commit 상태 | Commit 완료 여부 확인 |
| 민감 파일 | Stage 및 Commit 대상에 민감 파일 미포함 |
| 원격 반영 | Push 후 `git status -sb`로 확인 |

## 운영 명령 승인 기준

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

운영 명령이 필요한 경우에는 아래 항목을 먼저 정리한다.

| 항목 | 설명 |
|---|---|
| 실행 목적 | 왜 실행해야 하는지 |
| 실행 환경 | local / dev / stage / prod |
| 영향 범위 | service, namespace, pod, volume, release |
| Rollback 방법 | 원복 가능 여부 |
| 사용자 승인 | 승인 여부 |

## Secret 및 민감 정보 운영 기준

아래 정보는 읽거나 기록하거나 Git에 포함하지 않는다.

```text
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
settings.local.json
claude.json
```

민감 파일 접근이 필요한 경우에는 원문을 열지 않고 아래 기준으로만 기록한다.

```text
민감 파일 접근 필요 여부:
파일 유형:
원문 조회 여부: 아니오
사용자 승인 필요 여부:
대체 확인 방법:
```

## 기존 SigNoz 자산 보존 기준

기존 SigNoz Playwright Agent는 수정하지 않는다.

```text
.claude/agents/playwright-test-planner.md
.claude/agents/playwright-test-generator.md
.claude/agents/playwright-test-healer.md
```

수정이 필요한 경우에는 별도 Change Plan과 사용자 승인이 필요하다.

## 기존 Hook 보존 기준

06단계에서 구성한 Hook 파일은 임의 수정하지 않는다.

```text
.claude/hooks/om/om-block-dangerous-bash.sh
.claude/hooks/om/om-protect-sensitive-files.sh
.claude/hooks/om/om-log-tool-usage.sh
```

Hook 변경이 필요한 경우에는 다음 항목을 먼저 정리한다.

| 항목 | 설명 |
|---|---|
| 변경 사유 | 왜 Hook 변경이 필요한지 |
| 영향 범위 | Tool 사용, 차단 정책, 로그 기록 영향 |
| 보안 영향 | 위험 명령 또는 민감 파일 보호 영향 |
| 검증 방법 | 변경 후 차단과 로그 기록 검증 |
| 사용자 승인 | 승인 여부 |

## 운영 결과 기록 기준

운영 적용 결과는 아래 문서에 연결한다.

| 기록 대상 | 문서 |
|---|---|
| 변경 계획 | Change Plan |
| 구현 검증 | Implementation Validation |
| 품질 기준 | Quality Gate |
| 변경 이력 | Change History |
| Tool 감사 | Tool Usage Audit |
| 대표 시나리오 검증 | Scenario Validation |
| 운영 적용 상태 | Harness Operation Review |

## 금지 사항

- 기존 구현을 확인하지 않고 바로 수정하지 않는다.
- 사용자 승인 없이 운영 명령을 실행하지 않는다.
- 사용자 승인 없이 Push하지 않는다.
- Secret 원문을 출력하지 않는다.
- 개인 로컬 설정 파일을 Git에 포함하지 않는다.
- 기존 SigNoz Playwright Agent를 임의 수정하지 않는다.
- 기존 Hook 파일을 임의 수정하지 않는다.
- 통합 점검 스크립트를 작성하지 않는다.
- 현재 단계와 무관한 전체 상태 점검을 강제하지 않는다.