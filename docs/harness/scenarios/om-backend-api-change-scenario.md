# OpenManager Backend API 변경 시나리오

## 시나리오 목적

Backend API 변경 요청이 들어왔을 때 Claude Code 하네스가 다음 흐름을 올바르게 적용하는지 검증한다.

```text
Spec 정리
→ Search-First 분석
→ Change Plan
→ Backend Go Agent 검토
→ 구현 검증
→ Quality Gate
→ Change History
→ Tool Usage Audit
```

## 사용자 요청 예시

```text
OpenManager 대시보드에서 서비스별 오류율을 조회할 수 있도록 Backend API 응답에 errorRate 필드를 추가해 주세요.
기존 API 구조를 먼저 확인하고 영향 범위를 분석한 뒤 변경 계획을 작성해 주세요.
```

## 요청 유형

| 요청 유형 | 해당 여부 | 판단 근거 |
|---|---:|---|
| Backend Go | 예 | API 응답 필드와 service/query 로직 영향 가능 |
| Frontend React | 선택 | 화면 표시가 함께 필요할 수 있음 |
| OTel Pipeline | 아니오 | 수집 파이프라인 변경 요청은 아님 |
| ClickHouse | 선택 | 오류율 계산 query 영향 가능 |
| Deploy Kubernetes | 아니오 | 배포 설정 변경 요청은 아님 |
| Harness | 아니오 | 하네스 자체 변경 요청은 아님 |
| Security / Quality | 예 | API 응답 변경에 따른 검증 필요 |
| Architecture | 예 | 기존 API 구조와 upstream 경계 확인 필요 |

## 적용 Rule

### 공통 Rule

| Rule | 적용 여부 | 사유 |
|---|---:|---|
| `.claude/rules/om/architecture.md` | 예 | API 구조와 모듈 책임 확인 |
| `.claude/rules/om/upstream-boundary.md` | 예 | SigNoz 원본 구조 훼손 방지 |
| `.claude/rules/om/security-policy.md` | 예 | 민감 정보 노출 방지 |
| `.claude/rules/om/quality-gate.md` | 예 | 테스트와 검증 기준 적용 |

### 경로별 Rule

| Rule | 적용 여부 | 사유 |
|---|---:|---|
| `.claude/rules/om/backend-go.md` | 예 | Backend Go 변경 기준 적용 |
| `.claude/rules/om/frontend-react.md` | 선택 | Frontend 표시 변경이 포함될 경우 적용 |
| `.claude/rules/om/otel-pipeline.md` | 아니오 | Pipeline 변경 요청 아님 |
| `.claude/rules/om/deploy-kubernetes.md` | 아니오 | 배포 설정 변경 요청 아님 |

## 관련 Skill

| Skill | 적용 여부 | 사용 목적 |
|---|---:|---|
| `om-spec-request` | 예 | API 변경 목적, 입력, 출력, 제외 대상 정리 |
| `om-search-first-analysis` | 예 | 기존 API, service, query 위치 검색 |
| `om-change-plan` | 예 | 변경 대상 파일과 검증 계획 작성 |
| `om-change-risk-review` | 예 | API 영향과 query 영향 검토 |
| `om-validation-plan` | 예 | 테스트와 수동 확인 기준 작성 |
| `om-implementation-validation` | 예 | 구현 후 검증 결과 정리 |
| `om-quality-gate` | 예 | Commit 전 품질 확인 |
| `om-change-history` | 예 | 변경 이력 기록 |
| `om-tool-audit` | 선택 | Tool 사용 로그 확인 |

## 관련 Agent

| Agent | 적용 여부 | 사용 목적 |
|---|---:|---|
| `om-backend-go-reviewer` | 예 | Go API, service, query 변경 검토 |
| `om-architecture-reviewer` | 예 | 구조와 upstream 경계 검토 |
| `om-security-quality-reviewer` | 예 | 보안과 품질 기준 검토 |
| `om-frontend-react-reviewer` | 선택 | 화면 변경이 함께 포함될 경우 검토 |

## Search-First 확인 항목

| 확인 항목 | 설명 |
|---|---|
| 기존 API route | 요청과 관련된 API endpoint 위치 확인 |
| handler / controller | 응답 생성 위치 확인 |
| service layer | 오류율 계산 또는 집계 책임 확인 |
| query layer | ClickHouse query 영향 확인 |
| response model | 응답 구조 변경 영향 확인 |
| test file | 기존 테스트 또는 검증 방법 확인 |

## Change Plan 확인 항목

| 항목 | 확인 내용 |
|---|---|
| 생성 파일 | 새 model, test, 문서가 필요한지 확인 |
| 수정 파일 | API, service, query, response DTO 변경 대상 |
| 제외 파일 | Frontend 또는 deploy가 제외 대상인지 명시 |
| 위험도 | API 호환성, query 성능, upstream 충돌 가능성 |
| 검증 계획 | go test, API 응답 확인, 수동 확인 기준 |

## 구현 검증 기준

| 검증 항목 | 기준 |
|---|---|
| Go 문법 | 변경 대상 package 기준 문법 오류 없음 |
| API 응답 | 기존 필드가 유지되고 신규 필드가 의도대로 추가됨 |
| Error handling | 오류율 계산 불가 시 처리 기준 확인 |
| Query 영향 | ClickHouse query 성능과 정확성 확인 |
| Test | 가능한 범위에서 대상 package test |
| 문서 | API 변경 내용이 필요 시 문서화됨 |

## Quality Gate 기준

| Gate | 확인 내용 |
|---|---|
| 변경 범위 | Backend 관련 파일 중심인지 확인 |
| 민감 파일 | Secret, `.env`, 개인 설정 미포함 |
| 기존 Agent | SigNoz Playwright Agent 미수정 |
| Stage 파일 | 현재 변경 대상만 포함 |
| Commit 메시지 | Backend API 변경 목적 포함 |

## 승인 필요 항목

| 항목 | 승인 필요 여부 | 사유 |
|---|---:|---|
| API 응답 구조 변경 | 필요 | 기존 Frontend 또는 외부 연동 영향 가능 |
| ClickHouse query 변경 | 필요 | 성능과 정확성 영향 가능 |
| DB schema 변경 | 필요 | 저장 구조 변경 시 영향 큼 |
| 배포 적용 | 필요 | 운영 반영은 별도 승인 필요 |

## 시나리오 검증 결과 기준

| 항목 | 기대 결과 |
|---|---|
| 요청 유형 분류 | Backend Go 중심으로 분류 |
| Rule 선택 | backend-go, architecture, upstream, security, quality 적용 |
| Agent 선택 | backend-go-reviewer 중심 |
| Workflow 흐름 | Spec → Search-First → Change Plan → Validation → Quality Gate |
| 위험 작업 | 실제 변경 또는 배포 없이 승인 필요 항목으로만 기록 |