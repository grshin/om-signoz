# HarnessOps Vibe Coding Candidate

## 1. 후보 기본 정보

| 항목 | 내용 |
|---|---|
| 후보 ID | OM-VIBE-001 |
| 후보명 | OTel Collector OpenManager 설정 Template 보강 |
| 관련 요구사항 ID | OM-REQ-001 |
| 관련 SigNoz 기능 | OTel Collector, Deploy / Helm |
| 관련 OpenManager 영역 | OTel / Deploy / Docs / Harness |
| 작성일 | YYYY-MM-DD |
| 작성자 | grshin |
| 코드 수정 여부 | 22단계에서는 수정하지 않음 |

## 2. 후보 선정 배경

OpenManager는 SigNoz OSS 기반으로 Observability 기능을 활용하지만, 고객 운영환경에서는 어떤 Telemetry 데이터를 어떤 방식으로 수집할지에 대한 OpenManager 관점의 설정 Template과 설명이 필요하다.

OTel Collector 설정 Template 보강은 다음 이유로 HarnessOps 바이브 코딩 Pilot에 적합하다.

| 기준 | 판단 |
|---|---|
| 구현 단위가 작은가 | 예 |
| 운영 위험이 낮은가 | 예 |
| Search-First 분석이 가능한가 | 예 |
| Change Plan으로 범위 제한이 가능한가 | 예 |
| 검증 방법이 명확한가 | 예 |
| Hook / Quality Gate / Audit 검증에 적합한가 | 예 |
| OpenManager 가치가 있는가 | 예 |

## 3. 현재 기능 상태

SigNoz OSS는 OTel Collector 기반의 Telemetry 수집 구조를 제공한다.

다만 OpenManager 관점에서는 다음 항목을 보강할 필요가 있다.

| 항목 | 현재 상태 | 개선 필요성 |
|---|---|---|
| Collector 설정 예시 | SigNoz 기준 예시 존재 가능 | OpenManager 관제 목적별 예시 필요 |
| Receiver 설명 | 일반 설명 중심 | VM, Kubernetes, GPU, Application 관점 설명 필요 |
| Processor 설명 | 일반 설명 중심 | 운영환경 기준 데이터 처리 설명 필요 |
| Exporter 설명 | SigNoz 연계 중심 | OpenManager 수집 구조 기준 설명 필요 |
| 보안 주의사항 | 확인 필요 | Secret, Token, Endpoint 예시 처리 기준 필요 |
| 검증 방법 | 확인 필요 | 설정 문법, 민감 정보 포함 여부 확인 필요 |

## 4. 개선 요구사항

OpenManager 관점의 OTel Collector 설정 Template 문서를 추가한다.

문서에는 다음 내용을 포함한다.

| 항목 | 내용 |
|---|---|
| 수집 목적 | OpenManager 관제 대상별 Telemetry 수집 목적 |
| Receiver 예시 | hostmetrics, kubeletstats, otlp 등 후보 |
| Processor 예시 | batch, memory_limiter, resource 등 후보 |
| Exporter 예시 | otlp, clickhouse, signoz 연계 후보 |
| 운영 주의사항 | Secret, Endpoint, 운영 환경 값 처리 기준 |
| 검증 방법 | 설정 파일 구조 확인, 민감 정보 포함 여부 확인 |
| 후속 확장 | GPU, Network, VM, Kubernetes 관제별 Template 확장 |

## 5. 적용 범위

| 영역 | 포함 여부 | 설명 |
|---|---|---|
| Backend | 제외 | 코드 수정 없음 |
| Frontend | 제외 | 코드 수정 없음 |
| OTel Pipeline | 포함 | 설정 Template과 설명 작성 |
| Deploy / Helm | 조건부 포함 | values 또는 chart 연계 설명 가능 |
| Docs / Template | 포함 | 주요 구현 영역 |
| Hook / Guardrail | 포함 | Secret 유사 문자열 및 위험 명령 검증 |
| Quality Gate | 포함 | 문서, 민감 정보, 변경 범위 검증 |
| Audit Trail | 포함 | Change History와 Tool Usage Audit 작성 |

