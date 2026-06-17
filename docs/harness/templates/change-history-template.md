# OpenManager Change History 템플릿

## 1. 변경 이력 개요

| 항목 | 내용 |
|---|---|
| 변경 ID |  |
| 변경 일자 |  |
| 작업자 |  |
| 대상 브랜치 | `feature/om-harness-bootstrap` |
| 작업 단계 |  |
| 작업 상태 | 진행 / 완료 / 보류 |
| Commit 여부 | 예 / 아니오 |
| Push 여부 | 예 / 아니오 |

## 2. 사용자 요청 요약

```text
사용자의 요청을 한 문장으로 요약한다.
```

## 3. 작업 유형

| 작업 유형 | 해당 여부 | 비고 |
|---|---:|---|
| Backend Go |  |  |
| Frontend React |  |  |
| OTel Pipeline |  |  |
| ClickHouse |  |  |
| Docker / Kubernetes / Helm |  |  |
| Harness |  |  |
| Rule |  |  |
| Skill |  |  |
| Agent |  |  |
| Hook / Guardrail |  |  |
| Workflow |  |  |
| Template |  |  |
| 문서 |  |  |

## 4. 관련 사전 절차

| 절차 | 수행 여부 | 결과 또는 참조 |
|---|---:|---|
| Spec 기반 요청 정리 |  |  |
| Search-First 분석 |  |  |
| Change Plan 작성 |  |  |
| 사용자 승인 |  |  |
| 구현 검증 |  |  |
| Quality Gate |  |  |
| Tool Usage Audit |  |  |

## 5. 변경 대상 파일

### 생성 파일

| 파일 | 설명 |
|---|---|
|  |  |

### 수정 파일

| 파일 | 설명 |
|---|---|
|  |  |

### 삭제 파일

| 파일 | 설명 |
|---|---|
|  |  |

### 변경 제외 파일

| 파일 | 제외 사유 |
|---|---|
|  |  |

## 6. 적용 기준

### 적용 Rule

| Rule | 적용 여부 | 비고 |
|---|---:|---|
| `.claude/rules/om/architecture.md` |  |  |
| `.claude/rules/om/upstream-boundary.md` |  |  |
| `.claude/rules/om/security-policy.md` |  |  |
| `.claude/rules/om/quality-gate.md` |  |  |
| `.claude/rules/om/backend-go.md` |  |  |
| `.claude/rules/om/frontend-react.md` |  |  |
| `.claude/rules/om/otel-pipeline.md` |  |  |
| `.claude/rules/om/deploy-kubernetes.md` |  |  |

### 관련 Skill

| Skill | 사용 여부 | 목적 |
|---|---:|---|
| `om-project-context` |  | 프로젝트 기준 확인 |
| `om-rule-router` |  | Rule 선택 |
| `om-spec-request` |  | Spec 요청 정리 |
| `om-search-first-analysis` |  | 기존 구현 검색 |
| `om-change-plan` |  | 변경 계획 작성 |
| `om-implementation-validation` |  | 구현 검증 |
| `om-quality-gate` |  | Commit 전 품질 점검 |
| `om-change-history` |  | 변경 이력 기록 |
| `om-tool-audit` |  | Tool 사용 감사 |

### 관련 Agent

| Agent | 사용 여부 | 목적 |
|---|---:|---|
| `om-architecture-reviewer` |  | 구조와 upstream 경계 검토 |
| `om-backend-go-reviewer` |  | Backend Go 검토 |
| `om-frontend-react-reviewer` |  | Frontend React 검토 |
| `om-otel-pipeline-reviewer` |  | OTel Pipeline 검토 |
| `om-deploy-kubernetes-reviewer` |  | Deploy Kubernetes 검토 |
| `om-security-quality-reviewer` |  | 보안과 품질 검토 |

## 7. 구현 및 변경 내용

```text
구현 또는 변경 내용을 요약한다.
```

