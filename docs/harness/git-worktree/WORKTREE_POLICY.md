# OpenManager Git Worktree Policy

## 문서 목적

본 문서는 OpenManager HarnessOps v2 환경에서 Git Worktree를 사용하는 기준을 정의한다.

Git Worktree는 동일한 Git 저장소를 여러 작업 디렉터리로 분리하여, 하네스 변경, 기능 개발, 검증 작업이 서로 섞이지 않도록 관리하기 위한 방식이다.

Git Worktree는 작업 격리를 통해 하네스 변경, 기능 개발, 검증 작업이 서로 다른 경로와 브랜치에서 수행되도록 관리한다.

## 기본 원칙

OpenManager Git Worktree 운영은 다음 원칙을 따른다.

1. 하나의 작업 목적에는 하나의 Worktree를 사용한다.
2. 하나의 Worktree에는 하나의 전용 브랜치를 연결한다.
3. 하네스 변경과 기능 개발을 같은 Worktree에서 동시에 수행하지 않는다.
4. 운영 검증과 문서 변경을 같은 브랜치에 섞지 않는다.
5. Worktree 디렉터리는 기본 저장소 내부에 만들지 않는다.
6. Worktree 삭제는 `rm -rf`가 아니라 `git worktree remove`를 사용한다.
7. Commit 전에는 현재 Worktree와 브랜치를 반드시 확인한다.
8. Push 전에는 Quality Gate와 Change History를 확인한다.

## 기준 저장소

기본 저장소 경로는 다음과 같다.

```text
/home/grshin/project/next-om/om-signoz
```

Worktree 상위 경로는 다음을 권장한다.

```text
/home/grshin/project/next-om/worktrees
```

다음 경로는 사용하지 않는다.

```text
/home/grshin/project/next-om/om-signoz/worktrees
```

저장소 내부에 Worktree를 만들면 Git 추적 대상과 작업 디렉터리가 섞일 수 있으므로 금지한다.

## Worktree 유형

| Worktree 이름 | 용도 | 권장 브랜치 |
|---|---|---|
| `om-harnessops-v2` | HarnessOps v2 문서, 정책, Skill, Workflow 변경 | `feature/om-harnessops-v2` |
| `om-pilot` | OpenManager Pilot 기능 적용 | `feature/om-openmanager-pilot` |
| `om-verify` | 검증, Quality Gate, 재현 테스트 | `verify/om-harnessops` |
| `om-docs` | 문서 전용 수정 | `docs/om-harnessops-*` |
| `om-fix` | 오류 수정 | `fix/om-*` |

## 브랜치 명명 규칙

브랜치는 다음 기준을 따른다.

| Prefix | 용도 |
|---|---|
| `feature/` | 기능 개발 또는 하네스 기능 추가 |
| `fix/` | 오류 수정 |
| `docs/` | 문서 수정 |
| `verify/` | 검증 전용 작업 |
| `chore/` | 설정, 정리, 관리 작업 |

`main` 브랜치에서는 직접 개발하지 않는다.  
`om-main` 브랜치는 OpenManager 통합 기준 브랜치로 유지한다.

## 작업 격리 기준

Worktree는 작업 격리를 위한 운영 단위로 사용한다.

작업 격리 기준은 다음과 같다.

| 작업 유형 | 격리 기준 |
|---|---|
| 하네스 정책 변경 | 기능 개발 Worktree와 분리 |
| Rule / Skill / Agent 변경 | Pilot 기능 개발과 분리 |
| OpenManager 기능 개발 | 하네스 문서 변경과 분리 |
| 검증 작업 | 구현 작업과 분리 |
| 문서 수정 | 운영 명령 수행 작업과 분리 |
| 오류 수정 | 기능 추가 작업과 분리 |

작업 격리를 적용하면 다음 효과를 얻을 수 있다.

- 잘못된 브랜치에서 Commit하는 실수를 줄인다.
- 하네스 변경과 기능 변경이 하나의 Commit에 섞이는 것을 방지한다.
- 검증 중 발생한 임시 변경이 개발 브랜치에 섞이는 것을 방지한다.
- Pilot 적용 결과와 운영 정책 변경 이력을 분리할 수 있다.
- Worktree별 Quality Gate와 Change History를 독립적으로 관리할 수 있다.

## 작업 분리 기준

다음 작업은 서로 다른 Worktree에서 수행한다.

| 작업 A | 작업 B | 분리 이유 |
|---|---|---|
| 하네스 정책 변경 | OpenManager 기능 개발 | 변경 목적과 검증 기준이 다름 |
| Pilot 기능 개발 | Quality Gate 재검증 | 검증 중 수정 혼입 방지 |
| 문서 수정 | 배포 설정 변경 | 운영 영향 범위 분리 |
| Hook 정책 변경 | Hook 스크립트 수정 | 정책 변경과 실행 로직 변경 분리 |
| Jira Issue 분석 | 실제 구현 | 분석 결과 승인 전 구현 방지 |

## Commit 전 확인 기준

Commit 전에는 다음 명령으로 현재 위치를 확인한다.

```bash
pwd
git branch --show-current
git status --short
git worktree list
```

다음 항목을 확인한다.

| 항목 | 기준 |
|---|---|
| 현재 경로 | 의도한 Worktree 경로인지 확인 |
| 현재 브랜치 | 작업 목적에 맞는 브랜치인지 확인 |
| 변경 파일 | 해당 작업 범위에 속하는지 확인 |
| 미추적 파일 | 불필요한 파일이 포함되지 않았는지 확인 |
| 민감 파일 | `.env`, credential, local setting 포함 여부 확인 |

