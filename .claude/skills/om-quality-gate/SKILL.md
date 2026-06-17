---
name: OpenManager Quality Gate
description: OpenManager 변경사항을 Commit 또는 Push하기 전에 변경 범위, 민감 파일, 단계 점검 결과, Stage 파일, Commit 메시지를 확인할 때 사용한다.
when_to_use: Commit 전, Push 전, 단계 완료 전, 변경사항의 품질 게이트 통과 여부를 판단해야 할 때 사용한다.
disable-model-invocation: true
allowed-tools: Read Grep Glob Bash
---

# OpenManager Quality Gate Skill

## 목적

OpenManager 변경사항을 Git Commit 또는 Push하기 전에 품질 게이트 통과 여부를 판단한다.

이 Skill은 변경사항을 직접 수정하지 않고, Commit / Push 가능 여부를 판단하기 위한 검토 결과를 정리한다.

## 사용 방식

사용자가 다음과 같이 직접 호출한다.

```text
/om-quality-gate 12단계 변경사항의 Commit 가능 여부를 확인해 주세요.
```

```text
/om-quality-gate 현재 Stage 파일 기준으로 민감 파일 포함 여부를 확인해 주세요.
```

```text
/om-quality-gate Push 전에 브랜치 상태와 최근 Commit을 확인해 주세요.
```

## 참조 Workflow 및 Template

| 구분 | 경로 |
|---|---|
| Quality Gate Workflow | `docs/harness/workflows/quality-gate-workflow.md` |
| Quality Gate Result Template | `docs/harness/templates/quality-gate-result-template.md` |
| Implementation Validation Workflow | `docs/harness/workflows/implementation-validation-workflow.md` |
| Implementation Validation Template | `docs/harness/templates/implementation-validation-template.md` |

## 수행 절차

1. 작업 트리 변경 파일을 확인한다.
2. 변경 범위가 현재 단계와 일치하는지 확인한다.
3. 민감 파일 포함 여부를 확인한다.
4. 단계 전용 점검 스크립트 결과를 확인한다.
5. 기존 SigNoz Playwright Agent 보존 여부를 확인한다.
6. Stage 파일 목록을 확인한다.
7. Commit 메시지가 단계와 변경 내용을 반영하는지 확인한다.
8. Push 전 브랜치 상태를 확인한다.
9. Commit 가능 여부와 Push 가능 여부를 판단한다.

## Quality Gate 항목

| Gate | 확인 내용 |
|---|---|
| Gate 1 | 변경 범위 확인 |
| Gate 2 | 민감 파일 포함 여부 확인 |
| Gate 3 | 단계 전용 점검 스크립트 결과 확인 |
| Gate 4 | 기존 SigNoz Playwright Agent 보존 확인 |
| Gate 5 | Stage 파일 확인 |
| Gate 6 | Commit 메시지 확인 |
| Gate 7 | Push 전 브랜치 상태 확인 |

## 민감 파일 기준

아래 파일 또는 경로가 Git 변경 대상에 포함되면 안 된다.

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

## 권장 확인 명령

작업 트리 확인:

```text
git status --short
git diff --name-only
git diff --stat
```

민감 파일 확인:

```text
git status --short | grep -E 'settings.local.json|\.env|\.pem|\.key|\.p12|\.pfx|id_rsa|id_ed25519|\.kube|\.aws|\.ssh|claude.json' || true
```

Stage 파일 확인:

```text
git diff --cached --name-only
git diff --cached --stat
```

Stage 민감 파일 확인:

```text
git diff --cached --name-only | grep -E 'settings.local.json|\.env|\.pem|\.key|\.p12|\.pfx|id_rsa|id_ed25519|\.kube|\.aws|\.ssh|claude.json' || true
```

기존 Playwright Agent 보존 확인:

```text
git diff --name-only -- .claude/agents/playwright-test-planner.md .claude/agents/playwright-test-generator.md .claude/agents/playwright-test-healer.md
```

Push 전 확인:

```text
git status -sb
git log --oneline --decorate -5
```

## Commit 메시지 기준

Commit 메시지는 한글을 기본으로 사용한다.

기본 형식은 다음과 같다.

```text
chore(harness): 12단계 Quality Gate Workflow 구성
```

상세 메시지에는 다음 내용을 포함한다.

```text
12단계: 구현 검증 및 Quality Gate Workflow 구성
추가: Implementation Validation Workflow
추가: Quality Gate Workflow
추가: 구현 검증 결과 템플릿
추가: Quality Gate 결과 템플릿
추가: om-implementation-validation 및 om-quality-gate Skill
추가: Quality Gates Inventory 및 12단계 전용 점검 스크립트
보존: 기존 SigNoz Playwright Agent는 수정하지 않음
보존: 인증 정보와 개인 로컬 설정 파일은 Git 추적 대상에 포함하지 않음
```

## 출력 형식

```text
OpenManager Quality Gate 결과

1. 변경 범위 확인
- 결과:
- 비고:

2. 민감 파일 확인
- 결과:
- 비고:

3. 단계 전용 점검 스크립트
- 실행 스크립트:
- 결과:

4. 기존 SigNoz Playwright Agent 보존
- 결과:
- 비고:

5. Stage 파일 확인
- 결과:
- 비고:

6. Commit 메시지 확인
- 결과:
- 권장 메시지:

7. Push 전 확인
- 결과:
- 대상 브랜치:

8. 최종 판단
- Commit 가능 여부:
- Push 가능 여부:
- 추가 조치:
```

## 금지 사항

- FAIL 상태에서 Commit을 권장하지 않는다.
- 민감 파일이 포함된 상태에서 Commit을 권장하지 않는다.
- 사용자 승인 없이 Push를 권장하지 않는다.
- 운영 명령을 실행하지 않는다.
- Secret 파일을 읽지 않는다.
- 기존 SigNoz Playwright Agent를 수정하지 않는다.
- 통합 점검 스크립트를 작성하지 않는다.