### 파일별 변경 내용

| 파일 | 변경 방식 | 변경 내용 | 영향도 |
|---|---|---|---|
|  | 생성 / 수정 / 삭제 / 제외 |  | 낮음 / 보통 / 높음 |

## 8. 검증 결과

### Implementation Validation 결과

| 항목 | 결과 | 비고 |
|---|---|---|
| 변경 범위 확인 | PASS / WARN / FAIL |  |
| 문법 확인 | PASS / WARN / FAIL |  |
| 테스트 | PASS / WARN / FAIL / N/A |  |
| 빌드 | PASS / WARN / FAIL / N/A |  |
| 수동 확인 | PASS / WARN / FAIL / N/A |  |
| 단계 전용 점검 스크립트 | PASS / WARN / FAIL |  |

### Quality Gate 결과

| Gate | 항목 | 결과 | 비고 |
|---|---|---|---|
| Gate 1 | 변경 범위 확인 | PASS / WARN / FAIL |  |
| Gate 2 | 민감 파일 확인 | PASS / WARN / FAIL |  |
| Gate 3 | 단계 전용 점검 확인 | PASS / WARN / FAIL |  |
| Gate 4 | 기존 Agent 보존 확인 | PASS / WARN / FAIL |  |
| Gate 5 | Stage 파일 확인 | PASS / WARN / FAIL |  |
| Gate 6 | Commit 메시지 확인 | PASS / WARN / FAIL |  |
| Gate 7 | Push 전 확인 | PASS / WARN / FAIL / N/A |  |

## 9. 보안 확인

| 항목 | 결과 | 비고 |
|---|---|---|
| `.env` 포함 여부 | 포함 / 미포함 |  |
| `.pem`, `.key` 포함 여부 | 포함 / 미포함 |  |
| `settings.local.json` 포함 여부 | 포함 / 미포함 |  |
| Secret 유사 문자열 포함 여부 | 있음 / 없음 |  |
| 인증 정보 포함 여부 | 있음 / 없음 |  |
| 개인 설정 파일 포함 여부 | 있음 / 없음 |  |
| Secret 원문 기록 여부 | 예 / 아니오 |  |

## 10. 기존 SigNoz 구조 보존 확인

| 항목 | 결과 | 비고 |
|---|---|---|
| 기존 Playwright Agent 미수정 | 예 / 아니오 |  |
| SigNoz upstream 구조 영향 | 있음 / 없음 |  |
| 기존 기능 영향 | 있음 / 없음 |  |
| 기존 테스트 영향 | 있음 / 없음 |  |

## 11. Tool 사용 로그

| 항목 | 내용 |
|---|---|
| 로그 위치 | `.claude/logs/tool-usage.log` |
| 로그 존재 여부 | 있음 / 없음 |
| 확인 시간대 |  |
| 위험 명령 여부 | 있음 / 없음 |
| 민감 파일 접근 여부 | 있음 / 없음 |
| 운영 명령 여부 | 있음 / 없음 |
| Git 명령 여부 | 있음 / 없음 |
| 특이 사항 |  |

## 12. Git 이력

| 항목 | 내용 |
|---|---|
| Stage 여부 | 예 / 아니오 |
| Commit 여부 | 예 / 아니오 |
| Commit Hash |  |
| Commit 메시지 |  |
| Push 여부 | 예 / 아니오 |
| Push 대상 브랜치 | `feature/om-harness-bootstrap` |

## 13. 사용자 승인 및 보류 사항

| 항목 | 상태 | 내용 |
|---|---|---|
| 승인 완료 |  |  |
| 승인 필요 |  |  |
| 보류 |  |  |
| 추가 확인 필요 |  |  |

## 14. 변경 이력 최종 요약

```text
변경 작업의 시작, 분석, 구현, 검증, 감사, Git 이력을 요약한다.
Secret 원문, 인증 정보, 개인 설정 파일 내용은 기록하지 않는다.
```