# OpenManager HarnessOps Metrics

## 문서 목적

본 문서는 OpenManager HarnessOps v2 운영 효과를 측정하기 위한 지표를 정의한다.

HarnessOps Metrics는 AI Agent 기반 개발·검증·감사 운영체계가 실제로 품질, 안정성, 재현성, 감사 가능성을 높이는지 확인하기 위한 기준이다.

## 지표 분류

HarnessOps 운영 지표는 다음 4개 영역으로 분류한다.

| 영역 | 설명 |
|---|---|
| Process Metrics | 요청 분석, 계획, 승인, 검증 절차 수행 여부 |
| Quality Metrics | 품질 검증, 오류 감소, 재작업 감소 여부 |
| Governance Metrics | 승인, 감사, 변경 이력, Guardrail 준수 여부 |
| Adoption Metrics | 팀 확산, 온보딩, 반복 적용 가능성 |

## 핵심 지표 요약

| 지표 | 측정 방식 | 목표 |
|---|---|---|
| Search-First 수행률 | Search-First 수행 건수 ÷ 전체 구현 요청 건수 × 100 | 90% 이상 |
| Change Plan 작성률 | Change Plan 작성 건수 ÷ 변경 요청 건수 × 100 | 90% 이상 |
| 사용자 승인 전 구현 차단률 | 승인 전 차단 건수 ÷ 승인 필요 작업 건수 × 100 | 100% |
| Quality Gate 수행률 | Quality Gate 수행 건수 ÷ 구현 완료 건수 × 100 | 90% 이상 |
| Change History 기록률 | Change History 기록 건수 ÷ Commit 또는 변경 건수 × 100 | 90% 이상 |
| Tool Usage Audit 기록률 | Tool Audit 기록 건수 ÷ 도구 사용 대상 작업 건수 × 100 | 80% 이상 |
| Guardrail 차단 건수 | Hook 또는 정책으로 차단된 위험 작업 수 | 추세 관리 |
| 재작업 감소율 | 개선 전 재작업 건수 대비 개선 후 감소 비율 | 추세 관리 |
| 온보딩 완료율 | 온보딩 완료 인원 ÷ 대상 인원 × 100 | 90% 이상 |

## Process Metrics

Process Metrics는 HarnessOps 절차가 지켜졌는지를 측정한다.

| 지표 | 정의 | 산식 |
|---|---|---|
| 요청 분석 수행률 | 요청을 요약하고 유형을 분류한 비율 | 분석 수행 건수 ÷ 전체 요청 건수 × 100 |
| Search-First 수행률 | 구현 전 기존 코드와 문서를 먼저 검색한 비율 | Search-First 수행 건수 ÷ 구현 요청 건수 × 100 |
| Change Plan 작성률 | 변경 전 계획 문서를 작성한 비율 | Change Plan 작성 건수 ÷ 변경 요청 건수 × 100 |
| 사용자 승인 확인률 | 승인 필요 작업에서 승인을 확인한 비율 | 승인 확인 건수 ÷ 승인 필요 건수 × 100 |
| Worktree 분리 적용률 | 작업 목적별 Worktree를 분리한 비율 | Worktree 적용 건수 ÷ 분리 필요 작업 건수 × 100 |

## Quality Metrics

Quality Metrics는 결과 품질과 재작업 감소를 측정한다.

| 지표 | 정의 | 산식 |
|---|---|---|
| Quality Gate 수행률 | 구현 후 품질 검증을 수행한 비율 | Quality Gate 수행 건수 ÷ 구현 완료 건수 × 100 |
| Validation 수행률 | 구현 검증 절차를 수행한 비율 | Validation 수행 건수 ÷ 구현 완료 건수 × 100 |
| 재작업 발생률 | 완료 후 재수정이 발생한 비율 | 재작업 건수 ÷ 완료 작업 건수 × 100 |
| 결함 재발률 | 동일 유형 문제가 반복된 비율 | 재발 결함 건수 ÷ 전체 결함 건수 × 100 |
| 문서 누락률 | 결과 문서가 누락된 비율 | 문서 누락 건수 ÷ 완료 작업 건수 × 100 |

