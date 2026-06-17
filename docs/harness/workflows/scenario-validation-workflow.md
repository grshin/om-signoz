# OpenManager Scenario Validation Workflow

## 문서 목적

본 문서는 OpenManager Claude Code 하네스가 대표 변경 시나리오에서 정상적으로 동작하는지 검증하는 절차를 정의한다.

Scenario Validation은 다음 원칙을 따른다.

- 실제 운영 변경은 수행하지 않는다.
- 위험 명령은 실행하지 않고 시나리오 기준으로만 검토한다.
- 변경 요청 흐름이 Spec, Search-First, Change Plan, Validation, Quality Gate, Audit Trail로 이어지는지 확인한다.
- 각 시나리오별로 적용 Rule, Skill, Agent, Workflow가 적절히 선택되는지 확인한다.
- 기존 SigNoz Playwright Agent와 기존 Hook 파일은 수정하지 않는다.
- 통합 점검 스크립트는 작성하지 않는다.

## 적용 대상

이 Workflow는 다음 대표 시나리오 검증에 적용한다.

| 시나리오 | 적용 여부 |
|---|---:|
| Backend API 변경 | 적용 |
| Frontend Dashboard 변경 | 적용 |
| OTel Pipeline 변경 | 적용 |
| Kubernetes 배포 변경 | 적용 |
| Harness 자체 변경 | 적용 |
| 실제 운영 배포 | 미적용 |
| Secret 원문 검증 | 미적용 |

## 기본 수행 순서

| 순서 | 작업 | 목적 |
|---:|---|---|
| 1 | 대표 시나리오 선택 | 검증할 변경 요청 유형 선택 |
| 2 | 사용자 요청 예시 확인 | 실제 작업 요청처럼 입력 문장 확인 |
| 3 | Spec 필요 여부 판단 | 10단계 Spec 기반 요청 흐름 적용 여부 확인 |
| 4 | Search-First 필요 여부 판단 | 11단계 사전 검색 분석 적용 여부 확인 |
| 5 | Change Plan 필요 여부 판단 | 변경 계획 작성 필요 여부 확인 |
| 6 | 적용 Rule 확인 | 공통 Rule과 경로별 Rule 선택 |
| 7 | 관련 Skill 확인 | 수동 호출 Skill 선택 |
| 8 | 관련 Agent 확인 | 검토에 사용할 전문 Agent 선택 |
| 9 | 구현 검증 기준 확인 | 12단계 Implementation Validation 적용 기준 확인 |
| 10 | Quality Gate 기준 확인 | Commit / Push 전 품질 기준 확인 |
| 11 | Audit Trail 기준 확인 | 13단계 변경 이력과 Tool 감사 기준 확인 |
| 12 | 시나리오 검증 결과 기록 | 검증 템플릿에 결과 정리 |

## 대표 시나리오 목록

| 시나리오 파일 | 목적 |
|---|---|
| `docs/harness/scenarios/om-backend-api-change-scenario.md` | Backend API 변경 흐름 검증 |
| `docs/harness/scenarios/om-frontend-dashboard-change-scenario.md` | Frontend Dashboard 변경 흐름 검증 |
| `docs/harness/scenarios/om-otel-pipeline-change-scenario.md` | OTel Pipeline 변경 흐름 검증 |
| `docs/harness/scenarios/om-deploy-kubernetes-change-scenario.md` | Kubernetes 배포 변경 흐름 검증 |
| `docs/harness/scenarios/om-harness-change-scenario.md` | 하네스 자체 변경 흐름 검증 |

## 시나리오별 검증 관점

### Backend API 변경 시나리오

| 검증 항목 | 확인 내용 |
|---|---|
| 적용 Rule | `architecture.md`, `upstream-boundary.md`, `backend-go.md`, `security-policy.md`, `quality-gate.md` |
| 관련 Agent | `om-backend-go-reviewer`, `om-architecture-reviewer`, `om-security-quality-reviewer` |
| 관련 Skill | `om-spec-request`, `om-search-first-analysis`, `om-change-plan`, `om-implementation-validation`, `om-quality-gate` |
| 주요 검증 | API 영향, query 영향, error handling, test 계획 |
| 금지 사항 | 기존 API를 근거 없이 변경하거나 upstream 구조를 훼손하지 않음 |

### Frontend Dashboard 변경 시나리오

| 검증 항목 | 확인 내용 |
|---|---|
| 적용 Rule | `architecture.md`, `frontend-react.md`, `security-policy.md`, `quality-gate.md` |
| 관련 Agent | `om-frontend-react-reviewer`, `om-architecture-reviewer`, `om-security-quality-reviewer` |
| 관련 Skill | `om-spec-request`, `om-search-first-analysis`, `om-change-plan`, `om-implementation-validation`, `om-quality-gate` |
| 주요 검증 | UI 영향, component 영향, route 영향, API 연동 영향 |
| 금지 사항 | 기존 UX와 데이터 흐름을 분석하지 않고 수정하지 않음 |

