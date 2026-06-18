---
name: OpenManager Team Onboarding Review
description: OpenManager HarnessOps에서 팀 온보딩, Claude Code 사용 기준, 교육 시나리오, 체크리스트, 팀 공통 배포 기준을 검토할 때 사용한다.
when_to_use: Team Onboarding, Claude Code Usage, HarnessOps Training, Onboarding Checklist, 팀 공통 운영 기준, 신규 팀원 교육 검토가 필요할 때 사용한다.
allowed-tools: Read Grep Glob Bash
---

# OpenManager Team Onboarding Review Skill

## 목적

OpenManager HarnessOps 환경에서 팀 공통 온보딩 기준과 교육 자료의 적합성을 검토한다.

이 Skill은 신규 팀원이 HarnessOps 작업 흐름을 이해하고, Claude Code를 안전하게 사용할 수 있는지 확인하는 데 사용한다.

## 참조 문서

우선 다음 문서를 확인한다.

```text
docs/harness/onboarding/TEAM_ONBOARDING_GUIDE.md
docs/harness/onboarding/CLAUDE_CODE_USAGE_GUIDE.md
docs/harness/onboarding/HARNESSOPS_TRAINING_SCENARIO.md
docs/harness/templates/onboarding-checklist-template.md
docs/harness/TEAM_ONBOARDING_INVENTORY.md
docs/harness/LESSONS_METRICS_INVENTORY.md
```

## 검토 대상

다음 항목을 검토한다.

| 대상 | 검토 내용 |
|---|---|
| Team Onboarding Guide | 신규 팀원이 따라야 할 기본 기준 |
| Claude Code Usage Guide | Claude Code 사용 원칙과 금지 사항 |
| Training Scenario | 실습 시나리오의 현실성 |
| Onboarding Checklist | 온보딩 완료 여부 확인 가능성 |
| Lessons / Metrics | 20단계 결과와 온보딩 연결 여부 |
| Guardrail | 위험 작업 차단 기준 포함 여부 |
| Jira MCP | Read-only 기준 포함 여부 |
| Worktree | 작업 격리 기준 포함 여부 |

## 수행 절차

요청을 받으면 다음 순서로 진행한다.

1. 온보딩 검토 목적을 확인한다.
2. 관련 온보딩 문서를 확인한다.
3. 신규 팀원이 이해해야 할 핵심 기준이 포함되어 있는지 확인한다.
4. Claude Code 사용 기준이 안전한지 확인한다.
5. Jira MCP Read-only 기준이 포함되어 있는지 확인한다.
6. Worktree, HookOps, Quality Gate 기준이 포함되어 있는지 확인한다.
7. 체크리스트가 실제 평가 가능한 형태인지 확인한다.
8. 보완 필요 사항과 다음 조치를 정리한다.

## 출력 형식

```text
OpenManager Team Onboarding 검토 결과

1. 검토 대상
-

2. 온보딩 구성 요약
- Team Guide:
- Claude Code Guide:
- Training Scenario:
- Checklist:

3. 핵심 기준 포함 여부
- Search-First:
- Change Plan:
- 사용자 승인:
- Quality Gate:
- Change History:
- Tool Usage Audit:

4. 안전 기준 포함 여부
- HookOps:
- Worktree:
- Jira MCP Read-only:
- 민감 정보 보호:

5. 보완 필요 사항
-

6. 온보딩 완료 판단
- 완료 가능 / 보완 필요:

7. 결론
- 팀 공통 적용 가능 여부:
- 사용자 확인 필요 사항:
- 후속 조치:
```

## 금지 사항

- 온보딩 문서를 실제 운영 절차 없이 형식적으로만 완료 처리하지 않는다.
- Claude Code 사용 기준에서 위험 명령을 자동 허용하지 않는다.
- Jira MCP Write 작업을 온보딩 기본 절차에 포함하지 않는다.
- 민감 정보나 인증 정보를 교육 자료에 기록하지 않는다.
- 사용자 승인 없이 운영 정책을 변경하지 않는다.