## Governance Metrics

Governance Metrics는 승인, 감사, Guardrail 준수 여부를 측정한다.

| 지표 | 정의 | 산식 |
|---|---|---|
| Change History 기록률 | 변경 이력을 기록한 비율 | Change History 기록 건수 ÷ 변경 건수 × 100 |
| Tool Usage Audit 기록률 | 도구 사용 이력을 기록한 비율 | Audit 기록 건수 ÷ 기록 대상 도구 사용 건수 × 100 |
| Guardrail 차단 건수 | 위험 명령 또는 민감 파일 접근 차단 건수 | 차단 건수 합계 |
| 승인 없는 위험 작업 건수 | 승인 없이 수행된 위험 작업 수 | 발생 건수 |
| 민감 정보 노출 건수 | 민감 파일 또는 Token 노출 건수 | 발생 건수 |

## Adoption Metrics

Adoption Metrics는 팀 확산과 반복 적용 가능성을 측정한다.

| 지표 | 정의 | 산식 |
|---|---|---|
| 온보딩 완료율 | 팀원이 HarnessOps 기본 교육을 완료한 비율 | 완료 인원 ÷ 대상 인원 × 100 |
| 템플릿 사용률 | 표준 템플릿을 사용한 비율 | 템플릿 사용 건수 ÷ 대상 작업 건수 × 100 |
| Skill 사용률 | 작업에 적절한 Skill을 사용한 비율 | Skill 사용 건수 ÷ 대상 작업 건수 × 100 |
| Agent 검토율 | 전문 Agent 검토를 수행한 비율 | Agent 검토 건수 ÷ 검토 대상 작업 건수 × 100 |
| 반복 적용 가능률 | 동일 절차를 다른 작업에 적용 가능한 비율 | 반복 가능 작업 건수 ÷ Pilot 작업 건수 × 100 |

## 권장 측정 주기

| 주기 | 측정 항목 |
|---|---|
| 작업 단위 | Search-First, Change Plan, Validation, Quality Gate |
| Commit 전 | Change History, Tool Usage Audit, 민감 파일 포함 여부 |
| 주간 | 완료 작업, 재작업, Guardrail 차단 건수 |
| 월간 | 온보딩, 지표 추세, 개선 과제 |
| Pilot 종료 후 | Lessons Learned, 반복 적용 가능성 |

## 지표 해석 기준

지표 해석 기준은 다음과 같다.

| 상태 | 기준 | 해석 |
|---|---|---|
| 양호 | 90% 이상 | 팀 표준으로 정착 가능 |
| 주의 | 70% 이상 90% 미만 | 일부 절차 누락 가능성 있음 |
| 개선 필요 | 70% 미만 | 운영 방식 재정비 필요 |
| 위험 | 승인 없는 위험 작업 발생 | 즉시 원인 분석 필요 |
| 심각 | 민감 정보 노출 발생 | 즉시 차단 및 재발 방지 필요 |

## 운영 리포트 기준

월간 운영 리포트에는 다음 항목을 포함한다.

```text
- 총 요청 건수
- Pilot 또는 구현 작업 건수
- Search-First 수행률
- Change Plan 작성률
- Quality Gate 수행률
- Change History 기록률
- Tool Usage Audit 기록률
- Guardrail 차단 건수
- 재작업 발생 건수
- Lessons Learned 주요 개선사항
- 다음 달 개선 계획
```

## 결론

HarnessOps Metrics는 AI Agent 기반 개발 환경을 단순 생산성 도구가 아니라 통제 가능한 운영체계로 관리하기 위한 기준이다.

20단계에서 정의한 지표는 21단계 팀 공통 배포 패키지와 온보딩 체계에 반영한다.