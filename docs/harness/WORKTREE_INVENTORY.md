# OpenManager Worktree Inventory

## 문서 목적

본 문서는 OpenManager HarnessOps v2의 Git Worktree 관련 산출물과 관리 기준을 정리한다.

## Worktree 산출물 목록

| 구분 | 파일 | 역할 |
|---|---|---|
| Policy | `docs/harness/git-worktree/WORKTREE_POLICY.md` | Worktree 운영 정책 |
| RunBook | `docs/harness/git-worktree/WORKTREE_RUNBOOK.md` | Worktree 생성, 사용, 정리 절차 |
| Template | `docs/harness/templates/worktree-task-template.md` | Worktree 작업 기록 양식 |
| Skill | `.claude/skills/om-worktree-review/SKILL.md` | Worktree 작업 격리 검토 Skill |
| Script | `docs/harness/scripts/check-step17-git-worktree.sh` | 17단계 산출물 점검 스크립트 |

## 기준 경로

| 구분 | 경로 |
|---|---|
| 기준 저장소 | `/home/grshin/project/next-om/om-signoz` |
| Worktree 상위 경로 | `/home/grshin/project/next-om/worktrees` |
| 금지 경로 | `/home/grshin/project/next-om/om-signoz/worktrees` |

## 권장 Worktree 목록

| Worktree 이름 | 용도 | 권장 브랜치 |
|---|---|---|
| `om-harnessops-v2` | HarnessOps v2 문서, 정책, Skill, Workflow 변경 | `feature/om-harnessops-v2` |
| `om-pilot` | OpenManager Pilot 기능 적용 | `feature/om-openmanager-pilot` |
| `om-verify` | 검증, Quality Gate, 재현 테스트 | `verify/om-harnessops` |
| `om-docs` | 문서 전용 수정 | `docs/om-harnessops-*` |
| `om-fix` | 오류 수정 | `fix/om-*` |

## 관련 문서

Worktree 운영은 다음 문서와 함께 사용한다.

```text
CLAUDE.md
AGENTS.md
docs/harness/HOOKOPS_INVENTORY.md
docs/harness/QUALITY_GATES_INVENTORY.md
docs/harness/AUDIT_TRAIL_INVENTORY.md
docs/harness/operations/harness-operation-policy.md
docs/harness/operations/harness-maintenance-runbook.md
```

## 점검 기준

17단계 완료 시 다음을 확인한다.

| 항목 | 기준 |
|---|---|
| Worktree Policy | 존재하고 비어 있지 않아야 함 |
| Worktree RunBook | 존재하고 비어 있지 않아야 함 |
| Worktree Task Template | 존재하고 비어 있지 않아야 함 |
| om-worktree-review Skill | YAML frontmatter와 본문이 있어야 함 |
| 기준 저장소 | `/home/grshin/project/next-om/om-signoz` 기준 유지 |
| Worktree 상위 경로 | 저장소 외부 경로 사용 |
| 점검 스크립트 | 실행 가능해야 함 |

## 변경 승인 기준

다음 변경은 사용자 승인이 필요하다.

- Worktree 정책 변경
- Worktree 삭제
- Worktree 브랜치 변경
- Worktree에서 Force Push 수행
- Worktree에서 운영 명령 수행
- Worktree에서 민감 파일 접근
- Worktree 경로를 저장소 내부로 변경

## 운영 기준

Worktree는 다음 시점에 점검한다.

| 시점 | 점검 내용 |
|---|---|
| Worktree 생성 전 | 기준 저장소 상태와 브랜치 확인 |
| 작업 시작 전 | 현재 경로와 브랜치 확인 |
| Commit 전 | 변경 파일과 민감 파일 포함 여부 확인 |
| Push 전 | Quality Gate와 Change History 확인 |
| Worktree 삭제 전 | 변경사항 잔여 여부 확인 |
| 월 1회 | 불필요한 Worktree 정리 |