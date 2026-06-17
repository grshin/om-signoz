# OpenManager Scenario Validation 템플릿

## 1. 시나리오 개요

| 항목 | 내용 |
|---|---|
| 시나리오 ID |  |
| 시나리오명 |  |
| 검증 일자 |  |
| 검증자 |  |
| 대상 브랜치 | `feature/om-harness-bootstrap` |
| 시나리오 유형 | Backend / Frontend / OTel / Deploy / Harness |
| 검증 상태 | 진행 / 완료 / 보류 |

## 2. 사용자 요청 예시

```text
대표 시나리오에서 사용할 사용자 요청 예시를 작성한다.
```

## 3. 요청 유형 분류

| 요청 유형 | 해당 여부 | 판단 근거 |
|---|---:|---|
| Backend Go |  |  |
| Frontend React |  |  |
| OTel Pipeline |  |  |
| ClickHouse |  |  |
| Docker / Kubernetes / Helm |  |  |
| Harness |  |  |
| Docs |  |  |
| Security / Quality |  |  |
| Architecture |  |  |

## 4. 적용 Rule

### 공통 Rule

| Rule | 적용 여부 | 적용 사유 |
|---|---:|---|
| `.claude/rules/om/architecture.md` |  |  |
| `.claude/rules/om/upstream-boundary.md` |  |  |
| `.claude/rules/om/security-policy.md` |  |  |
| `.claude/rules/om/quality-gate.md` |  |  |

### 경로별 Rule

| Rule | 적용 여부 | 적용 사유 |
|---|---:|---|
| `.claude/rules/om/backend-go.md` |  |  |
| `.claude/rules/om/frontend-react.md` |  |  |
| `.claude/rules/om/otel-pipeline.md` |  |  |
| `.claude/rules/om/deploy-kubernetes.md` |  |  |

## 5. 관련 Skill

| Skill | 적용 여부 | 사용 목적 |
|---|---:|---|
| `om-project-context` |  | 프로젝트 기준 확인 |
| `om-rule-router` |  | 적용 Rule 선택 |
| `om-spec-request` |  | Spec 기반 요청 정리 |
| `om-search-first-analysis` |  | 기존 구현 검색과 영향 분석 |
| `om-change-plan` |  | 구현 전 변경 계획 수립 |
| `om-change-risk-review` |  | 변경 위험 검토 |
| `om-validation-plan` |  | 검증 계획 수립 |
| `om-implementation-validation` |  | 구현 후 검증 결과 정리 |
| `om-quality-gate` |  | Commit / Push 전 품질 게이트 확인 |
| `om-change-history` |  | 변경 이력 기록 |
| `om-tool-audit` |  | Tool 사용 로그 감사 |
| `om-scenario-validation` |  | 대표 시나리오 검증 결과 정리 |

## 6. 관련 Agent

| Agent | 적용 여부 | 사용 목적 |
|---|---:|---|
| `om-architecture-reviewer` |  | 구조와 upstream 경계 검토 |
| `om-backend-go-reviewer` |  | Backend Go 변경 검토 |
| `om-frontend-react-reviewer` |  | Frontend React 변경 검토 |
| `om-otel-pipeline-reviewer` |  | OTel Pipeline 변경 검토 |
| `om-deploy-kubernetes-reviewer` |  | Deploy Kubernetes 변경 검토 |
| `om-security-quality-reviewer` |  | 보안과 품질 검토 |

## 7. Workflow 적용 흐름

| Workflow | 적용 여부 | 검증 내용 |
|---|---:|---|
| Spec 기반 요청 정리 |  | 요청 목적, 범위, 제외 대상 정리 |
| Search-First Analysis |  | 기존 구현과 영향 범위 검색 |
| Change Plan |  | 변경 대상, 위험도, 검증 계획 정리 |
| Implementation Validation |  | 구현 후 검증 항목 정리 |
| Quality Gate |  | Commit / Push 전 품질 확인 |
| Change History |  | 변경 이력 기록 |
| Tool Usage Audit |  | Tool 사용 로그와 위험 작업 확인 |

## 8. 시나리오별 변경 후보

| 구분 | 파일 또는 경로 | 변경 가능성 | 비고 |
|---|---|---:|---|
| 생성 |  | 낮음 / 보통 / 높음 |  |
| 수정 |  | 낮음 / 보통 / 높음 |  |
| 삭제 |  | 낮음 / 보통 / 높음 |  |
| 제외 |  | 낮음 / 보통 / 높음 |  |

## 9. 위험 요소 분석

| 위험 항목 | 위험도 | 내용 | 대응 |
|---|---|---|---|
| upstream 충돌 | 낮음 / 보통 / 높음 |  |  |
| 보안 위험 | 낮음 / 보통 / 높음 |  |  |
| 운영 영향 | 낮음 / 보통 / 높음 |  |  |
| 품질 검증 부족 | 낮음 / 보통 / 높음 |  |  |
| Rollback 어려움 | 낮음 / 보통 / 높음 |  |  |
| 대량 변경 | 낮음 / 보통 / 높음 |  |  |
| 민감 정보 노출 | 낮음 / 보통 / 높음 |  |  |

## 10. 사용자 승인 필요 사항

| 항목 | 승인 필요 여부 | 사유 |
|---|---:|---|
| 운영 환경 영향 |  |  |
| Kubernetes / Helm 적용 |  |  |
| Secret 또는 인증 설정 변경 |  |  |
| DB schema 또는 ClickHouse table 변경 |  |  |
| 데이터 삭제 또는 migration |  |  |
| upstream 구조 변경 |  |  |
| 대량 파일 수정 |  |  |
| Git Commit / Push |  |  |

## 11. 검증 결과

| 항목 | 결과 | 비고 |
|---|---|---|
| 요청 유형 분류 | PASS / WARN / FAIL |  |
| Rule 선택 | PASS / WARN / FAIL |  |
| Skill 선택 | PASS / WARN / FAIL |  |
| Agent 선택 | PASS / WARN / FAIL |  |
| Workflow 흐름 | PASS / WARN / FAIL |  |
| 위험 요소 식별 | PASS / WARN / FAIL |  |
| 승인 필요 항목 식별 | PASS / WARN / FAIL |  |
| 금지 작업 미실행 | PASS / WARN / FAIL |  |

## 12. 보완 필요 사항

| 항목 | 보완 내용 | 우선순위 |
|---|---|---|
|  |  | 낮음 / 보통 / 높음 |

## 13. 최종 검증 요약

```text
대표 시나리오 검증 결과를 요약한다.
실제 소스 변경이나 운영 명령은 수행하지 않는다.
위험 작업은 승인 필요 항목으로만 기록한다.
```