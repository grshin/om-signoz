# OpenManager Harness Maintenance Review 템플릿

## 1. 유지관리 리뷰 개요

| 항목 | 내용 |
|---|---|
| Review ID |  |
| Review 일자 |  |
| 작성자 |  |
| 대상 브랜치 | `feature/om-harness-bootstrap` |
| Review 유형 | 정기 점검 / 변경 후 점검 / 장애 후 점검 / 운영 적용 전 점검 |
| Review 상태 | 진행 / 완료 / 보류 |

## 2. Review 목적

```text
이번 유지관리 리뷰의 목적을 작성한다.
예: 15단계 운영 적용 이후 Rule, Skill, Agent, Workflow의 정합성을 점검한다.
```

## 3. Review 대상 기간

| 항목 | 내용 |
|---|---|
| 시작일 |  |
| 종료일 |  |
| 대상 Commit 범위 |  |
| 대상 작업 범위 |  |

## 4. 하네스 구성 요소 점검

| 구성 요소 | 점검 결과 | 비고 |
|---|---|---|
| Steering / `CLAUDE.md` | PASS / WARN / FAIL / N/A |  |
| Rule | PASS / WARN / FAIL / N/A |  |
| Skill | PASS / WARN / FAIL / N/A |  |
| Agent | PASS / WARN / FAIL / N/A |  |
| Hook | PASS / WARN / FAIL / N/A |  |
| MCP 정책 | PASS / WARN / FAIL / N/A |  |
| Workflow | PASS / WARN / FAIL / N/A |  |
| Template | PASS / WARN / FAIL / N/A |  |
| Scenario | PASS / WARN / FAIL / N/A |  |
| Inventory | PASS / WARN / FAIL / N/A |  |
| Script | PASS / WARN / FAIL / N/A |  |

## 5. 최근 변경 이력 검토

| 항목 | 내용 |
|---|---|
| 최근 변경 건수 |  |
| 주요 변경 내용 |  |
| Change History 작성 여부 | 예 / 아니오 |
| Tool Usage Audit 수행 여부 | 예 / 아니오 |
| Quality Gate 수행 여부 | 예 / 아니오 |
| Scenario Validation 필요 여부 | 예 / 아니오 |

## 6. Rule 리뷰

| 항목 | 결과 | 비고 |
|---|---|---|
| 공통 Rule이 최신 운영 기준을 반영하는가 | PASS / WARN / FAIL |  |
| 경로별 Rule이 실제 변경 유형과 맞는가 | PASS / WARN / FAIL |  |
| Rule 간 충돌이 없는가 | PASS / WARN / FAIL |  |
| 보안 기준이 약화되지 않았는가 | PASS / WARN / FAIL |  |
| Quality Gate 기준이 유지되는가 | PASS / WARN / FAIL |  |

### Rule 개선 필요 사항

| Rule | 개선 내용 | 우선순위 |
|---|---|---|
|  |  | 낮음 / 보통 / 높음 |

## 7. Skill 리뷰

| 항목 | 결과 | 비고 |
|---|---|---|
| Skill 목적이 명확한가 | PASS / WARN / FAIL |  |
| 불필요한 Tool 권한이 없는가 | PASS / WARN / FAIL |  |
| 수동 호출 기준이 명확한가 | PASS / WARN / FAIL |  |
| Workflow / Template과 연결되는가 | PASS / WARN / FAIL |  |
| 출력 형식이 실제 운영에 유용한가 | PASS / WARN / FAIL |  |

### Skill 개선 필요 사항

| Skill | 개선 내용 | 우선순위 |
|---|---|---|
|  |  | 낮음 / 보통 / 높음 |

## 8. Agent 리뷰

| 항목 | 결과 | 비고 |
|---|---|---|
| Agent 역할이 명확한가 | PASS / WARN / FAIL |  |
| Agent 간 책임 경계가 유지되는가 | PASS / WARN / FAIL |  |
| 전문 영역별 Agent가 적절히 사용되는가 | PASS / WARN / FAIL |  |
| 기존 SigNoz Playwright Agent가 보존되는가 | PASS / WARN / FAIL |  |
| Agent 지침이 보안 기준을 따르는가 | PASS / WARN / FAIL |  |

### Agent 개선 필요 사항

| Agent | 개선 내용 | 우선순위 |
|---|---|---|
|  |  | 낮음 / 보통 / 높음 |

## 9. Workflow / Template 리뷰

