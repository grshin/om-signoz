# OpenManager Claude Code Agents Inventory

## 문서 목적

본 문서는 OpenManager Claude Code 하네스에서 사용하는 Project Sub-Agent의 목록, 목적, 도구 범위, 적용 Rule, 사용 기준을 관리한다.

09단계에서는 전문 구현 Agent가 아니라 검토·분석 중심 Agent를 구성한다. 구현 요청 템플릿과 Workflow는 10단계 이후에서 별도로 구성한다.

## Agent 저장 위치

| 구분 | 경로 | 적용 범위 |
|---|---|---|
| Project Agent | `.claude/agents/` | 현재 OpenManager 프로젝트 |
| User Agent | `~/.claude/agents/` | 사용자 전체 프로젝트 |
| Plugin Agent | Plugin 내부 `agents/` | Plugin 활성화 범위 |

OpenManager 하네스에서는 팀 공유가 필요한 Agent만 Project Agent로 관리한다.

## 09단계 생성 Agent

| Agent | 경로 | 역할 | 도구 |
|---|---|---|---|
| `om-architecture-reviewer` | `.claude/agents/om/om-architecture-reviewer.md` | 아키텍처와 upstream 경계 검토 | Read, Grep, Glob, Bash |
| `om-backend-go-reviewer` | `.claude/agents/om/om-backend-go-reviewer.md` | Go backend 변경 검토 | Read, Grep, Glob, Bash |
| `om-frontend-react-reviewer` | `.claude/agents/om/om-frontend-react-reviewer.md` | React frontend 변경 검토 | Read, Grep, Glob, Bash |
| `om-otel-pipeline-reviewer` | `.claude/agents/om/om-otel-pipeline-reviewer.md` | OTel pipeline 변경 검토 | Read, Grep, Glob, Bash |
| `om-deploy-kubernetes-reviewer` | `.claude/agents/om/om-deploy-kubernetes-reviewer.md` | Docker, Kubernetes, Helm 변경 검토 | Read, Grep, Glob, Bash |
| `om-security-quality-reviewer` | `.claude/agents/om/om-security-quality-reviewer.md` | 보안과 품질 게이트 검토 | Read, Grep, Glob, Bash |

## 기존 SigNoz Playwright Agent 보존

다음 기존 Agent는 수정하지 않는다.

```text
.claude/agents/playwright-test-planner.md
.claude/agents/playwright-test-generator.md
.claude/agents/playwright-test-healer.md
```

## Agent 호출 예시

```text
om-architecture-reviewer를 사용해서 이번 변경의 upstream 충돌 가능성을 검토해 주세요.
```

```text
om-backend-go-reviewer를 사용해서 backend 변경 위험과 검증 계획을 정리해 주세요.
```

```text
om-security-quality-reviewer를 사용해서 Commit 전 민감 파일 포함 여부를 검토해 주세요.
```

## 운영 기준

| 기준 | 설명 |
|---|---|
| 검토 중심 | Agent는 분석과 검토를 우선하며 직접 수정하지 않는다. |
| 최소 도구 | Edit, Write 도구는 부여하지 않는다. |
| Rule 연계 | 05단계 Rule을 기준으로 판단한다. |
| Skill 연계 | 08단계 Skill을 참고한다. |
| 보안 우선 | 인증 정보와 개인 설정 파일을 읽지 않는다. |
| Git 제한 | Commit과 Push는 사용자가 별도로 요청한 경우에만 제안한다. |

## 09단계 완료 기준

| 항목 | 완료 기준 |
|---|---|
| Project Agent | 6개 OpenManager 전문 Agent 생성 |
| Frontmatter | 각 Agent에 name, description 포함 |
| Tool 제한 | Edit, Write 도구 미포함 |
| Inventory | `docs/harness/AGENTS_INVENTORY.md` 작성 |
| 점검 스크립트 | `check-step09-agents.sh` 단독 실행 가능 |
| 기존 Agent | SigNoz Playwright Agent 미수정 |
| Git 제외 | 개인 설정과 인증 정보 미포함 |