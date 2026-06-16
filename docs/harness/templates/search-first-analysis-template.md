# OpenManager Search-First 분석 템플릿

## 1. 요청 요약

```text
사용자의 요청을 한 문장으로 요약한다.
```

## 2. 요청 유형

| 구분 | 선택 |
|---|---:|
| Backend Go |  |
| Frontend React |  |
| OTel Pipeline |  |
| Deploy Kubernetes |  |
| Harness |  |
| Docs |  |
| Security / Quality |  |
| Architecture |  |

## 3. 적용 기준 확인

### 공통 Rule

| Rule | 확인 여부 | 비고 |
|---|---:|---|
| `.claude/rules/om/architecture.md` |  |  |
| `.claude/rules/om/upstream-boundary.md` |  |  |
| `.claude/rules/om/security-policy.md` |  |  |
| `.claude/rules/om/quality-gate.md` |  |  |

### 경로별 Rule

| Rule | 확인 여부 | 비고 |
|---|---:|---|
| `.claude/rules/om/backend-go.md` |  |  |
| `.claude/rules/om/frontend-react.md` |  |  |
| `.claude/rules/om/otel-pipeline.md` |  |  |
| `.claude/rules/om/deploy-kubernetes.md` |  |  |

## 4. 관련 Skill 및 Agent

### 관련 Skill

| Skill | 사용 목적 |
|---|---|
| `om-project-context` | 프로젝트 기준 확인 |
| `om-rule-router` | 적용 Rule 선택 |
| `om-spec-request` | Spec 기반 요청 정리 |
| `om-validation-plan` | 검증 계획 수립 |
| `om-change-risk-review` | 변경 위험 검토 |

### 관련 Agent

| Agent | 사용 목적 |
|---|---|
| `om-architecture-reviewer` | 구조와 upstream 경계 검토 |
| `om-backend-go-reviewer` | Backend Go 변경 검토 |
| `om-frontend-react-reviewer` | Frontend React 변경 검토 |
| `om-otel-pipeline-reviewer` | OTel Pipeline 변경 검토 |
| `om-deploy-kubernetes-reviewer` | Deploy Kubernetes 변경 검토 |
| `om-security-quality-reviewer` | 보안과 품질 검토 |

## 5. 검색 계획

| 검색 대상 | 검색 키워드 | 목적 |
|---|---|---|
| 요청 관련 파일 |  | 변경 후보 위치 확인 |
| `docs/harness` |  | 하네스 기준 확인 |
| `.claude/rules/om` |  | 적용 Rule 확인 |
| `.claude/skills` |  | 관련 Skill 확인 |
| `.claude/agents` |  | 관련 Agent 확인 |
| Backend 소스 |  | 기존 API, service, query 확인 |
| Frontend 소스 |  | 기존 화면, component, route 확인 |
| OTel / ClickHouse |  | 수집, 처리, 저장 흐름 확인 |
| Deploy 파일 |  | Docker, Kubernetes, Helm 영향 확인 |

## 6. 검색 명령 기록

실제로 사용한 검색 명령을 기록한다.

```text
예:
git status --short
git diff --name-only
find docs/harness -maxdepth 3 -type f | sort
find .claude -maxdepth 4 -type f | sort
rg "<검색어>" .
```

## 7. 발견한 기존 구현

| 구분 | 파일 또는 경로 | 발견 내용 |
|---|---|---|
| Backend |  |  |
| Frontend |  |  |
| OTel Pipeline |  |  |
| Deploy |  |  |
| Harness |  |  |
| Docs |  |  |

## 8. 변경 후보 파일

| 구분 | 파일 | 변경 가능성 | 비고 |
|---|---|---:|---|
| 생성 |  | 낮음 / 보통 / 높음 |  |
| 수정 |  | 낮음 / 보통 / 높음 |  |
| 삭제 |  | 낮음 / 보통 / 높음 |  |
| 제외 |  | 낮음 / 보통 / 높음 |  |

## 9. 영향 범위 분석

| 영역 | 영향 여부 | 내용 |
|---|---:|---|
| Backend |  |  |
| Frontend |  |  |
| OTel Pipeline |  |  |
| ClickHouse |  |  |
| Docker / Kubernetes / Helm |  |  |
| Security |  |  |
| Quality Gate |  |  |
| Upstream 병합 |  |  |
| 문서 |  |  |

## 10. 위험 요소

| 위험 항목 | 위험도 | 내용 | 대응 |
|---|---|---|---|
| upstream 충돌 | 낮음 / 보통 / 높음 |  |  |
| 민감 정보 노출 | 낮음 / 보통 / 높음 |  |  |
| 운영 영향 | 낮음 / 보통 / 높음 |  |  |
| 품질 검증 부족 | 낮음 / 보통 / 높음 |  |  |
| Rollback 어려움 | 낮음 / 보통 / 높음 |  |  |
| 대량 변경 | 낮음 / 보통 / 높음 |  |  |

## 11. 사용자 승인 필요 사항

```text
구현 전에 사용자 확인이 필요한 항목을 작성한다.
```

## 12. Change Plan 작성 필요 여부

| 항목 | 판단 |
|---|---|
| Change Plan 필요 여부 | 필요 / 불필요 |
| 사유 |  |

## 13. Search-First 분석 결과 요약

```text
검색 결과를 기반으로 구현 가능 여부, 변경 방향, 위험 요소를 요약한다.
```