# OpenManager Git Worktree RunBook

## 문서 목적

본 문서는 OpenManager HarnessOps v2 작업에서 Git Worktree를 생성, 사용, 점검, 정리하는 절차를 정의한다.

## 사전 조건

Worktree를 생성하기 전에 다음 상태를 확인한다.

```bash
cd /home/grshin/project/next-om/om-signoz
git status --short
git branch --show-current
git worktree list
```

기준 저장소의 변경사항이 남아 있다면 먼저 Commit 또는 정리한다.

## Worktree 상위 디렉터리 생성

Worktree는 저장소 내부가 아니라 상위 경로에 생성한다.

```bash
mkdir -p /home/grshin/project/next-om/worktrees
```

생성 결과를 확인한다.

```bash
ls -al /home/grshin/project/next-om
```

## HarnessOps v2 Worktree 생성

HarnessOps v2 문서, 정책, Skill, Workflow 작업용 Worktree를 생성한다.

```bash
cd /home/grshin/project/next-om/om-signoz
git worktree add -b feature/om-harnessops-v2 /home/grshin/project/next-om/worktrees/om-harnessops-v2 HEAD
```

이미 브랜치가 존재하는 경우에는 다음 명령을 사용한다.

```bash
git worktree add /home/grshin/project/next-om/worktrees/om-harnessops-v2 feature/om-harnessops-v2
```

생성 결과를 확인한다.

```bash
git worktree list
```

## Worktree로 이동

생성한 Worktree로 이동한다.

```bash
cd /home/grshin/project/next-om/worktrees/om-harnessops-v2
```

현재 경로를 확인한다.

```bash
pwd
```

현재 브랜치를 확인한다.

```bash
git branch --show-current
```

예상 결과는 다음과 같다.

```text
feature/om-harnessops-v2
```

Git 상태를 확인한다.

```bash
git status --short
```

## VS Code로 Worktree 열기

Worktree 경로에서 VS Code를 실행한다.

```bash
code .
```

VS Code 왼쪽 아래가 WSL: Ubuntu 상태인지 확인한다.

## Pilot Worktree 생성

OpenManager Pilot 기능 적용용 Worktree는 다음처럼 생성한다.

```bash
cd /home/grshin/project/next-om/om-signoz
git worktree add -b feature/om-openmanager-pilot /home/grshin/project/next-om/worktrees/om-pilot HEAD
```

이미 브랜치가 존재하는 경우에는 다음 명령을 사용한다.

```bash
git worktree add /home/grshin/project/next-om/worktrees/om-pilot feature/om-openmanager-pilot
```

## 검증용 Worktree 생성

검증 전용 Worktree는 다음처럼 생성한다.

```bash
cd /home/grshin/project/next-om/om-signoz
git worktree add -b verify/om-harnessops /home/grshin/project/next-om/worktrees/om-verify HEAD
```

이미 브랜치가 존재하는 경우에는 다음 명령을 사용한다.

```bash
git worktree add /home/grshin/project/next-om/worktrees/om-verify verify/om-harnessops
```

## Worktree 목록 확인

전체 Worktree 목록은 다음 명령으로 확인한다.

```bash
git worktree list
```

상세 정보는 다음 명령으로 확인한다.

```bash
git worktree list --porcelain
```

## Worktree별 작업 전 확인

각 Worktree에서 작업하기 전에 다음 명령을 실행한다.

```bash
pwd
git branch --show-current
git status --short
```

작업 목적과 브랜치가 맞지 않으면 작업을 중단한다.

## Worktree 최신화

Worktree에서 원격 변경사항을 반영해야 하는 경우 다음 순서로 진행한다.

```bash
git fetch origin
git status --short
git branch --show-current
```

Fast-forward가 가능한 경우에만 pull을 수행한다.

```bash
git pull --ff-only origin <branch-name>
```

예시는 다음과 같다.

```bash
git pull --ff-only origin feature/om-harnessops-v2
```

## Worktree 삭제

작업이 완료되고 변경사항이 모두 Commit / Push 되었다면 Worktree를 삭제할 수 있다.

먼저 기준 저장소로 이동한다.

```bash
cd /home/grshin/project/next-om/om-signoz
```

삭제할 Worktree 상태를 확인한다.

```bash
git -C /home/grshin/project/next-om/worktrees/om-harnessops-v2 status --short
```

아무 내용도 출력되지 않으면 삭제할 수 있다.

```bash
git worktree remove /home/grshin/project/next-om/worktrees/om-harnessops-v2
```

정리한다.

```bash
git worktree prune
```

삭제 결과를 확인한다.

```bash
git worktree list
```

## Worktree 삭제 실패 시 조치

삭제 시 변경사항이 남아 있다는 메시지가 나오면 다음을 확인한다.

```bash
git -C /home/grshin/project/next-om/worktrees/om-harnessops-v2 status --short
```

변경사항을 보존해야 한다면 Commit한다.
변경사항을 폐기해야 한다면 사용자 승인 후 정리한다.

강제 삭제는 기본적으로 사용하지 않는다.

## 자주 발생하는 상황

### 이미 브랜치가 사용 중인 경우

다음 오류가 발생할 수 있다.

```text
fatal: 'feature/...' is already checked out at ...
```

이 경우 동일 브랜치가 다른 Worktree에서 사용 중인 것이다.

확인 명령은 다음과 같다.

```bash
git worktree list
```

다른 브랜치를 사용하거나 기존 Worktree를 정리한다.

### Worktree 경로가 이미 존재하는 경우

다음 오류가 발생할 수 있다.

```text
fatal: ... already exists
```

경로가 비어 있는지 확인한다.

```bash
ls -al /home/grshin/project/next-om/worktrees
```

임의로 `rm -rf` 하지 말고, Git Worktree 목록과 실제 경로를 먼저 확인한다.

### 잘못된 Worktree에서 작업한 경우

현재 위치와 브랜치를 확인한다.

```bash
pwd
git branch --show-current
git status --short
```

변경사항을 옮겨야 한다면 Patch, Stash, Commit 전략을 먼저 정리한 뒤 진행한다.

## 금지 사항

- Worktree 경로를 저장소 내부에 생성하지 않는다.
- `rm -rf`로 Worktree를 삭제하지 않는다.
- 현재 브랜치 확인 없이 Commit하지 않는다.
- 다른 목적의 변경 파일을 하나의 Commit에 섞지 않는다.
- 운영 명령을 Worktree 생성 절차와 함께 실행하지 않는다.