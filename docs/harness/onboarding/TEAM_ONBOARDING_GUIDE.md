# OpenManager HarnessOps Team Onboarding Guide

## 문서 목적

본 문서는 OpenManager HarnessOps를 팀 공통 방식으로 사용하기 위한 온보딩 가이드이다.

신규 팀원 또는 기존 팀원이 OpenManager HarnessOps 환경에서 작업할 때 반드시 확인해야 할 기본 기준, 작업 절차, 금지 사항, 승인 기준을 정리한다.

## 적용 대상

본 가이드는 다음 대상에게 적용한다.

| 대상 | 적용 내용 |
|---|---|
| 신규 개발자 | HarnessOps 작업 흐름 이해 |
| 기존 개발자 | AI Agent 기반 작업 기준 적용 |
| DevOps 담당자 | HookOps, Worktree, Quality Gate 기준 확인 |
| PM / PL | Jira Issue, Change Plan, 승인 기준 확인 |
| 검토자 | Pilot, Lessons Learned, Metrics 확인 |

## HarnessOps 개요

OpenManager HarnessOps는 AI Agent 기반 개발·검증·감사 운영체계이다.

핵심 흐름은 다음과 같다.

```text
요청 접수
→ Jira Issue 또는 내부 요청 분석
→ Spec 요청 정리
→ Search-First 분석
→ Change Plan 작성
→ 사용자 승인
→ 구현 또는 검증
→ Quality Gate
→ Change History
→ Tool Usage Audit
→ Lessons Learned / Metrics 반영
```

## 신규 팀원이 먼저 알아야 할 기준

신규 팀원은 다음 기준을 먼저 이해해야 한다.

| 기준 | 설명 |
|---|---|
| 바로 구현 금지 | 요청을 받으면 먼저 분석한다. |
| Search-First 필수 | 기존 코드와 문서를 먼저 확인한다. |
| Change Plan 작성 | 변경 전 계획을 작성한다. |
| 사용자 승인 | 위험 작업 또는 실제 구현 전 승인을 확인한다. |
| Quality Gate | 구현 후 검증 기준을 수행한다. |
| Change History | 변경 이력을 기록한다. |
| Tool Usage Audit | 도구 사용 이력을 기록한다. |
| 민감 정보 보호 | Token, Secret, Credential을 기록하지 않는다. |

## 기본 작업 절차

OpenManager HarnessOps의 기본 작업 절차는 다음과 같다.

### 1단계. 요청 확인

요청이 Jira Issue에서 왔는지, 내부 요청인지 확인한다.

확인 항목은 다음과 같다.

| 항목 | 내용 |
|---|---|
| 요청 출처 | Jira Issue / 내부 요청 / 운영 요청 |
| 요청 유형 | Backend / Frontend / OTel / Deploy / Harness / Documentation |
| 운영 영향 | 있음 / 없음 |
| 보안 영향 | 있음 / 없음 |
| 승인 필요 여부 | 필요 / 불필요 |

### 2단계. Read-only 분석

Jira MCP 또는 문서 조회는 Read-only 기준으로 수행한다.

허용 작업은 다음과 같다.

```text
조회
검색
요약
분류
요구사항 분석
```

금지 작업은 다음과 같다.

```text
Issue 생성
Issue 수정
댓글 작성
상태 변경
담당자 변경
Label 변경
첨부파일 업로드
```

### 3단계. Search-First 분석

구현 전에 기존 코드, 문서, Workflow, Template을 먼저 확인한다.

참조 문서는 다음과 같다.

```text
docs/harness/workflows/search-first-analysis-workflow.md
docs/harness/templates/search-first-analysis-template.md
```

### 4단계. Change Plan 작성

변경이 필요한 경우 Change Plan을 먼저 작성한다.

참조 문서는 다음과 같다.

```text
docs/harness/workflows/change-plan-workflow.md
docs/harness/templates/change-plan-template.md
```

### 5단계. 사용자 승인

다음 작업은 사용자 승인 후 진행한다.

| 작업 | 승인 필요 |
|---|---:|
| 실제 소스코드 수정 | 필요 |
| 신규 파일 생성 | 필요 |
| API 변경 | 필요 |
| DB 변경 | 필요 |
| Kubernetes / Helm 변경 | 필요 |
| 운영 명령 실행 | 필요 |
| 외부 시스템 Write 작업 | 필요 |
| 민감 파일 접근 | 필요 또는 차단 |

### 6단계. 구현 및 검증

승인 후 구현한다.

구현 후 다음 항목을 수행한다.

```text
Implementation Validation
Quality Gate
Change History
Tool Usage Audit
```

