# HarnessOps Vibe Coding Candidate Template

## 1. 후보 기본 정보

| 항목 | 내용 |
|---|---|
| 후보 ID | OM-VIBE-YYYYMMDD-001 |
| 후보명 |  |
| 관련 요구사항 ID |  |
| 관련 SigNoz 기능 |  |
| 관련 OpenManager 영역 |  |
| 작성일 | YYYY-MM-DD |
| 작성자 |  |

## 2. 후보 선정 배경

왜 이 항목을 HarnessOps 바이브 코딩 검증 후보로 선정했는지 작성한다.

## 3. 현재 기능 상태

현재 fork한 SigNoz OSS에서 확인한 기능 상태를 작성한다.

## 4. 개선 또는 신규 요구사항

OpenManager 관점에서 개선하거나 추가해야 할 내용을 작성한다.

## 5. 적용 범위

| 영역 | 포함 여부 | 설명 |
|---|---|---|
| Backend | 포함 / 제외 / 확인 필요 |  |
| Frontend | 포함 / 제외 / 확인 필요 |  |
| OTel Pipeline | 포함 / 제외 / 확인 필요 |  |
| Deploy / Helm | 포함 / 제외 / 확인 필요 |  |
| Docs / Template | 포함 / 제외 / 확인 필요 |  |
| Hook / Guardrail | 포함 / 제외 / 확인 필요 |  |
| Quality Gate | 포함 / 제외 / 확인 필요 |  |
| Audit Trail | 포함 / 제외 / 확인 필요 |  |

## 6. 제외 범위

이번 Pilot에서 수행하지 않을 작업을 명확히 작성한다.

예:

    DB Schema 변경 제외
    운영 배포 제외
    Kubernetes 운영 Namespace 변경 제외
    Secret 조회 제외
    SigNoz EE 영역 수정 제외

## 7. HarnessOps 적용 흐름

| 단계 | 적용 여부 | 산출물 |
|---|---|---|
| Requirements Collector | 적용 / 미적용 |  |
| Spec Request | 적용 / 미적용 |  |
| Search-First Analysis | 적용 / 미적용 |  |
| Change Plan | 적용 / 미적용 |  |
| Vibe Coding Implementation | 적용 / 미적용 |  |
| Implementation Validation | 적용 / 미적용 |  |
| Quality Gate | 적용 / 미적용 |  |
| Change History | 적용 / 미적용 |  |
| Tool Usage Audit | 적용 / 미적용 |  |
| HookOps Runtime Audit | 적용 / 미적용 |  |

## 8. 검증 기준

| 번호 | 검증 항목 | 검증 방법 |
|---|---|---|
| 1 | 기능 요구사항 충족 |  |
| 2 | 변경 범위 준수 |  |
| 3 | 기존 기능 영향 없음 |  |
| 4 | 테스트 또는 빌드 확인 |  |
| 5 | 민감 정보 포함 없음 |  |
| 6 | Hook 차단 또는 로그 확인 |  |
| 7 | Quality Gate 결과 기록 |  |
| 8 | Change History 작성 |  |

## 9. 위험도 평가

| 위험 항목 | 수준 | 대응 |
|---|---|---|
| 기능 영향 | High / Medium / Low |  |
| 보안 영향 | High / Medium / Low |  |
| 배포 영향 | High / Medium / Low |  |
| 테스트 난이도 | High / Medium / Low |  |
| SigNoz Upstream 충돌 가능성 | High / Medium / Low |  |
| Hook 차단 가능성 | High / Medium / Low |  |

## 10. 최종 판단

| 항목 | 내용 |
|---|---|
| 후보 적합 여부 | 적합 / 조건부 적합 / 부적합 |
| 선정 사유 |  |
| 보류 사유 |  |
| 다음 단계 | 23단계 Spec 정리 / 보류 / 제외 |