# Vibe Coding Requirements Inventory

## 1. 문서 목적

본 문서는 22단계에서 작성한 SigNoz OSS 기능 분석 및 HarnessOps 바이브 코딩 요구사항 수집 산출물을 관리하기 위한 Inventory 문서이다.

22단계는 실제 코드를 수정하지 않고, fork한 SigNoz OSS의 기능을 OpenManager 관점에서 분석한 뒤 HarnessOps 바이브 코딩 Pilot 후보를 선정하는 단계이다.

## 2. 22단계 범위

| 항목 | 내용 |
|---|---|
| 단계 | 22단계 |
| 단계명 | SigNoz OSS 기능 분석 및 HarnessOps 바이브 코딩 요구사항 수집 |
| 목적 | SigNoz OSS 기능을 분석하고 OpenManager 개선 요구사항 후보를 수집 |
| 실제 코드 수정 여부 | 수정하지 않음 |
| 배포 명령 실행 여부 | 실행하지 않음 |
| Git Push | 사용자 승인 후 수행 |
| 후속 연결 | 23단계 Spec 정리, 24단계 HarnessOps 바이브 코딩 구현, 25단계 검증 |

## 3. 22단계 주요 원칙

| 원칙 | 설명 |
|---|---|
| Requirements First | 바로 구현하지 않고 요구사항 후보를 먼저 수집한다. |
| Search-First | 기존 SigNoz OSS 기능과 파일 구조를 먼저 확인한다. |
| Small Pilot | 작은 단위의 개선 후보를 선정한다. |
| No Production Impact | 실제 운영 배포 또는 운영 설정 변경을 수행하지 않는다. |
| No Secret Exposure | Secret, Token, Password, 실제 Endpoint 원문을 작성하지 않는다. |
| No Existing Agent Modification | 기존 SigNoz Playwright Agent를 수정하지 않는다. |
| No Existing Hook Modification | 기존 Hook 파일을 수정하지 않는다. |
| Audit Ready | 이후 Change History와 Tool Usage Audit으로 연결 가능해야 한다. |

## 4. 22단계 Workflow

| 파일 | 설명 |
|---|---|
| docs/harness/workflows/harnessops-vibe-coding-requirements-workflow.md | SigNoz OSS 기능 분석부터 HarnessOps 바이브 코딩 후보 선정까지의 표준 절차 |

## 5. 22단계 Template

| 파일 | 설명 |
|---|---|
| docs/harness/templates/signoz-feature-inventory-template.md | SigNoz OSS 기능 영역을 정리하기 위한 Template |
| docs/harness/templates/om-requirement-candidate-template.md | OpenManager 개선 또는 신규 요구사항 후보를 작성하기 위한 Template |
| docs/harness/templates/harnessops-vibe-coding-candidate-template.md | HarnessOps 바이브 코딩 Pilot 후보를 선정하기 위한 Template |

## 6. 22단계 Discovery 산출물

| 파일 | 설명 |
|---|---|
| docs/harness/discovery/signoz-oss-feature-inventory.md | SigNoz OSS 주요 기능 영역을 OpenManager 관점에서 분류한 문서 |
| docs/harness/discovery/om-feature-gap-analysis.md | OpenManager 관점의 기능 Gap과 개선 방향을 정리한 문서 |
| docs/harness/discovery/om-requirements-candidates.md | 개선 요구사항 및 신규 요구사항 후보 목록 |
| docs/harness/discovery/harnessops-vibe-coding-candidate.md | 실제 HarnessOps 바이브 코딩 Pilot 후보 선정 문서 |

## 7. 22단계 점검 스크립트

| 파일 | 설명 |
|---|---|
| docs/harness/scripts/check-step22-vibe-coding-requirements.sh | 22단계 산출물만 점검하는 전용 스크립트 |

## 8. 22단계에서 활용하는 기존 Skill