## Push 전 확인 기준

Push 전에는 다음 항목을 확인한다.

| 항목 | 기준 |
|---|---|
| Quality Gate | 해당 작업 범위의 품질 기준을 통과해야 함 |
| Change History | 변경 이력이 기록되어야 함 |
| Tool Usage Audit | 위험 명령 또는 승인 명령 사용 여부 확인 |
| Worktree 경로 | 저장소 내부 Worktree가 아니어야 함 |
| Push 대상 | 의도한 원격 브랜치인지 확인 |

Push 전 확인 명령은 다음과 같다.

```bash
pwd
git branch --show-current
git status --short
git log --oneline -5
git remote -v
```

## Worktree 삭제 기준

Worktree 삭제는 다음 경우에만 수행한다.

| 상황 | 삭제 가능 여부 |
|---|---:|
| 작업 완료 후 Push 완료 | 가능 |
| 변경사항이 모두 Commit됨 | 가능 |
| 변경사항을 폐기하기로 승인됨 | 가능 |
| 미확인 변경사항 존재 | 불가 |
| 다른 사용자가 참조 중 | 불가 |

Worktree 삭제는 다음 명령을 사용한다.

```bash
git worktree remove /home/grshin/project/next-om/worktrees/<worktree-name>
git worktree prune
```

`rm -rf`로 Worktree를 삭제하지 않는다.

## Worktree 생성 예시

HarnessOps v2 작업용 Worktree 생성 예시는 다음과 같다.

```bash
cd /home/grshin/project/next-om/om-signoz
mkdir -p /home/grshin/project/next-om/worktrees
git worktree add -b feature/om-harnessops-v2 /home/grshin/project/next-om/worktrees/om-harnessops-v2 HEAD
```

Pilot 기능 개발용 Worktree 생성 예시는 다음과 같다.

```bash
cd /home/grshin/project/next-om/om-signoz
mkdir -p /home/grshin/project/next-om/worktrees
git worktree add -b feature/om-openmanager-pilot /home/grshin/project/next-om/worktrees/om-pilot HEAD
```

검증 전용 Worktree 생성 예시는 다음과 같다.

```bash
cd /home/grshin/project/next-om/om-signoz
mkdir -p /home/grshin/project/next-om/worktrees
git worktree add -b verify/om-harnessops /home/grshin/project/next-om/worktrees/om-verify HEAD
```

## Worktree 목록 확인

Worktree 목록은 다음 명령으로 확인한다.

```bash
git worktree list
```

상세 정보는 다음 명령으로 확인한다.

```bash
git worktree list --porcelain
```

## Worktree 작업 전 확인

Worktree에서 작업을 시작하기 전에는 다음 명령을 실행한다.

```bash
pwd
git branch --show-current
git status --short
git worktree list
```

확인 기준은 다음과 같다.

| 확인 항목 | 정상 기준 |
|---|---|
| 현재 경로 | `/home/grshin/project/next-om/worktrees/<worktree-name>` |
| 현재 브랜치 | 작업 목적에 맞는 브랜치 |
| Git 상태 | 의도하지 않은 변경 없음 |
| Worktree 목록 | 동일 브랜치 중복 사용 없음 |

## 잘못된 Worktree 사용 시 처리

잘못된 Worktree에서 작업한 경우 다음 순서로 처리한다.

1. 현재 경로와 브랜치를 확인한다.
2. 변경 파일 목록을 확인한다.
3. 변경사항을 보존할지 폐기할지 결정한다.
4. 필요한 경우 Patch 또는 Stash 방식으로 올바른 Worktree로 이동한다.
5. 사용자 승인 없이 변경사항을 삭제하지 않는다.
6. 정리 후 Worktree Inventory 또는 Change History에 기록한다.

확인 명령은 다음과 같다.

```bash
pwd
git branch --show-current
git status --short
git diff --name-only
```

## 민감 파일 보호 기준

Worktree에서도 다음 파일과 디렉터리는 Git에 추가하지 않는다.

```text
.env
.env.*
**/.env
**/.env.*
.claude/settings.local.json
~/.ssh/**
~/.aws/**
~/.kube/**
```

민감 파일이 변경사항에 포함되었는지 확인한다.

```bash
git status --short
git diff --name-only | grep -E '(^|/)\.env|settings\.local\.json|\.ssh|\.aws|\.kube' || true
```

출력이 있으면 Commit을 중단하고 원인을 확인한다.

## 관련 문서

Worktree 운영은 다음 문서와 함께 사용한다.

```text
CLAUDE.md
AGENTS.md
docs/harness/WORKTREE_INVENTORY.md
docs/harness/HOOKOPS_INVENTORY.md
docs/harness/QUALITY_GATES_INVENTORY.md
docs/harness/AUDIT_TRAIL_INVENTORY.md
docs/harness/operations/harness-operation-policy.md
docs/harness/operations/harness-maintenance-runbook.md
docs/harness/templates/worktree-task-template.md
```

## 금지 사항

다음 작업은 금지한다.

- 저장소 내부에 Worktree 생성
- `main` 브랜치에서 직접 개발
- `om-main` 브랜치에서 직접 실험 작업
- 동일 브랜치를 여러 Worktree에 중복 연결
- Worktree 삭제 시 `rm -rf` 사용
- 현재 Worktree 확인 없이 Commit
- Worktree 작업 중 민감 파일 Git 추가
- Worktree별 목적과 다른 파일을 함께 Commit
- 하네스 변경과 기능 개발을 같은 Worktree에서 동시에 수행
- 검증 전용 Worktree에서 운영 배포 명령 수행