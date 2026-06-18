# OpenManager Team Onboarding Inventory

## 문서 목적

본 문서는 OpenManager HarnessOps v2의 팀 공통 온보딩 관련 산출물과 관리 기준을 정리한다.

21단계는 HarnessOps v2 1차 고도화의 마무리 단계이며, 팀원이 동일한 기준으로 AI Agent 기반 개발·검증·감사 절차를 수행할 수 있도록 한다.

## Team Onboarding 산출물 목록

| 구분 | 파일 | 역할 |
|---|---|---|
| Guide | `docs/harness/onboarding/TEAM_ONBOARDING_GUIDE.md` | 팀 공통 온보딩 가이드 |
| Guide | `docs/harness/onboarding/CLAUDE_CODE_USAGE_GUIDE.md` | Claude Code 사용 기준 |
| Scenario | `docs/harness/onboarding/HARNESSOPS_TRAINING_SCENARIO.md` | HarnessOps 교육 시나리오 |
| Template | `docs/harness/templates/onboarding-checklist-template.md` | 온보딩 체크리스트 양식 |
| Skill | `.claude/skills/om-team-onboarding-review/SKILL.md` | 팀 온보딩 검토 Skill |
| Script | `docs/harness/scripts/check-step21-team-onboarding.sh` | 21단계 산출물 점검 스크립트 |

## 관련 문서

Team Onboarding은 다음 문서와 함께 사용한다.

```text
CLAUDE.md
AGENTS.md
docs/harness/HOOKOPS_INVENTORY.md
docs/harness/WORKTREE_INVENTORY.md
docs/harness/JIRA_MCP_INVENTORY.md
docs/harness/PILOT_INVENTORY.md
docs/harness/LESSONS_METRICS_INVENTORY.md
docs/harness/hookops/HOOKOPS_POLICY.md
docs/harness/git-worktree/WORKTREE_POLICY.md
docs/harness/mcp/JIRA_MCP_POLICY.md
docs/harness/metrics/HARNESSOPS_METRICS.md
```

## 온보딩 핵심 항목

| 구분 | 핵심 항목 |
|---|---|
| Process | 요청 분석, Search-First, Change Plan |
| Quality | Validation, Quality Gate |
| Governance | 사용자 승인, Change History, Tool Usage Audit |
| Safety | HookOps, Guardrail, 민감 정보 보호 |
| Collaboration | Jira Read-only MCP, Worktree 분리 |
| Adoption | Training Scenario, Checklist, Metrics |

## 점검 기준

21단계 완료 시 다음을 확인한다.

| 항목 | 기준 |
|---|---|
| Team Onboarding Guide | 존재하고 비어 있지 않아야 함 |
| Claude Code Usage Guide | 존재하고 비어 있지 않아야 함 |
| HarnessOps Training Scenario | 존재하고 비어 있지 않아야 함 |
| Onboarding Checklist Template | 존재하고 비어 있지 않아야 함 |
| Team Onboarding Skill | YAML frontmatter와 본문이 있어야 함 |
| Team Onboarding Inventory | 존재하고 비어 있지 않아야 함 |
| 점검 스크립트 | 실행 가능해야 함 |
| 실제 소스코드 변경 | 없어야 함 |

## 운영 기준

Team Onboarding은 다음 기준으로 운영한다.

| 시점 | 내용 |
|---|---|
| 신규 팀원 합류 시 | 온보딩 체크리스트 수행 |
| Claude Code 사용 전 | Usage Guide 확인 |
| Jira MCP 사용 전 | Read-only 기준 확인 |
| Pilot 수행 전 | Training Scenario 실습 |
| 월 1회 | Metrics와 Lessons 반영 |
| 분기 1회 | 온보딩 자료 최신화 |

## 완료 기준

신규 팀원 온보딩 완료 기준은 다음과 같다.

| 항목 | 기준 |
|---|---|
| HarnessOps 흐름 | 설명 가능 |
| Search-First | 수행 가능 |
| Change Plan | 작성 가능 |
| 승인 기준 | 설명 가능 |
| Quality Gate | 이해 및 수행 가능 |
| Audit | Change History와 Tool Usage Audit 이해 |
| MCP | Read-only 기준 설명 가능 |
| Guardrail | 위험 작업 차단 기준 설명 가능 |

## 변경 승인 기준

다음 변경은 사용자 승인이 필요하다.

- 온보딩 핵심 절차 변경
- Claude Code 금지 기준 완화
- Jira MCP Write 작업 허용
- HookOps 차단 기준 완화
- Worktree 분리 기준 완화
- Quality Gate 제외
- Audit 기준 제외

## 금지 사항

다음 작업은 금지한다.

- 온보딩 없이 Claude Code로 실작업 수행
- Search-First 없이 구현 진행
- Change Plan 없이 운영 영향 변경
- 사용자 승인 없는 Git Push
- Jira MCP Write 작업을 기본 교육에 포함
- 민감 정보 예시를 교육 자료에 기록
- Metrics 없이 HarnessOps 효과 주장