# OpenManager Quality Gate 결과 템플릿

## 1. Quality Gate 개요

| 항목 | 내용 |
|---|---|
| 대상 단계 |  |
| 점검 일자 |  |
| 점검자 |  |
| 대상 브랜치 | `feature/om-harness-bootstrap` |
| Commit 전 점검 여부 | 예 / 아니오 |
| Push 전 점검 여부 | 예 / 아니오 |

## 2. 변경 범위 확인

| 확인 항목 | 명령 또는 방법 | 결과 | 비고 |
|---|---|---|---|
| 작업 트리 확인 | `git status --short` |  |  |
| 변경 파일 확인 | `git diff --name-only` |  |  |
| 변경 통계 확인 | `git diff --stat` |  |  |
| 현재 단계 산출물 여부 | 수동 확인 |  |  |
| 불필요 파일 포함 여부 | 수동 확인 |  |  |

## 3. 민감 파일 확인

아래 패턴이 Git 변경 또는 Stage 대상에 포함되면 안 된다.

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

| 확인 항목 | 명령 또는 방법 | 결과 | 비고 |
|---|---|---|---|
| 작업 트리 민감 파일 확인 | `git status --short | grep -E 'settings.local.json|\.env|\.pem|\.key|\.p12|\.pfx|id_rsa|id_ed25519|\.kube|\.aws|\.ssh|claude.json' || true` |  |  |
| Stage 민감 파일 확인 | `git diff --cached --name-only | grep -E 'settings.local.json|\.env|\.pem|\.key|\.p12|\.pfx|id_rsa|id_ed25519|\.kube|\.aws|\.ssh|claude.json' || true` |  |  |
| Secret 유사 문자열 확인 | 단계 점검 스크립트 또는 수동 확인 |  |  |
| 인증 정보 포함 여부 | 수동 확인 |  |  |

## 4. 단계 전용 점검 스크립트 결과

| 항목 | 내용 |
|---|---|
| 실행 스크립트 |  |
| 실행 결과 | PASS / WARN / FAIL |
| PASS 수 |  |
| WARN 수 |  |
| FAIL 수 |  |
| 조치 필요 사항 |  |

점검 결과 원문을 아래에 기록한다.

```text
Summary: PASS=... WARN=... FAIL=...
```

## 5. 기존 SigNoz Playwright Agent 보존 확인

아래 파일은 의도 없이 수정되어서는 안 된다.

```text
.claude/agents/playwright-test-planner.md
.claude/agents/playwright-test-generator.md
.claude/agents/playwright-test-healer.md
```

| 확인 항목 | 명령 또는 방법 | 결과 | 비고 |
|---|---|---|---|
| 기존 Agent 변경 여부 | `git diff --name-only -- .claude/agents/playwright-test-planner.md .claude/agents/playwright-test-generator.md .claude/agents/playwright-test-healer.md` |  |  |
| 변경 의도 여부 | 수동 확인 |  |  |

## 6. Stage 파일 확인

| 확인 항목 | 명령 또는 방법 | 결과 | 비고 |
|---|---|---|---|
| Stage 파일 목록 | `git diff --cached --name-only` |  |  |
| Stage 변경 통계 | `git diff --cached --stat` |  |  |
| 현재 단계 파일만 포함 | 수동 확인 |  |  |
| 민감 파일 미포함 | 수동 확인 |  |  |
| 불필요 파일 미포함 | 수동 확인 |  |  |

Stage 대상 파일을 아래에 기록한다.

```text
-
-
-
```

## 7. Commit 메시지 확인

| 항목 | 확인 내용 |
|---|---|
| 단계 번호 포함 | 예 / 아니오 |
| 변경 목적 포함 | 예 / 아니오 |
| 주요 산출물 포함 | 예 / 아니오 |
| 보존 사항 포함 | 예 / 아니오 |
| 보안 사항 포함 | 예 / 아니오 |

권장 Commit 메시지를 작성한다.

```text
chore(harness): 12단계 Quality Gate Workflow 구성
```

상세 메시지를 작성한다.

```text
12단계: 구현 검증 및 Quality Gate Workflow 구성

추가:
- 구현 후 검증 절차를 정의하는 Implementation Validation Workflow
- Commit / Push 전 품질 기준을 정의하는 Quality Gate Workflow
- 구현 검증 결과 템플릿
- Quality Gate 결과 템플릿
- om-implementation-validation Skill
- om-quality-gate Skill
- Quality Gates Inventory
- 12단계 전용 점검 스크립트

보존:
- 기존 SigNoz Playwright Agent는 수정하지 않음
- 인증 정보와 개인 로컬 설정 파일은 Git 추적 대상에 포함하지 않음
```

## 8. Push 전 확인

| 확인 항목 | 명령 또는 방법 | 결과 | 비고 |
|---|---|---|---|
| 브랜치 상태 확인 | `git status -sb` |  |  |
| 최근 Commit 확인 | `git log --oneline --decorate -5` |  |  |
| Push 대상 브랜치 확인 | `feature/om-harness-bootstrap` |  |  |
| 원격 저장소 확인 | `git remote -v` |  |  |

## 9. Quality Gate 최종 판단

| 항목 | 판단 |
|---|---|
| Commit 가능 여부 | 가능 / 불가 |
| Push 가능 여부 | 가능 / 불가 |
| 추가 수정 필요 여부 | 필요 / 불필요 |
| 사용자 승인 필요 여부 | 필요 / 불필요 |

## 10. 최종 결과 요약

```text
Quality Gate 최종 결과를 작성한다.
FAIL이 있으면 Commit하지 않는다.
민감 파일이 포함되어 있으면 Commit하지 않는다.
사용자 승인 없이 Push하지 않는다.
```