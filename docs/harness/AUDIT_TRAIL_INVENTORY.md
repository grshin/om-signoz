# OpenManager Audit Trail Inventory

## 문서 목적

본 문서는 OpenManager Claude Code 하네스에서 사용하는 변경 이력, Tool 사용 로그, 감사 추적 기준을 관리한다.

13단계에서는 변경 작업의 요청, 분석, 구현, 검증, Commit / Push 이력을 기록하고 Tool 사용 로그를 감사 추적 근거로 연결한다.

## 13단계 생성 Workflow

| Workflow | 경로 | 목적 |
|---|---|---|
| Change History Workflow | `docs/harness/workflows/change-history-workflow.md` | 변경 작업의 요청, 분석, 계획, 구현, 검증, Git 이력 기록 절차 정의 |
| Tool Usage Audit Workflow | `docs/harness/workflows/tool-usage-audit-workflow.md` | Tool 사용 로그를 기반으로 위험 명령, 민감 파일 접근, 운영 명령 사용 여부 감사 |

## 13단계 생성 Template

| Template | 경로 | 목적 |
|---|---|---|
| Change History Template | `docs/harness/templates/change-history-template.md` | 변경 이력 기록 양식 |
| Tool Usage Audit Template | `docs/harness/templates/tool-usage-audit-template.md` | Tool 사용 감사 결과 기록 양식 |

## 13단계 생성 Skill

| Skill | 경로 | 역할 |
|---|---|---|
| `om-change-history` | `.claude/skills/om-change-history/SKILL.md` | 변경 작업의 요청, 분석, 구현, 검증, Git 이력 정리 |
| `om-tool-audit` | `.claude/skills/om-tool-audit/SKILL.md` | Tool 사용 로그 기반 감사 결과 정리 |

## 관련 기존 Workflow

| Workflow | 역할 |
|---|---|
| Spec 기반 요청 정리 | 구현 요청의 목적과 범위 정리 |
| Search-First Analysis Workflow | 구현 전 기존 구조 검색과 영향 분석 |
| Change Plan Workflow | 구현 전 변경 계획과 승인 항목 정리 |
| Implementation Validation Workflow | 구현 후 검증 결과 정리 |
| Quality Gate Workflow | Commit / Push 전 품질 기준 확인 |

## 관련 기존 Skill

| Skill | 역할 |
|---|---|
| `om-project-context` | OpenManager 프로젝트 기준 확인 |
| `om-rule-router` | 변경 영역에 맞는 Rule 선택 |
| `om-spec-request` | Spec 기반 요청 정리 |
| `om-search-first-analysis` | 기존 구현 검색과 영향 분석 |
| `om-change-plan` | 구현 전 변경 계획 수립 |
| `om-implementation-validation` | 구현 후 검증 결과 정리 |
| `om-quality-gate` | Commit / Push 전 품질 게이트 확인 |
| `om-change-history` | 변경 이력 기록 |
| `om-tool-audit` | Tool 사용 감사 |

## 관련 Agent

| 요청 유형 | 관련 Agent |
|---|---|
| Architecture | `om-architecture-reviewer` |
| Backend Go | `om-backend-go-reviewer` |
| Frontend React | `om-frontend-react-reviewer` |
| OTel Pipeline | `om-otel-pipeline-reviewer` |
| Deploy Kubernetes | `om-deploy-kubernetes-reviewer` |
| Security / Quality | `om-security-quality-reviewer` |

## Tool 사용 로그 기준

06단계에서 구성한 Tool 사용 로그 Hook을 기준으로 아래 경로를 기본 로그 위치로 사용한다.

```text
.claude/logs/tool-usage.log
```

로그 파일이 없을 경우에는 N/A로 기록하고 사유를 남긴다.

```text
Tool 사용 로그: 없음
분류: N/A
사유: 해당 작업에서 Tool 사용 로그가 생성되지 않았거나 Hook 기록 대상 작업이 없었음
```

## 감사 대상 항목

