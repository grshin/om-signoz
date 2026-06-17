# OpenManager 구현 검증 결과 템플릿

## 1. 변경 요약

```text
이번 구현 또는 변경 내용을 한 문장으로 요약한다.
```

## 2. 변경 파일

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

## 3. 변경 유형

| 변경 유형 | 해당 여부 | 비고 |
|---|---:|---|
| Backend Go |  |  |
| Frontend React |  |  |
| OTel Pipeline |  |  |
| ClickHouse |  |  |
| Docker / Kubernetes / Helm |  |  |
| Harness 문서 |  |  |
| Rule |  |  |
| Skill |  |  |
| Agent |  |  |
| Hook / Guardrail |  |  |
| 기타 문서 |  |  |

## 4. 적용 Rule 확인

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

## 5. 수행한 검증

| 검증 구분 | 실행 여부 | 명령 또는 방법 | 결과 |
|---|---:|---|---|
| 변경 파일 확인 |  | `git status --short` |  |
| 변경 경로 확인 |  | `git diff --name-only` |  |
| 변경 통계 확인 |  | `git diff --stat` |  |
| 문법 확인 |  |  |  |
| 테스트 |  |  |  |
| 빌드 |  |  |  |
| 수동 확인 |  |  |  |
| 단계 전용 점검 스크립트 |  |  |  |
| 민감 파일 포함 여부 |  |  |  |
| 기존 Agent 보존 여부 |  |  |  |

## 6. 검증 결과 요약

| 결과 | 내용 |
|---|---|
| PASS |  |
| WARN |  |
| FAIL |  |

## 7. 보안 확인

| 항목 | 결과 | 비고 |
|---|---|---|
| `.env` 포함 여부 |  |  |
| `.pem`, `.key` 포함 여부 |  |  |
| `settings.local.json` 포함 여부 |  |  |
| Secret 유사 문자열 포함 여부 |  |  |
| 인증 정보 포함 여부 |  |  |
| 개인 설정 파일 포함 여부 |  |  |
| 운영 Secret 조회 여부 |  |  |

## 8. 기존 SigNoz 보존 확인

| 항목 | 결과 | 비고 |
|---|---|---|
| 기존 Playwright Agent 미수정 |  |  |
| SigNoz upstream 구조 영향 |  |  |
| 기존 기능 영향 |  |  |
| 기존 테스트 영향 |  |  |

## 9. 변경 영역별 상세 검증

### Backend Go

```text
- API 영향:
- Service 영향:
- Query / Storage 영향:
- Error handling:
- Test 결과:
```

### Frontend React

```text
- UI 영향:
- Component 영향:
- State 영향:
- API 연동 영향:
- Build / Lint 결과:
```

### OTel Pipeline

```text
- Receiver 영향:
- Processor 영향:
- Exporter 영향:
- ClickHouse 영향:
- Cardinality 위험:
```

### Deploy Kubernetes

```text
- Docker 영향:
- Helm 영향:
- Manifest 영향:
- Secret 영향:
- Rollback 가능성:
```

### Harness

```text
- Rule 영향:
- Skill 영향:
- Agent 영향:
- Hook 영향:
- Workflow 영향:
```

## 10. 추가 조치 필요 사항

| 항목 | 조치 내용 | 우선순위 |
|---|---|---|
|  |  | 낮음 / 보통 / 높음 |

## 11. Quality Gate 진행 가능 여부

| 항목 | 판단 |
|---|---|
| Quality Gate 진행 가능 여부 | 가능 / 불가 |
| 사유 |  |
| 선행 조치 |  |

## 12. 검증 결과 최종 요약

```text
구현 검증 결과를 요약한다.
FAIL이 있으면 Commit 전에 수정한다.
WARN이 있으면 사유를 확인하고 진행 여부를 판단한다.
```