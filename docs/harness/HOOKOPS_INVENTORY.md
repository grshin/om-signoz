# OpenManager HookOps Inventory

## 문서 목적

본 문서는 OpenManager HarnessOps v2의 HookOps 관련 산출물과 관리 기준을 정리한다.

## HookOps 산출물 목록

| 구분 | 파일 | 역할 |
|---|---|---|
| Policy | `docs/harness/hookops/HOOKOPS_POLICY.md` | HookOps 운영 정책 |
| Policy | `docs/harness/hookops/GUARDRAIL_EXCEPTION_POLICY.md` | Guardrail 예외 승인 정책 |
| Template | `docs/harness/templates/hookops-result-template.md` | HookOps 결과 기록 양식 |
| Skill | `.claude/skills/om-hookops-review/SKILL.md` | HookOps 검토 Skill |
| Script | `docs/harness/scripts/check-step16-hookops.sh` | 16단계 산출물 점검 스크립트 |

## 기존 Hook 목록

| Hook | 역할 | 관리 기준 |
|---|---|---|
| `.claude/hooks/om/om-block-dangerous-bash.sh` | 위험 Bash 명령 차단 | 변경 시 승인 필요 |
| `.claude/hooks/om/om-protect-sensitive-files.sh` | 민감 파일 접근 보호 | 차단 기준 완화 금지 |
| `.claude/hooks/om/om-log-tool-usage.sh` | Tool 사용 로그 기록 | 로그 누락 시 보강 필요 |

## 적용 기준

HookOps는 다음 작업에 적용한다.

| 작업 유형 | 적용 기준 |
|---|---|
| 일반 코드 조회 | 허용 가능 |
| Git 상태 확인 | 허용 가능 |
| Git Commit / Push | 승인 필요 |
| Docker 명령 | 승인 필요 |
| Kubernetes / Helm 명령 | 승인 필요 |
| 외부 URL 호출 | 승인 필요 |
| 민감 파일 접근 | 차단 |
| 위험 삭제 명령 | 차단 |
| Force Push | 차단 |

## 관련 문서

HookOps는 다음 문서와 함께 사용한다.

```text
.claude/settings.json
docs/harness/AUDIT_TRAIL_INVENTORY.md
docs/harness/QUALITY_GATES_INVENTORY.md
docs/harness/operations/harness-operation-policy.md
docs/harness/operations/harness-maintenance-runbook.md
docs/harness/templates/tool-usage-audit-template.md
docs/harness/templates/change-history-template.md
```

## 점검 기준

16단계 완료 시 다음을 확인한다.

| 항목 | 기준 |
|---|---|
| HookOps Policy | 존재하고 비어 있지 않아야 함 |
| Guardrail Exception Policy | 존재하고 비어 있지 않아야 함 |
| HookOps Result Template | 존재하고 비어 있지 않아야 함 |
| om-hookops-review Skill | YAML frontmatter와 본문이 있어야 함 |
| 기존 Hook 파일 | 삭제되지 않아야 함 |
| 기존 Hook 문법 | `bash -n` 통과 |
| 16단계 점검 스크립트 | 실행 가능해야 함 |

## 변경 승인 기준

다음 변경은 사용자 승인이 필요하다.

- 기존 Hook 삭제
- 기존 Hook 차단 기준 완화
- `.claude/settings.json` permission 완화
- 민감 파일 접근 허용
- 운영 명령 자동 허용
- 외부 네트워크 호출 자동 허용
- Sandbox 제한 완화

## 운영 기준

HookOps는 다음 주기로 점검한다.

| 주기 | 점검 내용 |
|---|---|
| 매 변경 작업 전 | 위험 명령과 민감 파일 접근 여부 확인 |
| Commit 전 | Quality Gate와 HookOps 결과 확인 |
| Push 전 | Tool Usage Audit 기록 여부 확인 |
| 월 1회 | Hook 정책과 예외 승인 이력 검토 |
| 하네스 변경 시 | HookOps Inventory 갱신 |