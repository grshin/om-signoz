# OpenManager Quality Gate Workflow

## 문서 목적

본 문서는 OpenManager 고도화 작업에서 Commit 또는 Push 전에 반드시 확인해야 하는 Quality Gate 절차를 정의한다.

Quality Gate는 다음 원칙을 따른다.

- Commit 전에는 변경 범위와 민감 파일을 확인한다.
- Push 전에는 Stage 파일과 최근 Commit을 확인한다.
- FAIL이 있으면 Commit하지 않는다.
- WARN은 사유를 확인하고 진행 여부를 판단한다.
- 사용자가 승인하지 않은 Git 작업은 수행하지 않는다.

## 적용 시점

Quality Gate는 다음 시점에 적용한다.

| 시점 | 적용 여부 |
|---|---:|
| 구현 완료 후 | 적용 |
| 단계 전용 점검 스크립트 실행 후 | 적용 |
| Git Stage 전 | 적용 |
| Git Commit 전 | 적용 |
| Git Push 전 | 적용 |
| 단순 설명 요청 | 미적용 |

## Quality Gate 기본 순서

| 순서 | 작업 | 목적 |
|---:|---|---|
| 1 | 작업 트리 확인 | 변경 파일 전체 확인 |
| 2 | 민감 파일 확인 | Secret, 개인 설정 파일 포함 방지 |
| 3 | 단계 전용 점검 결과 확인 | FAIL 여부 확인 |
| 4 | 변경 범위 확인 | 요청 범위 외 변경 방지 |
| 5 | 기존 SigNoz Agent 보존 확인 | Playwright Agent 미수정 확인 |
| 6 | Stage 파일 확인 | Commit 대상 파일 확인 |
| 7 | Commit 메시지 확인 | 단계와 변경 내용 반영 |
| 8 | Push 전 상태 확인 | 브랜치와 원격 상태 확인 |

## Gate 1. 변경 범위 확인

아래 명령으로 변경 파일을 확인한다.

```text
git status --short
git diff --name-only
git diff --stat
```

확인 기준은 다음과 같다.

| 항목 | 통과 기준 |
|---|---|
| 변경 파일 | 현재 단계 산출물 중심 |
| 불필요 파일 | 포함되지 않음 |
| 개인 설정 | 포함되지 않음 |
| 임시 파일 | 포함되지 않음 |
| 기존 Agent | 의도 없이 수정되지 않음 |

## Gate 2. 민감 파일 확인

아래 패턴은 Git 변경 대상에 포함되면 안 된다.

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

확인 명령은 다음과 같다.

```text
git status --short | grep -E 'settings.local.json|\.env|\.pem|\.key|\.p12|\.pfx|id_rsa|id_ed25519|\.kube|\.aws|\.ssh|claude.json' || true
```

Stage 후에는 아래 명령도 수행한다.

```text
git diff --cached --name-only | grep -E 'settings.local.json|\.env|\.pem|\.key|\.p12|\.pfx|id_rsa|id_ed25519|\.kube|\.aws|\.ssh|claude.json' || true
```

출력이 없어야 통과다.

## Gate 3. 단계 전용 점검 스크립트 확인

각 단계에서는 해당 단계 전용 점검 스크립트만 실행한다.

| 단계 | 점검 스크립트 |
|---|---|
| 10단계 | `docs/harness/scripts/check-step10-spec-templates.sh` |
| 11단계 | `docs/harness/scripts/check-step11-search-first-workflow.sh` |
| 12단계 | `docs/harness/scripts/check-step12-quality-gates.sh` |

통합 점검 스크립트는 작성하지 않는다.

점검 결과 기준은 다음과 같다.

| 결과 | 처리 기준 |
|---|---|
| PASS | 진행 가능 |
| WARN | 사유 확인 후 진행 판단 |
| FAIL | Commit 전 수정 필요 |

## Gate 4. 기존 SigNoz Playwright Agent 보존 확인

아래 파일은 의도 없이 수정되어서는 안 된다.

```text
.claude/agents/playwright-test-planner.md
.claude/agents/playwright-test-generator.md
.claude/agents/playwright-test-healer.md
```

확인 명령은 다음과 같다.

```text
git diff --name-only -- .claude/agents/playwright-test-planner.md .claude/agents/playwright-test-generator.md .claude/agents/playwright-test-healer.md
```

출력이 없어야 통과다.

## Gate 5. Stage 파일 확인

Stage 후 아래 명령으로 Commit 대상 파일을 확인한다.

```text
git diff --cached --name-only
```

확인 기준은 다음과 같다.

| 항목 | 통과 기준 |
|---|---|
| Stage 파일 | 현재 단계 산출물만 포함 |
| 민감 파일 | 포함되지 않음 |
| 개인 설정 파일 | 포함되지 않음 |
| 불필요 파일 | 포함되지 않음 |

## Gate 6. Commit 메시지 확인

Commit 메시지는 다음 내용을 포함한다.

| 항목 | 기준 |
|---|---|
| 단계 번호 | 예: `12단계` |
| 변경 목적 | 예: Quality Gate Workflow 구성 |
| 주요 산출물 | Workflow, Template, Skill, Inventory, Script |
| 보존 사항 | 기존 Playwright Agent 미수정 |
| 보안 사항 | 인증 정보와 개인 설정 미포함 |

한글 Commit 메시지를 기본으로 사용한다.

예시는 다음과 같다.

```text
chore(harness): 12단계 Quality Gate Workflow 구성
```

## Gate 7. Push 전 확인

Push 전 아래 명령으로 브랜치 상태를 확인한다.

```text
git status -sb
```

최근 Commit을 확인한다.

```text
git log --oneline --decorate -5
```

Push 대상 브랜치는 다음을 기준으로 한다.

```text
feature/om-harness-bootstrap
```

## Quality Gate 출력 형식

Claude Code는 Quality Gate 결과를 아래 형식으로 정리한다.

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

## 실패 시 처리 기준

| 실패 항목 | 조치 |
|---|---|
| 민감 파일 포함 | 즉시 Stage 해제 또는 Git 추적 제외 |
| Secret 문자열 포함 | 원문 제거 후 재점검 |
| 단계 점검 FAIL | 원인 수정 후 재실행 |
| 기존 Agent 변경 감지 | 의도 여부 확인, 불필요하면 원복 |
| Stage 파일 범위 초과 | Stage 해제 후 현재 단계 파일만 다시 Stage |
| Commit 메시지 부적절 | 메시지 수정 |
| Push 브랜치 불일치 | 브랜치 확인 후 중단 |

## 금지 사항

- FAIL 상태에서 Commit하지 않는다.
- 민감 파일이 포함된 상태에서 Commit하지 않는다.
- 사용자 승인 없이 Push하지 않는다.
- 통합 점검 스크립트를 만들지 않는다.
- 현재 단계와 무관한 전체 상태 점검을 강제하지 않는다.
- 기존 SigNoz Playwright Agent를 임의 수정하지 않는다.