| 항목 | 결과 | 비고 |
|---|---|---|
| Workflow 흐름이 실제 작업 흐름과 맞는가 | PASS / WARN / FAIL |  |
| Template 기록 항목이 충분한가 | PASS / WARN / FAIL |  |
| 중복되거나 불필요한 항목이 없는가 | PASS / WARN / FAIL |  |
| 사용자 승인 기준이 명확한가 | PASS / WARN / FAIL |  |
| Audit Trail과 연결되는가 | PASS / WARN / FAIL |  |

### Workflow / Template 개선 필요 사항

| 파일 | 개선 내용 | 우선순위 |
|---|---|---|
|  |  | 낮음 / 보통 / 높음 |

## 10. Hook / Guardrail 리뷰

| 항목 | 결과 | 비고 |
|---|---|---|
| 위험 명령 차단 기준이 유지되는가 | PASS / WARN / FAIL |  |
| 민감 파일 보호 기준이 유지되는가 | PASS / WARN / FAIL |  |
| Tool 사용 로그 기록이 유지되는가 | PASS / WARN / FAIL |  |
| 과도한 차단으로 정상 작업이 방해되지 않는가 | PASS / WARN / FAIL |  |
| Hook 변경 이력이 기록되었는가 | PASS / WARN / FAIL / N/A |  |

### Hook 개선 필요 사항

| Hook | 개선 내용 | 우선순위 |
|---|---|---|
|  |  | 낮음 / 보통 / 높음 |

## 11. 보안 리뷰

| 항목 | 결과 | 비고 |
|---|---|---|
| Secret 원문이 문서에 포함되지 않았는가 | PASS / WARN / FAIL |  |
| 민감 파일이 Git 추적 대상이 아닌가 | PASS / WARN / FAIL |  |
| `settings.local.json`이 Git에 포함되지 않았는가 | PASS / WARN / FAIL |  |
| 운영 명령이 승인 없이 실행되지 않았는가 | PASS / WARN / FAIL |  |
| Git Push가 승인 없이 수행되지 않았는가 | PASS / WARN / FAIL |  |

## 12. Scenario Validation 리뷰

| 시나리오 | 결과 | 보완 필요 사항 |
|---|---|---|
| Backend API 변경 | PASS / WARN / FAIL / N/A |  |
| Frontend Dashboard 변경 | PASS / WARN / FAIL / N/A |  |
| OTel Pipeline 변경 | PASS / WARN / FAIL / N/A |  |
| Kubernetes 배포 변경 | PASS / WARN / FAIL / N/A |  |
| Harness 변경 | PASS / WARN / FAIL / N/A |  |

## 13. 운영 적용 상태 리뷰

| 항목 | 결과 | 비고 |
|---|---|---|
| 개발 요청에 Spec 흐름이 적용되는가 | PASS / WARN / FAIL |  |
| 구현 전 Search-First가 수행되는가 | PASS / WARN / FAIL |  |
| 구현 전 Change Plan이 작성되는가 | PASS / WARN / FAIL |  |
| 구현 후 Validation이 수행되는가 | PASS / WARN / FAIL |  |
| Commit 전 Quality Gate가 수행되는가 | PASS / WARN / FAIL |  |
| Change History가 기록되는가 | PASS / WARN / FAIL |  |
| Tool Usage Audit이 수행되는가 | PASS / WARN / FAIL |  |

## 14. 개선 과제

| 개선 과제 | 대상 | 우선순위 | 담당 | 기한 |
|---|---|---|---|---|
|  |  | 낮음 / 보통 / 높음 |  |  |

## 15. 사용자 승인 필요 항목

| 항목 | 승인 필요 여부 | 사유 |
|---|---:|---|
| Rule 변경 |  |  |
| Skill 변경 |  |  |
| Agent 변경 |  |  |
| Hook 변경 |  |  |
| Tool 권한 변경 |  |  |
| 운영 기준 변경 |  |  |
| Git Push |  |  |

## 16. 최종 리뷰 결과

| 항목 | 결과 |
|---|---|
| 유지관리 상태 | 정상 / 보완 필요 / 조치 필요 |
| 주요 이슈 |  |
| 즉시 조치 항목 |  |
| 다음 리뷰 권장 시점 |  |
| 승인자 |  |

## 17. 최종 요약

```text
하네스 유지관리 리뷰 결과를 요약한다.
Secret 원문, 인증 정보, 개인 설정 파일 내용은 기록하지 않는다.
WARN 또는 FAIL 항목이 있으면 개선 과제로 등록한다.
```