### OTel Pipeline 변경 시나리오

| 검증 항목 | 확인 내용 |
|---|---|
| 적용 Rule | `architecture.md`, `otel-pipeline.md`, `upstream-boundary.md`, `security-policy.md`, `quality-gate.md` |
| 관련 Agent | `om-otel-pipeline-reviewer`, `om-architecture-reviewer`, `om-security-quality-reviewer` |
| 관련 Skill | `om-search-first-analysis`, `om-change-plan`, `om-change-risk-review`, `om-validation-plan`, `om-quality-gate` |
| 주요 검증 | receiver, processor, exporter, ClickHouse, cardinality 영향 |
| 금지 사항 | cardinality 위험과 저장소 영향을 분석하지 않고 변경하지 않음 |

### Kubernetes 배포 변경 시나리오

| 검증 항목 | 확인 내용 |
|---|---|
| 적용 Rule | `architecture.md`, `deploy-kubernetes.md`, `security-policy.md`, `quality-gate.md` |
| 관련 Agent | `om-deploy-kubernetes-reviewer`, `om-security-quality-reviewer`, `om-architecture-reviewer` |
| 관련 Skill | `om-search-first-analysis`, `om-change-plan`, `om-implementation-validation`, `om-quality-gate`, `om-tool-audit` |
| 주요 검증 | values, manifest, secret 영향, rollback 가능성, 운영 승인 필요 여부 |
| 금지 사항 | 사용자 승인 없이 `kubectl apply`, `helm upgrade`, `kubectl delete`를 실행하지 않음 |

### Harness 변경 시나리오

| 검증 항목 | 확인 내용 |
|---|---|
| 적용 Rule | `architecture.md`, `upstream-boundary.md`, `security-policy.md`, `quality-gate.md` |
| 관련 Agent | `om-architecture-reviewer`, `om-security-quality-reviewer` |
| 관련 Skill | `om-change-plan`, `om-implementation-validation`, `om-quality-gate`, `om-change-history`, `om-tool-audit` |
| 주요 검증 | Rule, Skill, Agent, Workflow, Hook 영향 |
| 금지 사항 | 기존 SigNoz Playwright Agent와 기존 Hook 파일을 임의 수정하지 않음 |

## 검증 기준

각 시나리오는 다음 기준으로 검증한다.

| 기준 | 통과 조건 |
|---|---|
| 요청 유형 분류 | Backend, Frontend, OTel, Deploy, Harness 중 하나 이상으로 분류됨 |
| Rule 선택 | 공통 Rule과 경로별 Rule이 적절히 선택됨 |
| Skill 선택 | 요청 흐름에 맞는 Skill이 선택됨 |
| Agent 선택 | 검토 대상에 맞는 Agent가 선택됨 |
| Search-First | 기존 구현 검색 필요 여부가 판단됨 |
| Change Plan | 변경 계획 필요 여부가 판단됨 |
| Validation | 구현 후 검증 항목이 정의됨 |
| Quality Gate | Commit / Push 전 확인 항목이 정의됨 |
| Audit Trail | 변경 이력과 Tool 사용 감사 항목이 정의됨 |
| 위험 작업 | 실제 실행하지 않고 승인 필요 항목으로 분류됨 |

## 시나리오 검증 출력 형식

Claude Code는 시나리오 검증 결과를 아래 형식으로 정리한다.

```text
OpenManager Scenario Validation 결과

1. 시나리오명
-

2. 사용자 요청 예시
-

3. 요청 유형
- Backend:
- Frontend:
- OTel:
- Deploy:
- Harness:
- Docs:

4. 적용 Rule
- 공통 Rule:
- 경로별 Rule:

5. 관련 Skill
- Spec:
- Search-First:
- Change Plan:
- Validation:
- Quality Gate:
- Audit:

6. 관련 Agent
-

7. Workflow 적용 흐름
- Spec:
- Search-First:
- Change Plan:
- Implementation Validation:
- Quality Gate:
- Change History:
- Tool Usage Audit:

8. 위험 요소
- upstream:
- security:
- operation:
- quality:
- rollback:

9. 사용자 승인 필요 사항
-

10. 시나리오 검증 결과
- PASS:
- WARN:
- FAIL:
- 보완 필요 사항:
```

## 금지 사항

- 실제 소스 변경을 수행하지 않는다.
- 실제 배포 명령을 실행하지 않는다.
- Secret 원문을 조회하지 않는다.
- `.env`, key, pem, 개인 설정 파일을 읽지 않는다.
- 사용자 승인 없이 Git Commit 또는 Push를 실행하지 않는다.
- 기존 SigNoz Playwright Agent를 수정하지 않는다.
- 기존 Hook 파일을 수정하지 않는다.
- 통합 점검 스크립트를 작성하지 않는다.