# OpenManager Pilot Inventory

## 문서 목적

본 문서는 OpenManager HarnessOps v2의 Pilot 적용 관련 산출물과 관리 기준을 정리한다.

## Pilot 산출물 목록

| 구분 | 파일 | 역할 |
|---|---|---|
| Plan | `docs/harness/pilot/OPENMANAGER_PILOT_PLAN.md` | Pilot 적용 계획 |
| Result | `docs/harness/pilot/OPENMANAGER_PILOT_RESULT.md` | Pilot 적용 결과 |
| Template | `docs/harness/templates/pilot-result-template.md` | Pilot 결과 기록 양식 |
| Skill | `.claude/skills/om-pilot-application/SKILL.md` | Pilot 적용 검토 Skill |
| Script | `docs/harness/scripts/check-step19-openmanager-pilot.sh` | 19단계 산출물 점검 스크립트 |

## Pilot 후보 목록

| 후보 | 영역 | 설명 | 상태 |
|---|---|---|---|
| Dashboard 카드 로딩 상태 개선 | Frontend | 로딩, 빈 데이터, 오류 상태 표시 개선 검토 | 기본 후보 |
| Alert 조회 API 개선 | Backend | 상태, 심각도, 시간 조건 필터 검토 | 후보 |
| OTel Pipeline 설정 개선 | OTel Pipeline | 수집 파이프라인 설정 영향 검토 | 후보 |
| Kubernetes Values 개선 | Deploy | Resource, Probe, Env 설정 검토 | 후보 |

## 기본 선정 Pilot

기본 선정 Pilot은 다음과 같다.

```text
[Pilot][Frontend] OpenManager Dashboard 카드 로딩 상태 개선 검토
```

## 관련 문서

Pilot 적용은 다음 문서와 함께 사용한다.

```text
docs/harness/JIRA_MCP_INVENTORY.md
docs/harness/WORKTREE_INVENTORY.md
docs/harness/HOOKOPS_INVENTORY.md
docs/harness/QUALITY_GATES_INVENTORY.md
docs/harness/AUDIT_TRAIL_INVENTORY.md
docs/harness/workflows/jira-issue-workflow.md
docs/harness/workflows/search-first-analysis-workflow.md
docs/harness/workflows/change-plan-workflow.md
docs/harness/workflows/implementation-validation-workflow.md
docs/harness/workflows/quality-gate-workflow.md
docs/harness/workflows/change-history-workflow.md
docs/harness/workflows/tool-usage-audit-workflow.md
```

## 점검 기준

19단계 완료 시 다음을 확인한다.

| 항목 | 기준 |
|---|---|
| Pilot Plan | 존재하고 비어 있지 않아야 함 |
| Pilot Result | 존재하고 비어 있지 않아야 함 |
| Pilot Result Template | 존재하고 비어 있지 않아야 함 |
| om-pilot-application Skill | YAML frontmatter와 본문이 있어야 함 |
| Pilot Inventory | 존재하고 비어 있지 않아야 함 |
| 점검 스크립트 | 실행 가능해야 함 |
| 실제 소스코드 변경 | 사용자 승인 전에는 없어야 함 |

## 사용자 승인 기준

다음 작업은 사용자 승인 후 수행한다.

- 실제 소스코드 수정
- 신규 기능 구현
- API 변경
- DB 변경
- OTel Pipeline 변경
- Kubernetes / Helm 변경
- 운영 명령 실행
- Jira Write 작업 수행

## 운영 기준

Pilot은 다음 기준으로 운영한다.

| 시점 | 점검 내용 |
|---|---|
| Pilot 선정 전 | 요청 목적과 영향도 확인 |
| 분석 전 | 관련 Rule, Skill, Agent 확인 |
| 구현 전 | Search-First와 Change Plan 확인 |
| Commit 전 | 변경 파일과 Quality Gate 확인 |
| Push 전 | Change History와 Tool Usage Audit 확인 |
| 완료 후 | Lessons Learned 연결 |

## 금지 사항

다음 작업은 금지한다.

- 사용자 승인 없는 구현
- Search-First 없는 코드 수정
- Change Plan 없는 운영 영향 변경
- 하네스 변경과 기능 구현 혼합 Commit
- Jira Issue 상태 변경
- 민감 정보 기록