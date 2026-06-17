# OpenManager Harness 변경 시나리오

## 시나리오 목적

OpenManager Claude Code 하네스 자체 변경 요청이 들어왔을 때 기존 Rule, Skill, Agent, Hook을 안전하게 보존하면서 변경 계획과 검증 흐름을 적용할 수 있는지 확인한다.

## 사용자 요청 예시

```text
OpenManager 하네스에 신규 검증 Skill을 추가하려고 합니다.
기존 Skill과 Workflow 구조를 먼저 확인하고, 기존 SigNoz Playwright Agent와 Hook 파일을 수정하지 않는 변경 계획을 작성해 주세요.
```

## 요청 유형

| 요청 유형 | 해당 여부 | 판단 근거 |
|---|---:|---|
| Backend Go | 아니오 | Backend 코드 변경 요청 아님 |
| Frontend React | 아니오 | Frontend 코드 변경 요청 아님 |
| OTel Pipeline | 아니오 | Pipeline 변경 요청 아님 |
| Docker / Kubernetes / Helm | 아니오 | 배포 설정 변경 요청 아님 |
| Harness | 예 | Rule, Skill, Workflow, Agent 변경 가능 |
| Docs | 예 | 하네스 문서 변경 가능 |
| Security / Quality | 예 | 권한, Tool 제한, 민감 파일 기준 확인 필요 |
| Architecture | 예 | 하네스 구조와 upstream 경계 확인 필요 |

## 적용 Rule

| Rule | 적용 여부 | 사유 |
|---|---:|---|
| `.claude/rules/om/architecture.md` | 예 | 하네스 구조와 책임 확인 |
| `.claude/rules/om/upstream-boundary.md` | 예 | 기존 SigNoz 설정 보존 |
| `.claude/rules/om/security-policy.md` | 예 | Tool 권한과 민감 정보 보호 |
| `.claude/rules/om/quality-gate.md` | 예 | 검증과 Commit 기준 적용 |

## 관련 Skill

| Skill | 적용 여부 | 사용 목적 |
|---|---:|---|
| `om-project-context` | 예 | OpenManager 하네스 기준 확인 |
| `om-rule-router` | 예 | 적용 Rule 선택 |
| `om-search-first-analysis` | 예 | 기존 Skill, Workflow, Agent 검색 |
| `om-change-plan` | 예 | 변경 대상과 제외 대상 정리 |
| `om-implementation-validation` | 예 | 구현 후 검증 결과 정리 |
| `om-quality-gate` | 예 | Commit 전 품질 확인 |
| `om-change-history` | 예 | 변경 이력 기록 |
| `om-tool-audit` | 예 | Tool 사용 감사 |

## 관련 Agent

| Agent | 적용 여부 | 사용 목적 |
|---|---:|---|
| `om-architecture-reviewer` | 예 | 하네스 구조와 upstream 경계 검토 |
| `om-security-quality-reviewer` | 예 | 보안, Tool 권한, 품질 기준 검토 |
| `om-backend-go-reviewer` | 아니오 | Backend 변경 요청 아님 |
| `om-frontend-react-reviewer` | 아니오 | Frontend 변경 요청 아님 |
| `om-otel-pipeline-reviewer` | 아니오 | Pipeline 변경 요청 아님 |
| `om-deploy-kubernetes-reviewer` | 아니오 | 배포 변경 요청 아님 |

## Search-First 확인 항목

| 확인 항목 | 설명 |
|---|---|
| 기존 Skill | `.claude/skills` 구조 확인 |
| 기존 Workflow | `docs/harness/workflows` 문서 확인 |
| 기존 Template | `docs/harness/templates` 문서 확인 |
| 기존 Agent | `.claude/agents` 구조 확인 |
| 기존 Hook | `.claude/hooks/om` 파일 존재 여부 확인 |
| Inventory | 기존 Inventory 문서 확인 |
| settings | `settings.local.json`은 읽거나 추적하지 않음 |

## Change Plan 확인 항목

| 항목 | 확인 내용 |
|---|---|
| 생성 파일 | 신규 Skill, Workflow, Template, Inventory |
| 수정 파일 | 필요한 경우 Inventory 문서 |
| 제외 파일 | 기존 SigNoz Playwright Agent, Hook, settings.local.json |
| 위험도 | Tool 권한, 자동 실행, 민감 파일 접근 위험 |
| 검증 계획 | frontmatter, allowed-tools, Secret 문자열, 단계 전용 점검 |

## 구현 검증 기준

| 검증 항목 | 기준 |
|---|---|
| Skill frontmatter | name, description, allowed-tools 확인 |
| Tool 제한 | 불필요한 Edit, Write 권한 방지 |
| 기존 Agent 보존 | Playwright Agent 미수정 |
| 기존 Hook 보존 | Hook 파일 미수정 |
| 개인 설정 | settings.local.json 미추적 |
| 점검 스크립트 | 현재 단계 전용으로만 작성 |

## Quality Gate 기준

| Gate | 확인 내용 |
|---|---|
| 변경 범위 | 하네스 관련 신규 파일 중심 |
| 민감 파일 | 인증 정보와 개인 설정 미포함 |
| 기존 Agent | SigNoz Playwright Agent 미수정 |
| 기존 Hook | Hook 파일 미수정 |
| Stage 파일 | 현재 단계 파일만 포함 |
| Commit 메시지 | 하네스 변경 목적 포함 |

## 승인 필요 항목

| 항목 | 승인 필요 여부 | 사유 |
|---|---:|---|
| 기존 Agent 수정 | 필요 | 기존 SigNoz 기능 영향 |
| 기존 Hook 수정 | 필요 | Guardrail 동작 영향 |
| settings 변경 | 필요 | 개인 또는 공용 설정 영향 |
| Tool 권한 확대 | 필요 | 보안 영향 |
| Git Commit / Push | 필요 | Repository 이력 변경 |

## 시나리오 검증 결과 기준

| 항목 | 기대 결과 |
|---|---|
| 요청 유형 분류 | Harness와 Docs 중심으로 분류 |
| Rule 선택 | architecture, upstream, security, quality 적용 |
| Agent 선택 | architecture-reviewer, security-quality-reviewer 중심 |
| Workflow 흐름 | Search-First → Change Plan → Validation → Quality Gate → Audit Trail |
| 위험 작업 | 기존 Agent, Hook, settings 파일 수정 없이 신규 하네스 문서 중심으로 제한 |