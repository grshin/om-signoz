# OpenManager Lessons Metrics Inventory

## 문서 목적

본 문서는 OpenManager HarnessOps v2의 Lessons Learned 및 운영 지표 관련 산출물과 관리 기준을 정리한다.

## Lessons / Metrics 산출물 목록

| 구분 | 파일 | 역할 |
|---|---|---|
| Lessons | `docs/harness/lessons-learned/LESSONS_LEARNED.md` | Pilot 결과 기반 회고 |
| Metrics | `docs/harness/metrics/HARNESSOPS_METRICS.md` | HarnessOps 운영 지표 정의 |
| Template | `docs/harness/templates/lessons-learned-template.md` | 회고 기록 양식 |
| Template | `docs/harness/templates/harnessops-metrics-template.md` | 운영 지표 측정 양식 |
| Skill | `.claude/skills/om-lessons-metrics-review/SKILL.md` | Lessons / Metrics 검토 Skill |
| Script | `docs/harness/scripts/check-step20-lessons-metrics.sh` | 20단계 산출물 점검 스크립트 |

## 관련 문서

Lessons / Metrics는 다음 문서와 함께 사용한다.

```text
docs/harness/PILOT_INVENTORY.md
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

## 핵심 지표 목록

| 구분 | 지표 |
|---|---|
| Process | Search-First 수행률 |
| Process | Change Plan 작성률 |
| Process | 사용자 승인 확인률 |
| Quality | Quality Gate 수행률 |
| Quality | 재작업 발생률 |
| Governance | Change History 기록률 |
| Governance | Tool Usage Audit 기록률 |
| Governance | Guardrail 차단 건수 |
| Adoption | 온보딩 완료율 |
| Adoption | 템플릿 사용률 |

## 점검 기준

20단계 완료 시 다음을 확인한다.

| 항목 | 기준 |
|---|---|
| Lessons Learned | 존재하고 비어 있지 않아야 함 |
| HarnessOps Metrics | 존재하고 비어 있지 않아야 함 |
| Lessons Template | 존재하고 비어 있지 않아야 함 |
| Metrics Template | 존재하고 비어 있지 않아야 함 |
| Lessons Metrics Skill | YAML frontmatter와 본문이 있어야 함 |
| Lessons Metrics Inventory | 존재하고 비어 있지 않아야 함 |
| 점검 스크립트 | 실행 가능해야 함 |
| 실제 소스코드 변경 | 없어야 함 |

## 운영 기준

Lessons / Metrics는 다음 주기로 운영한다.

| 주기 | 내용 |
|---|---|
| Pilot 완료 후 | Lessons Learned 작성 |
| 작업 완료 후 | Metrics Template 업데이트 |
| 주간 | 주요 지표 추세 확인 |
| 월간 | 운영 리포트 작성 |
| 분기 | 지표 체계 개선 |
| 온보딩 전 | 팀 교육 자료 반영 |

## 변경 승인 기준

다음 변경은 사용자 승인이 필요하다.

- 핵심 지표 변경
- 운영 리포트 기준 변경
- Guardrail 지표 제외
- 감사 지표 제외
- 온보딩 기준 변경
- 실제 소스코드 변경을 동반하는 개선 작업

## 금지 사항

다음 작업은 금지한다.

- 근거 없는 지표 수치 작성
- 실패 또는 누락 항목 은폐
- 민감 정보 기록
- 고객사 실명 기록
- 인증 정보 기록
- Lessons Learned 없이 Pilot 종료 처리
- Metrics 없이 운영 효과 주장