## 6. 제외 범위

이번 Pilot에서는 아래 작업을 수행하지 않는다.

| 제외 항목 | 사유 |
|---|---|
| 실제 Collector 운영 설정 변경 | 운영 영향 방지 |
| Kubernetes 운영 Namespace 적용 | 22단계 범위 아님 |
| Helm values 실제 변경 | 후속 단계에서 검토 |
| Secret / Token 원문 작성 | 보안 기준 위반 방지 |
| SigNoz Query Service 수정 | 영향 범위가 큼 |
| Frontend UI 수정 | 1차 Pilot 범위에서 제외 |
| DB Schema 변경 | 불필요 |
| EE 영역 수정 | 기존 원칙에 따라 제외 |

## 7. HarnessOps 적용 흐름

| 단계 | 적용 여부 | 산출물 |
|---|---|---|
| Requirements Collector | 적용 | om-requirements-candidates.md |
| Spec Request | 23단계 적용 | spec-request-template 기반 문서 |
| Search-First Analysis | 23단계 적용 | search-first-analysis-template 기반 문서 |
| Change Plan | 23단계 적용 | change-plan-template 기반 문서 |
| Vibe Coding Implementation | 24단계 적용 | Template / Docs 구현 |
| Implementation Validation | 25단계 적용 | validation result |
| Quality Gate | 25단계 적용 | quality gate result |
| Change History | 25단계 적용 | change history |
| Tool Usage Audit | 25단계 적용 | tool usage audit |
| HookOps Runtime Audit | 26단계 적용 | hookops runtime audit |

## 8. 검증 기준

| 번호 | 검증 항목 | 검증 방법 |
|---|---|---|
| 1 | 요구사항 충족 | 문서에 Collector 설정 Template과 설명 포함 여부 확인 |
| 2 | 변경 범위 준수 | Backend, Frontend, DB 변경 없음 확인 |
| 3 | 기존 기능 영향 없음 | 실제 소스 코드 변경 없음 또는 문서 영역만 변경 확인 |
| 4 | 민감 정보 포함 없음 | Secret, Token, Password, Endpoint 원문 포함 여부 확인 |
| 5 | Hook 동작 확인 | 민감 파일 접근 차단, 위험 명령 미사용 확인 |
| 6 | Quality Gate 결과 기록 | 25단계에서 결과 작성 |
| 7 | Change History 작성 | 25단계에서 변경 이력 작성 |
| 8 | Tool Usage Audit 작성 | 25단계에서 Tool 사용 로그 점검 |

## 9. 위험도 평가

| 위험 항목 | 수준 | 대응 |
|---|---|---|
| 기능 영향 | Low | 코드 수정 없음 |
| 보안 영향 | Low | Secret 원문 작성 금지 |
| 배포 영향 | Low | 실제 배포 명령 실행 없음 |
| 테스트 난이도 | Low | 문서 / Template 검증 중심 |
| SigNoz Upstream 충돌 가능성 | Low | OM 문서 영역 중심 |
| Hook 차단 가능성 | Low | 정상 작업은 차단되지 않아야 함 |
| 품질 검증 누락 가능성 | Medium | Quality Gate Template으로 보완 |

## 10. 최종 판단

| 항목 | 내용 |
|---|---|
| 후보 적합 여부 | 적합 |
| 선정 사유 | OpenManager 관제 수집 구조와 직접 연결되며, 작은 단위로 구현 가능하고 검증 가능성이 높음 |
| 보류 사유 | 없음 |
| 다음 단계 | 23단계 Spec 정리 |

## 11. 23단계 연결 항목

23단계에서는 이 후보를 기준으로 다음 산출물을 작성한다.

| 산출물 | 목적 |
|---|---|
| Spec Request | 요구사항, 제외 범위, Acceptance Criteria 정리 |
| Search-First Analysis | 기존 OTel Collector / Deploy / Docs 구조 확인 |
| Change Plan | 변경 파일과 검증 방법 확정 |
| Risk Review | Secret, 운영 명령, 배포 영향 검토 |