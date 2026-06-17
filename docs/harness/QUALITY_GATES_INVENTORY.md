# OpenManager Quality Gates Inventory

## 문서 목적

본 문서는 OpenManager Claude Code 하네스에서 사용하는 구현 검증 및 Quality Gate 항목, 적용 시점, 관련 Workflow, 관련 Template, 관련 Skill을 관리한다.

12단계에서는 구현 후 검증과 Commit / Push 전 품질 게이트 기준을 구성한다.

## 12단계 생성 Workflow

| Workflow | 경로 | 목적 |
|---|---|---|
| Implementation Validation Workflow | `docs/harness/workflows/implementation-validation-workflow.md` | 구현 후 변경 범위, 문법, 테스트, 빌드, 보안 확인 절차 정의 |
| Quality Gate Workflow | `docs/harness/workflows/quality-gate-workflow.md` | Commit / Push 전 품질 게이트 절차 정의 |

## 12단계 생성 Template

| Template | 경로 | 목적 |
|---|---|---|
| Implementation Validation Template | `docs/harness/templates/implementation-validation-template.md` | 구현 검증 결과 정리 |
| Quality Gate Result Template | `docs/harness/templates/quality-gate-result-template.md` | Quality Gate 결과 정리 |

## 12단계 생성 Skill

| Skill | 경로 | 역할 |
|---|---|---|
| `om-implementation-validation` | `.claude/skills/om-implementation-validation/SKILL.md` | 구현 후 검증 결과 정리 |
| `om-quality-gate` | `.claude/skills/om-quality-gate/SKILL.md` | Commit / Push 전 품질 게이트 확인 |

## 관련 기존 Skill

| Skill | 역할 |
|---|---|
| `om-project-context` | OpenManager 프로젝트 기준 확인 |
| `om-rule-router` | 변경 영역에 맞는 Rule 선택 |
| `om-validation-plan` | 검증 계획 수립 |
| `om-change-risk-review` | 변경 위험 검토 |
| `om-spec-request` | Spec 기반 요청 정리 |
| `om-search-first-analysis` | 구현 전 기존 구조 검색과 영향 분석 |
| `om-change-plan` | 구현 전 변경 계획 수립 |

## 관련 Agent

| 요청 유형 | 관련 Agent |
|---|---|
| Architecture | `om-architecture-reviewer` |
| Backend Go | `om-backend-go-reviewer` |
| Frontend React | `om-frontend-react-reviewer` |
| OTel Pipeline | `om-otel-pipeline-reviewer` |
| Deploy Kubernetes | `om-deploy-kubernetes-reviewer` |
| Security / Quality | `om-security-quality-reviewer` |

## Quality Gate 항목

| Gate | 항목 | 목적 | 실패 시 조치 |
|---|---|---|---|
| Gate 1 | 변경 범위 확인 | 현재 단계 산출물 중심 변경 여부 확인 | 불필요 파일 제거 또는 Stage 제외 |
| Gate 2 | 민감 파일 확인 | Secret, 개인 설정 파일 포함 방지 | 즉시 제거 또는 Git 추적 제외 |
| Gate 3 | 단계 전용 점검 확인 | 현재 단계 산출물 정상 여부 확인 | FAIL 수정 후 재실행 |
| Gate 4 | 기존 Agent 보존 확인 | SigNoz Playwright Agent 미수정 확인 | 의도 여부 확인 후 불필요 시 원복 |
| Gate 5 | Stage 파일 확인 | Commit 대상 파일 확인 | Stage 해제 후 재선택 |
| Gate 6 | Commit 메시지 확인 | 단계와 변경 내용이 드러나는 메시지 확인 | 메시지 수정 |
| Gate 7 | Push 전 확인 | 브랜치와 최근 Commit 확인 | 브랜치 상태 확인 후 Push 판단 |

## 적용 시점

| 시점 | 적용 Gate |
|---|---|
| 구현 완료 직후 | Gate 1, Gate 2, Gate 3, Gate 4 |
| Stage 전 | Gate 1, Gate 2 |
| Stage 후 | Gate 2, Gate 5 |
| Commit 전 | Gate 3, Gate 4, Gate 5, Gate 6 |
| Push 전 | Gate 7 |
| 운영 영향 작업 전 | 사용자 승인 추가 확인 |

## 결과 기준

| 결과 | 의미 | 처리 |
|---|---|---|
| PASS | 기준 충족 | 다음 단계 진행 가능 |
| WARN | 진행 가능하나 확인 필요 | 사유 확인 후 진행 판단 |
| FAIL | 기준 미충족 | Commit / Push 전 수정 필요 |

## 민감 파일 기준

아래 항목은 Git 변경 또는 Stage 대상에 포함되면 안 된다.

```text
settings.local.json
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

## 운영 원칙

- Commit 전에는 단계 전용 점검 스크립트를 실행한다.
- FAIL이 있으면 Commit하지 않는다.
- 민감 파일이 있으면 Commit하지 않는다.
- 사용자 승인 없이 Push하지 않는다.
- 운영 명령은 사용자 승인 전 실행하지 않는다.
- Secret 원문은 조회하지 않는다.
- 기존 SigNoz Playwright Agent는 수정하지 않는다.
- 통합 점검 스크립트는 작성하지 않는다.
- 현재 단계와 무관한 전체 점검을 강제하지 않는다.