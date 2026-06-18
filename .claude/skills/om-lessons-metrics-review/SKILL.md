---
name: OpenManager Lessons Metrics Review
description: OpenManager HarnessOps에서 Lessons Learned, 운영 지표, Pilot 회고, 품질 지표, 감사 지표, 온보딩 지표를 검토할 때 사용한다.
when_to_use: Lessons Learned, HarnessOps Metrics, Pilot 회고, 운영 지표, 품질 지표, 감사 지표, 온보딩 지표 검토가 필요할 때 사용한다.
allowed-tools: Read Grep Glob Bash
---

# OpenManager Lessons Metrics Review Skill

## 목적

OpenManager HarnessOps 환경에서 Lessons Learned와 운영 지표를 검토한다.

이 Skill은 Pilot 결과를 기반으로 반복 개선 항목을 도출하고, HarnessOps가 팀 운영체계로 확산될 수 있도록 지표와 회고 품질을 점검한다.

## 참조 문서

우선 다음 문서를 확인한다.

```text
docs/harness/lessons-learned/LESSONS_LEARNED.md
docs/harness/metrics/HARNESSOPS_METRICS.md
docs/harness/templates/lessons-learned-template.md
docs/harness/templates/harnessops-metrics-template.md
docs/harness/LESSONS_METRICS_INVENTORY.md
docs/harness/PILOT_INVENTORY.md
```

## 검토 대상

다음 항목을 검토한다.

| 대상 | 검토 내용 |
|---|---|
| Lessons Learned | 잘 된 점, 개선 필요 사항, 재발 방지 항목 |
| Process Metrics | Search-First, Change Plan, 승인 절차 수행률 |
| Quality Metrics | Quality Gate, Validation, 재작업, 결함 재발률 |
| Governance Metrics | Change History, Tool Usage Audit, Guardrail 준수 |
| Adoption Metrics | 온보딩, 템플릿 사용률, Skill 사용률 |
| Next Action | 21단계 온보딩과 팀 배포 패키지 반영 여부 |

## 수행 절차

요청을 받으면 다음 순서로 진행한다.

1. 회고 대상 작업 또는 Pilot을 식별한다.
2. Lessons Learned 문서를 확인한다.
3. Metrics 문서를 확인한다.
4. 정성 개선사항과 정량 지표를 분리한다.
5. 지표가 측정 가능한 형태인지 확인한다.
6. 위험 지표가 있는지 확인한다.
7. 다음 단계 반영 사항을 정리한다.
8. 21단계 온보딩과 연결할 항목을 제안한다.

## 출력 형식

```text
OpenManager Lessons / Metrics 검토 결과

1. 검토 대상
-

2. Lessons Learned 요약
- 잘 된 점:
- 개선 필요 사항:
- 반복 적용 가능성:

3. Metrics 검토
- Process Metrics:
- Quality Metrics:
- Governance Metrics:
- Adoption Metrics:

4. 주요 리스크
-

5. 개선 과제
-

6. 21단계 반영 사항
- 온보딩:
- 팀 공통 패키지:
- 교육 시나리오:
- 운영 점검:

7. 결론
- 운영 성숙도:
- 다음 조치:
- 사용자 확인 필요 사항:
```

## 금지 사항

- 근거 없는 성과 수치를 작성하지 않는다.
- 측정할 수 없는 지표를 핵심 지표로 제안하지 않는다.
- 민감 정보나 실제 고객 정보를 회고 문서에 기록하지 않는다.
- 실패 항목을 숨기지 않는다.
- 사용자 승인 없이 운영 정책을 변경하지 않는다.
- Lessons Learned를 단순 감상문으로 작성하지 않는다.