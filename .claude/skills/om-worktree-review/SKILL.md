---
name: OpenManager Worktree Review
description: OpenManager HarnessOps에서 Git Worktree 기반 작업 격리, 브랜치 분리, 작업 위치 확인, Worktree 정리 기준을 검토할 때 사용한다.
when_to_use: Git Worktree, 작업 격리, 브랜치 분리, Pilot 작업, HarnessOps v2 변경, Worktree 생성 또는 삭제 전 검토가 필요할 때 사용한다.
allowed-tools: Read Grep Glob Bash
---

# OpenManager Worktree Review Skill

## 목적

OpenManager HarnessOps 환경에서 Git Worktree 기반 작업 격리 상태를 검토한다.

이 Skill은 작업이 올바른 Worktree와 브랜치에서 수행되는지 확인하고, 하네스 변경, 기능 개발, 검증 작업이 섞이지 않도록 돕는다.

## 참조 문서

우선 다음 문서를 확인한다.

```text
docs/harness/git-worktree/WORKTREE_POLICY.md
docs/harness/git-worktree/WORKTREE_RUNBOOK.md
docs/harness/templates/worktree-task-template.md
docs/harness/WORKTREE_INVENTORY.md
```

## 검토 대상

다음 항목을 검토한다.

| 대상 | 검토 내용 |
|---|---|
| 현재 경로 | 의도한 Worktree 경로인지 확인 |
| 현재 브랜치 | 작업 목적에 맞는 브랜치인지 확인 |
| 변경 파일 | 작업 범위와 일치하는지 확인 |
| Worktree 목록 | 동일 브랜치 중복 사용 여부 확인 |
| 저장소 내부 Worktree | 잘못된 위치에 Worktree가 생성되었는지 확인 |
| Commit 전 상태 | 변경 파일, 민감 파일, 불필요 파일 확인 |
| Worktree 삭제 | 삭제 가능 여부와 남은 변경사항 확인 |

## 수행 절차

요청을 받으면 다음 순서로 검토한다.

1. 사용자 요청을 요약한다.
2. 현재 작업 목적을 분류한다.
3. 기준 저장소와 Worktree 경로를 확인한다.
4. 현재 브랜치가 작업 목적과 맞는지 확인한다.
5. `git worktree list` 결과를 확인한다.
6. 변경 파일이 작업 범위와 맞는지 확인한다.
7. Commit 또는 Push 전 확인 항목을 정리한다.
8. Worktree 삭제 또는 유지 기준을 판단한다.

## 권장 확인 명령

필요 시 다음 명령을 사용한다.

```bash
pwd
git branch --show-current
git status --short
git worktree list
git worktree list --porcelain
```

## 출력 형식

```text
OpenManager Worktree 검토 결과

1. 요청 요약
-

2. 작업 유형
- 하네스 변경 / 기능 개발 / 검증 / 문서 / 오류 수정:

3. 현재 위치와 브랜치
- 현재 경로:
- 현재 브랜치:
- Worktree 여부:

4. Worktree 정책 적합성
- 적합 / 부적합:
- 사유:

5. 변경 파일 범위
- 작업 범위 내 파일:
- 작업 범위 외 파일:
- 민감 파일 포함 여부:

6. Commit / Push 가능 여부
- Commit 가능 여부:
- Push 가능 여부:
- 추가 확인 사항:

7. Worktree 정리 필요 여부
- 유지 / 삭제 / 보류:
- 사유:

8. 결론
- 진행 가능 여부:
- 사용자 승인 필요 사항:
- 후속 조치:
```

## 금지 사항

- 현재 Worktree와 브랜치 확인 없이 Commit을 제안하지 않는다.
- 저장소 내부에 Worktree를 생성하도록 제안하지 않는다.
- `rm -rf`로 Worktree 삭제를 제안하지 않는다.
- 변경사항이 남아 있는 Worktree 삭제를 제안하지 않는다.
- 민감 파일을 Git에 추가하도록 제안하지 않는다.
- 하네스 변경과 기능 개발을 같은 Commit으로 묶도록 제안하지 않는다.