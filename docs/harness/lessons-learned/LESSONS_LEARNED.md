# OpenManager HarnessOps Lessons Learned

## 문서 목적

본 문서는 OpenManager HarnessOps v2 Pilot 적용 결과를 기준으로 Lessons Learned를 정리한다.

Lessons Learned는 단순 회고가 아니라, 이후 HarnessOps 운영 방식, 팀 온보딩, 품질 기준, 자동화 개선에 반영하기 위한 개선 근거이다.

## 기준 단계

본 문서는 다음 단계를 기준으로 작성한다.

| 항목 | 내용 |
|---|---|
| 기준 단계 | 20단계 |
| 선행 단계 | 19단계 — OpenManager Pilot 기능 적용 |
| 기준 Pilot | OpenManager Dashboard 카드 로딩 상태 개선 검토 |
| 실제 구현 여부 | 사용자 승인 후 별도 진행 |
| 문서 목적 | 회고 및 운영 개선 기준 정리 |

## Lessons Learned 요약

19단계 Pilot 기준으로 확인한 주요 Lessons Learned는 다음과 같다.

| 구분 | 내용 |
|---|---|
| 잘 된 점 | Pilot 적용 전 계획, 범위, 제외 범위를 먼저 정의했다. |
| 잘 된 점 | 사용자 승인 전 실제 구현을 제한했다. |
| 잘 된 점 | Search-First와 Change Plan을 선행 절차로 명확히 연결했다. |
| 개선 필요 | Pilot 수행 결과를 정량 지표로 기록하는 기준이 필요하다. |
| 개선 필요 | 반복 적용 가능한 표준 템플릿과 측정 양식이 필요하다. |
| 개선 필요 | 팀원이 동일 절차를 따라 수행할 수 있는 온보딩 자료가 필요하다. |

## 잘 된 점

### 1. 구현 전 계획 수립

Pilot을 바로 구현하지 않고 먼저 계획 문서를 작성했다.

이를 통해 다음 효과를 얻을 수 있다.

```text
- 변경 범위 명확화
- 제외 범위 명확화
- 사용자 승인 기준 명확화
- 실제 구현 전 위험도 확인
```

### 2. HarnessOps Workflow 연결

Pilot 작업을 단독 문서로 끝내지 않고 기존 HarnessOps Workflow와 연결했다.

연결된 Workflow는 다음과 같다.

```text
Jira Issue Workflow
Search-First Analysis Workflow
Change Plan Workflow
Implementation Validation Workflow
Quality Gate Workflow
Change History Workflow
Tool Usage Audit Workflow
```

### 3. 사용자 승인 전 구현 차단

실제 소스코드 변경은 사용자 승인 후 진행하도록 기준을 명확히 했다.

이는 AI Agent 기반 작업에서 매우 중요한 Guardrail이다.

### 4. 운영 영향 범위 분리

Frontend Pilot 후보를 선정하여 Backend, DB, OTel Pipeline, Kubernetes 영향도를 낮췄다.

초기 Pilot으로는 운영 영향이 낮은 작업이 적합하다.

## 개선 필요 사항

### 1. 정량 지표 부족

Pilot 계획과 결과는 정리되었지만, 실제 수행 시간을 수치화하는 기준은 부족하다.

보완이 필요한 지표는 다음과 같다.

```text
- 요청 분석 소요 시간
- Search-First 수행 시간
- Change Plan 작성 시간
- 검증 소요 시간
- 재작업 발생 여부
```

### 2. 반복 적용 기준 필요

Pilot 절차가 1회성 문서로 끝나지 않으려면 반복 적용 기준이 필요하다.

다음 항목을 표준화해야 한다.

```text
- Pilot 요청 접수 기준
- Pilot 선정 기준
- Pilot 수행 템플릿
- Pilot 결과 기록 기준
- Lessons Learned 반영 기준
```

### 3. 팀 온보딩 연결 필요

20단계 결과는 21단계 팀 공통 배포 패키지와 온보딩 체계로 연결해야 한다.

팀원이 따라야 할 최소 기준은 다음과 같다.

```text
- 요청을 바로 구현하지 않는다.
- Search-First를 먼저 수행한다.
- Change Plan을 작성한다.
- 사용자 승인 후 구현한다.
- Quality Gate를 수행한다.
- Change History를 남긴다.
```

## 반복 적용 가능한 기준

이번 Pilot에서 반복 적용 가능한 기준은 다음과 같다.

| 항목 | 반복 적용 가능 여부 | 설명 |
|---|---:|---|
| Pilot Plan 작성 | 가능 | 모든 Pilot에 적용 가능 |
| Pilot Result 작성 | 가능 | 완료 후 결과 기록에 적용 가능 |
| Search-First 선행 | 가능 | 모든 구현 전 필수 적용 가능 |
| Change Plan 작성 | 가능 | 변경 영향 분석에 적용 가능 |
| 사용자 승인 기준 | 가능 | 위험 작업 전 필수 적용 가능 |
| Quality Gate | 가능 | 구현 후 검증에 적용 가능 |
| Change History | 가능 | Commit 전후 기록에 적용 가능 |

## 위험도와 개선 방향

| 위험 요소 | 현재 대응 | 개선 방향 |
|---|---|---|
| 승인 전 구현 | 문서 기준으로 차단 | HookOps와 Skill에서 반복 강조 |
| 변경 범위 혼합 | Pilot 범위 분리 | Worktree 기준 적용 강화 |
| 검증 누락 | Quality Gate 연결 | 점검 스크립트와 템플릿 보강 |
| 감사 누락 | Tool Usage Audit 연결 | 자동 로그와 수동 기록 병행 |
| 팀별 편차 | 문서 기준 제공 | 21단계 온보딩 자료로 표준화 |

## 다음 단계 반영 사항

20단계 결과는 21단계에서 다음 항목으로 반영한다.

```text
- 팀 공통 HarnessOps 배포 패키지
- Claude Code 사용 가이드
- 신규 구성원 온보딩 체크리스트
- Pilot 수행 실습 시나리오
- 운영 지표 주간 또는 월간 점검 기준
```

## 결론

OpenManager HarnessOps v2 Pilot은 실제 구현 전 계획, 분석, 승인, 검증, 감사 흐름을 정리하는 데 효과가 있다.

다만 조직 내 반복 적용을 위해서는 운영 지표와 온보딩 체계가 필요하다.

20단계에서는 Lessons Learned와 Metrics를 통해 HarnessOps를 개인 작업 방식이 아니라 팀 공통 운영 방식으로 전환할 기반을 마련한다.