| Skill | 사용 목적 |
|---|---|
| .claude/skills/om-requirements-collector/SKILL.md | SigNoz OSS 기능 분석 기반 요구사항 후보 수집 |
| .claude/skills/om-project-context/SKILL.md | OpenManager 프로젝트 기준 확인 |
| .claude/skills/om-rule-router/SKILL.md | 관련 Rule 적용 기준 확인 |
| .claude/skills/om-spec-request/SKILL.md | 후보 요구사항을 Spec 형태로 전환 |
| .claude/skills/om-search-first-analysis/SKILL.md | 기존 구현 탐색 |
| .claude/skills/om-change-plan/SKILL.md | 변경 계획 수립 |
| .claude/skills/om-validation-plan/SKILL.md | 검증 계획 작성 |
| .claude/skills/om-harness-operation/SKILL.md | 운영 적용 가능성 확인 |

## 9. 22단계 요구사항 후보

| ID | 요구사항명 | 유형 | 우선순위 | Pilot 후보 |
|---|---|---|---|---|
| OM-REQ-001 | OTel Collector OpenManager 설정 Template 보강 | 설정 / 문서 개선 | High | 예 |
| OM-REQ-002 | OpenManager 기본 Alert Rule 예시 보강 | 설정 / 문서 개선 | High | 예 |
| OM-REQ-003 | Dashboard / Alert 화면 운영자 안내 문구 보강 | UI 개선 | High | 예 |
| OM-REQ-004 | Metrics 관제 지표 설명 문서 보강 | 문서 개선 | Medium | 조건부 |
| OM-REQ-005 | Deploy / Helm values 설명 보강 | 운영 문서 개선 | Medium | 조건부 |
| OM-REQ-006 | Query Service API 응답 개선 후보 분석 | API 분석 | Low | 아니오 |
| OM-REQ-007 | Auth / RBAC 개선 후보 분석 | 보안 / 권한 분석 | Low | 아니오 |

## 10. 1차 HarnessOps 바이브 코딩 Pilot 후보

| 항목 | 내용 |
|---|---|
| 후보 ID | OM-VIBE-001 |
| 후보명 | OTel Collector OpenManager 설정 Template 보강 |
| 관련 요구사항 | OM-REQ-001 |
| 선정 사유 | 작은 단위로 구현 가능하고, 운영 위험이 낮으며, Spec / Search-First / Change Plan / Quality Gate / Audit 검증에 적합 |
| 실제 구현 단계 | 24단계 |
| Spec 정리 단계 | 23단계 |
| 검증 단계 | 25단계 |
| HookOps 실측 분석 | 26단계 |

## 11. 22단계 금지 사항

다음 작업은 22단계에서 수행하지 않는다.

    실제 코드 수정
    운영 배포 명령 실행
    kubectl apply / delete
    helm upgrade / uninstall
    docker compose down
    rm -rf
    Secret 원문 조회
    기존 SigNoz Playwright Agent 수정
    기존 Hook 파일 수정
    .claude/settings.local.json Git 추적
    대규모 리팩토링 요구사항 후보 선정

## 12. 후속 단계 연결

| 후속 단계 | 연결 내용 |
|---|---|
| 23단계 | OM-VIBE-001 후보를 Spec, Acceptance Criteria, Search-First 분석, Change Plan으로 정리 |
| 24단계 | HarnessOps 바이브 코딩 방식으로 실제 Template 또는 문서 구현 |
| 25단계 | 구현 결과 검증, Quality Gate, Change History, Tool Usage Audit 수행 |
| 26단계 | HookOps 실측 로그 분석 및 Guardrail 튜닝 |
| 27단계 | Pilot 결과 회고 및 HarnessOps 개선 백로그 작성 |

## 13. 22단계 완료 판단 기준

| 기준 | 판단 |
|---|---|
| Workflow 작성 | 완료 필요 |
| Template 3종 작성 | 완료 필요 |
| Discovery 산출물 4종 작성 | 완료 필요 |
| Pilot 후보 선정 | 완료 필요 |
| Inventory 작성 | 완료 필요 |
| 22단계 전용 점검 스크립트 작성 | 완료 필요 |
| 기존 SigNoz Playwright Agent 변경 없음 | 필수 |
| 기존 Hook 파일 변경 없음 | 필수 |
| Secret 유사 문자열 없음 | 필수 |
| 실제 소스 코드 변경 없음 | 필수 |