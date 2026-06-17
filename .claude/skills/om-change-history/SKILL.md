---
name: OpenManager Change History
description: OpenManager 변경 작업 후 사용자 요청, 분석, 계획, 구현, 검증, Quality Gate, Git 이력을 변경 이력으로 정리할 때 사용한다.
when_to_use: OpenManager 변경 작업이 완료되었거나 Commit 전후에 감사 가능한 변경 이력을 남겨야 할 때 사용한다.
disable-model-invocation: true
allowed-tools: Read Grep Glob Bash
---

# OpenManager Change History Skill

## 목적

OpenManager 변경 작업의 시작부터 완료까지의 흐름을 감사 가능한 변경 이력으로 정리한다.

이 Skill은 구현을 수행하지 않고, 변경 작업의 근거와 결과를 기록하는 데 사용한다.

## 사용 방식

사용자가 다음과 같이 직접 호출한다.

```text
/om-change-history 13단계 변경 작업의 변경 이력을 정리해 주세요.
```

```text
/om-change-history 방금 완료한 작업의 요청, 변경 파일, 검증 결과, Commit 메시지를 정리해 주세요.
```

```text
/om-change-history Search-First, Change Plan, Quality Gate 결과를 포함해서 변경 이력을 작성해 주세요.
```

## 참조 Workflow 및 Template

| 구분 | 경로 |
|---|---|
| Change History Workflow | `docs/harness/workflows/change-history-workflow.md` |
| Change History Template | `docs/harness/templates/change-history-template.md` |
| Tool Usage Audit Workflow | `docs/harness/workflows/tool-usage-audit-workflow.md` |
| Tool Usage Audit Template | `docs/harness/templates/tool-usage-audit-template.md` |

## 수행 절차

1. 사용자 요청을 한 문장으로 요약한다.
2. 작업 유형을 분류한다.
3. 관련 사전 절차 수행 여부를 확인한다.
4. 변경 대상 파일을 생성, 수정, 삭제, 제외로 구분한다.
5. 적용 Rule, Skill, Agent를 정리한다.
6. 구현 및 변경 내용을 요약한다.
7. 구현 검증 결과를 정리한다.
8. Quality Gate 결과를 정리한다.
9. 보안 확인 결과를 정리한다.
10. 기존 SigNoz 구조 보존 여부를 확인한다.
11. Tool 사용 로그 위치와 감사 결과를 연결한다.
12. Git Stage, Commit, Push 이력을 정리한다.
13. 사용자 승인 및 보류 사항을 기록한다.

## 변경 이력 기록 대상

| 항목 | 기록 내용 |
|---|---|
| 요청 요약 | 사용자의 원 요청을 한 문장으로 정리 |
| 작업 유형 | Backend, Frontend, OTel, Deploy, Harness, Docs |
| 사전 절차 | Spec, Search-First, Change Plan 여부 |
| 변경 파일 | 생성, 수정, 삭제, 제외 파일 |
| 검증 결과 | Implementation Validation 결과 |
| 품질 결과 | Quality Gate 결과 |
| 감사 결과 | Tool Usage Audit 결과 |
| Git 이력 | Stage, Commit, Push 여부 |
| 보안 확인 | 민감 파일, Secret, 개인 설정 포함 여부 |
| 보존 확인 | 기존 SigNoz Playwright Agent, upstream 영향 |
| 승인 사항 | 승인 완료, 승인 필요, 보류 항목 |

## 관련 Skill

| Skill | 목적 |
|---|---|
| `om-spec-request` | Spec 기반 요청 정리 |
| `om-search-first-analysis` | 기존 구현 검색과 영향 분석 |
| `om-change-plan` | 구현 전 변경 계획 수립 |
| `om-implementation-validation` | 구현 후 검증 결과 정리 |
| `om-quality-gate` | Commit / Push 전 품질 게이트 확인 |
| `om-tool-audit` | Tool 사용 로그 감사 |
| `om-change-history` | 변경 이력 최종 정리 |

## 관련 Agent

| Agent | 목적 |
|---|---|
| `om-architecture-reviewer` | 구조와 upstream 경계 검토 |
| `om-backend-go-reviewer` | Backend Go 검토 |
| `om-frontend-react-reviewer` | Frontend React 검토 |
| `om-otel-pipeline-reviewer` | OTel Pipeline 검토 |
| `om-deploy-kubernetes-reviewer` | Deploy Kubernetes 검토 |
| `om-security-quality-reviewer` | 보안과 품질 검토 |

## 확인 명령

필요한 경우 아래 명령을 사용한다.

```text
git status --short
git diff --name-only
git diff --stat
git diff --cached --name-only
git log --oneline --decorate -5
```

기존 SigNoz Playwright Agent 보존 여부를 확인한다.

```text
git diff --name-only -- .claude/agents/playwright-test-planner.md .claude/agents/playwright-test-generator.md .claude/agents/playwright-test-healer.md
```

민감 파일 포함 여부를 확인한다.

```text
git status --short | grep -E 'settings.local.json|\.env|\.pem|\.key|\.p12|\.pfx|id_rsa|id_ed25519|\.kube|\.aws|\.ssh|claude.json' || true
```

Stage 이후 민감 파일 포함 여부를 확인한다.

```text
git diff --cached --name-only | grep -E 'settings.local.json|\.env|\.pem|\.key|\.p12|\.pfx|id_rsa|id_ed25519|\.kube|\.aws|\.ssh|claude.json' || true
```

Tool 사용 로그 존재 여부를 확인한다.

```text
ls -l .claude/logs/tool-usage.log
```

## 출력 형식

```text
OpenManager Change History

1. 요청 요약
-

2. 작업 유형
- Backend:
- Frontend:
- OTel:
- Deploy:
- Harness:
- Docs:

3. 관련 사전 절차
- Spec 기반 요청:
- Search-First 분석:
- Change Plan:

4. 변경 파일
- 생성:
- 수정:
- 삭제:
- 제외:

5. 검증 결과
- Implementation Validation:
- Quality Gate:
- 단계 전용 점검 스크립트:

6. 보안 확인
- 민감 파일 포함 여부:
- Secret 유사 문자열:
- 개인 설정 파일 포함 여부:

7. 기존 구조 보존
- SigNoz Playwright Agent:
- upstream 영향:

8. Tool 사용 로그
- 로그 위치:
- 확인 결과:
- 특이 사항:

9. Git 이력
- Commit 여부:
- Commit 메시지:
- Push 여부:
- 대상 브랜치:

10. 사용자 승인 및 보류 항목
- 승인 완료:
- 승인 필요:
- 보류:
```

## 금지 사항

- Secret 원문을 변경 이력에 기록하지 않는다.
- 인증 토큰, password, api key를 기록하지 않는다.
- 개인 로컬 설정 내용을 기록하지 않는다.
- `.claude/settings.local.json`을 Git 추적 대상으로 만들지 않는다.
- 기존 SigNoz Playwright Agent를 수정하지 않는다.
- 통합 점검 스크립트를 작성하지 않는다.