## 팀 공통 작업 규칙

팀 공통 작업 규칙은 다음과 같다.

| 구분 | 규칙 |
|---|---|
| 언어 | HarnessOps 문서는 한국어 중심으로 작성한다. |
| 코드 | 기존 OpenManager 구조를 우선 따른다. |
| 문서 | Markdown 기준으로 작성한다. |
| Git | 작업 목적별 브랜치와 Worktree를 분리한다. |
| MCP | Read-only 기본 원칙을 따른다. |
| Hook | 위험 명령과 민감 파일 접근을 차단한다. |
| 승인 | 위험 작업은 사용자 승인 후 진행한다. |
| 기록 | 변경 이력과 도구 사용 이력을 남긴다. |

## Worktree 기준

작업 목적이 다르면 Worktree를 분리한다.

권장 Worktree 기준은 다음과 같다.

| Worktree 이름 | 용도 | 권장 브랜치 |
|---|---|---|
| `om-harnessops-v2` | HarnessOps v2 문서, 정책, Skill, Workflow 변경 | `feature/om-harnessops-v2` |
| `om-pilot` | OpenManager Pilot 기능 적용 | `feature/om-openmanager-pilot` |
| `om-verify` | 검증, Quality Gate, 재현 테스트 | `verify/om-harnessops` |
| `om-docs` | 문서 전용 수정 | `docs/om-harnessops-*` |
| `om-fix` | 오류 수정 | `fix/om-*` |

Worktree는 저장소 내부가 아니라 다음 경로를 사용한다.

```text
/home/grshin/project/next-om/worktrees
```

## Claude Code 사용 기준

Claude Code는 다음 기준으로 사용한다.

| 작업 | 기준 |
|---|---|
| 파일 조회 | 허용 |
| 문서 작성 | 허용 |
| 코드 분석 | 허용 |
| Search-First | 권장 |
| Change Plan 작성 | 권장 |
| 코드 수정 | 사용자 승인 후 |
| Git Add / Commit / Push | 사용자 승인 후 |
| 운영 명령 | 사용자 승인 후 |
| 민감 파일 접근 | 금지 |

## 금지 사항

다음 작업은 금지한다.

- 요청을 받자마자 바로 구현
- Search-First 없이 코드 수정
- Change Plan 없이 운영 영향 변경
- 사용자 승인 없는 Git Push
- 사용자 승인 없는 운영 명령 실행
- Jira Issue 상태 변경
- Jira 댓글 자동 작성
- `.env`, Token, Secret, Credential 기록
- `.claude/settings.local.json` Git 추가
- Hook 차단 기준 임의 완화

## 온보딩 완료 기준

신규 팀원은 다음 항목을 완료해야 한다.

| 항목 | 완료 기준 |
|---|---|
| HarnessOps 개념 이해 | 기본 흐름 설명 가능 |
| Claude Code 사용법 이해 | 읽기 전용 분석 요청 가능 |
| Search-First 이해 | 기존 코드 검색 절차 수행 가능 |
| Change Plan 이해 | 변경 계획 작성 가능 |
| Worktree 이해 | 작업 목적별 분리 기준 설명 가능 |
| Jira MCP 이해 | Read-only 기준 설명 가능 |
| Guardrail 이해 | 위험 명령과 민감 파일 기준 설명 가능 |
| Quality Gate 이해 | 검증 절차 설명 가능 |
| Audit 이해 | Change History와 Tool Usage Audit 설명 가능 |

## 관련 문서

신규 팀원은 다음 문서를 함께 확인한다.

```text
CLAUDE.md
AGENTS.md
docs/harness/HOOKOPS_INVENTORY.md
docs/harness/WORKTREE_INVENTORY.md
docs/harness/JIRA_MCP_INVENTORY.md
docs/harness/PILOT_INVENTORY.md
docs/harness/LESSONS_METRICS_INVENTORY.md
docs/harness/TEAM_ONBOARDING_INVENTORY.md
docs/harness/onboarding/CLAUDE_CODE_USAGE_GUIDE.md
docs/harness/onboarding/HARNESSOPS_TRAINING_SCENARIO.md
docs/harness/templates/onboarding-checklist-template.md
```

## 결론

OpenManager HarnessOps 온보딩의 목적은 AI Agent를 단순 코딩 도구로 사용하는 것이 아니라, 분석, 계획, 승인, 검증, 감사가 가능한 팀 공통 운영체계로 사용하는 것이다.

팀원은 본 가이드에 따라 요청을 바로 구현하지 않고, Search-First와 Change Plan을 거쳐 안전하게 작업해야 한다.