| 감사 항목 | 설명 | 결과 기준 |
|---|---|---|
| 위험 Bash 명령 | 삭제, 초기화, 강제 변경 명령 | PASS / WARN / FAIL |
| 민감 파일 접근 | `.env`, key, pem, 개인 설정 파일 접근 | PASS / WARN / FAIL |
| 운영 명령 | kubectl, helm, docker 운영 영향 명령 | PASS / WARN / FAIL |
| Git 명령 | add, commit, push, reset, clean | PASS / WARN / FAIL |
| Hook 차단 기록 | 위험 명령 또는 민감 파일 차단 여부 | PASS / WARN / FAIL / N/A |
| 로그 존재 여부 | Tool 사용 로그 파일 존재 여부 | PASS / N/A |

## 위험 명령 패턴

| 패턴 | 위험 |
|---|---|
| `rm -rf` | 파일 삭제 |
| `git reset --hard` | 작업 내용 강제 초기화 |
| `git clean -fdx` | 추적되지 않은 파일 강제 삭제 |
| `kubectl delete` | Kubernetes 리소스 삭제 |
| `kubectl apply` | Kubernetes 리소스 변경 |
| `helm upgrade` | Helm release 변경 |
| `helm uninstall` | Helm release 삭제 |
| `docker system prune` | Docker 리소스 삭제 |
| `chmod -R 777` | 과도한 권한 부여 |
| `chown -R` | 대량 소유권 변경 |

## 민감 파일 패턴

| 패턴 | 설명 |
|---|---|
| `.env` | 환경 변수와 Secret 포함 가능 |
| `.pem` | 인증서 또는 개인키 포함 가능 |
| `.key` | 개인키 포함 가능 |
| `.p12`, `.pfx` | 인증서 번들 포함 가능 |
| `id_rsa`, `id_ed25519` | SSH 개인키 |
| `.kube` | Kubernetes 인증 설정 |
| `.aws` | AWS 인증 설정 |
| `.ssh` | SSH 설정과 키 |
| `settings.local.json` | Claude Code 개인 로컬 설정 |
| `claude.json` | 개인 또는 세션 설정 포함 가능 |

## 변경 이력 기록 기준

| 항목 | 기록 여부 |
|---|---:|
| 사용자 요청 요약 | 기록 |
| Spec 기반 요청 여부 | 기록 |
| Search-First 분석 여부 | 기록 |
| Change Plan 작성 여부 | 기록 |
| 변경 파일 | 기록 |
| 검증 결과 | 기록 |
| Quality Gate 결과 | 기록 |
| Tool 사용 감사 결과 | 기록 |
| Commit 메시지 | 기록 |
| Push 여부 | 기록 |
| 사용자 승인 항목 | 기록 |
| Secret 원문 | 기록 금지 |
| 개인 설정 내용 | 기록 금지 |

## 결과 분류 기준

| 결과 | 의미 | 처리 |
|---|---|---|
| PASS | 기준 충족 | 변경 이력에 정상 기록 |
| WARN | 확인 필요 | 사용자 확인 또는 사유 기록 |
| FAIL | 기준 미충족 | Commit / Push 전 조치 필요 |
| N/A | 해당 없음 또는 로그 없음 | 사유 기록 |

## 운영 원칙

- 변경에는 이력을 남긴다.
- Tool 사용 로그는 감사 근거로 연결한다.
- Secret 원문은 기록하지 않는다.
- 개인 설정 파일 내용은 기록하지 않는다.
- 민감 파일이 Git 이력에 포함되면 안 된다.
- 사용자 승인 없이 운영 명령을 실행하지 않는다.
- 사용자 승인 없이 Push하지 않는다.
- 기존 SigNoz Playwright Agent는 수정하지 않는다.
- 기존 Hook 파일은 이번 단계에서 수정하지 않는다.
- 통합 점검 스크립트는 작성하지 않는다.
- 현재 단계와 무관한 전체 점검을 강제하지 않는다.