---
name: OpenManager Implementation Validation
description: OpenManager 구현 완료 후 변경 범위, 문법, 테스트, 빌드, 보안 확인, 단계 전용 점검 결과를 정리할 때 사용한다.
when_to_use: OpenManager 변경 작업 후 Commit 전에 구현 검증 결과를 정리해야 할 때 사용한다.
disable-model-invocation: true
allowed-tools: Read Grep Glob Bash
---

# OpenManager Implementation Validation Skill

## 목적

OpenManager 변경 작업이 완료된 뒤, Commit 전에 구현 검증 결과를 정리한다.

이 Skill은 구현을 수행하지 않고, 구현된 결과가 요청 범위와 품질 기준을 만족하는지 확인하는 데 사용한다.

## 사용 방식

사용자가 다음과 같이 직접 호출한다.

```text
/om-implementation-validation 방금 구현한 변경사항의 검증 결과를 정리해 주세요.
```

```text
/om-implementation-validation 12단계 변경사항 기준으로 구현 검증 결과를 작성해 주세요.
```

```text
/om-implementation-validation backend 변경 후 테스트와 보안 확인 결과를 정리해 주세요.
```

## 참조 Workflow 및 Template

| 구분 | 경로 |
|---|---|
| Implementation Validation Workflow | `docs/harness/workflows/implementation-validation-workflow.md` |
| Implementation Validation Template | `docs/harness/templates/implementation-validation-template.md` |
| Quality Gate Workflow | `docs/harness/workflows/quality-gate-workflow.md` |
| Quality Gate Result Template | `docs/harness/templates/quality-gate-result-template.md` |

## 수행 절차

1. 변경 파일 목록을 확인한다.
2. 변경 유형을 분류한다.
3. 적용 Rule을 확인한다.
4. 관련 Agent를 확인한다.
5. 문법 검증 필요 여부를 판단한다.
6. 테스트 또는 빌드 검증 필요 여부를 판단한다.
7. 단계 전용 점검 스크립트 실행 여부를 확인한다.
8. 민감 파일 또는 Secret 포함 여부를 확인한다.
9. 기존 SigNoz Playwright Agent 보존 여부를 확인한다.
10. Quality Gate 진행 가능 여부를 판단한다.

## 변경 유형 분류 기준

| 변경 유형 | 판단 기준 |
|---|---|
| Backend Go | Go API, service, query, model, storage 변경 |
| Frontend React | UI, component, route, state, API client 변경 |
| OTel Pipeline | collector, receiver, processor, exporter, ClickHouse 변경 |
| Deploy Kubernetes | Docker, Kubernetes, Helm, values, manifest 변경 |
| Harness | `.claude`, `docs/harness`, Rule, Skill, Agent, Hook, Workflow 변경 |
| Docs | 문서 또는 템플릿 변경 |
| Security / Quality | Secret, 권한, 품질 게이트, 검증 기준 변경 |

## 검증 기준

### 공통 검증

| 항목 | 확인 기준 |
|---|---|
| 변경 파일 | 요청 범위와 일치하는지 확인 |
| 변경 통계 | 변경량이 과도하지 않은지 확인 |
| 민감 파일 | `.env`, key, pem, 개인 설정 파일 포함 여부 확인 |
| Secret 문자열 | token, password, api key 등 포함 여부 확인 |
| 기존 Agent | SigNoz Playwright Agent 미수정 확인 |
| 단계 점검 | 현재 단계 전용 점검 스크립트만 실행 |

### Backend Go 검증

| 항목 | 확인 기준 |
|---|---|
| API 영향 | request / response 변경 여부 |
| Service 영향 | 기존 책임과 충돌 여부 |
| Query 영향 | ClickHouse query, aggregation 영향 |
| Error 처리 | context, timeout, logging 기준 |
| Test | 가능한 범위에서 대상 package 테스트 |

### Frontend React 검증

| 항목 | 확인 기준 |
|---|---|
| UI 영향 | 화면, route, component 변경 영향 |
| API 연동 | loading, error, empty data 처리 |
| State 영향 | local state, global state, URL query 영향 |
| Build | 가능한 범위에서 build 또는 type check |
| UX | 대량 데이터, filter, chart, table 영향 |

### OTel Pipeline 검증

| 항목 | 확인 기준 |
|---|---|
| Receiver | 수집 대상과 protocol 영향 |
| Processor | attribute, filtering, sampling 영향 |
| Exporter | ClickHouse 저장 흐름 영향 |
| Cardinality | label, attribute 증가 위험 |
| Storage | table, view, retention 영향 |

### Deploy Kubernetes 검증

| 항목 | 확인 기준 |
|---|---|
| YAML | 문법과 구조 확인 |
| Helm | values, template 영향 확인 |
| Secret | 원문 조회 없이 영향만 확인 |
| Rollback | 원복 가능성 확인 |
| 운영 영향 | namespace, service, ingress, pvc 영향 |

## 권장 확인 명령

필요한 경우 아래 명령을 사용한다.

```text
git status --short
git diff --name-only
git diff --stat
git diff --cached --name-only
```

민감 파일 확인에는 아래 기준을 사용한다.

```text
git status --short | grep -E 'settings.local.json|\.env|\.pem|\.key|\.p12|\.pfx|id_rsa|id_ed25519|\.kube|\.aws|\.ssh|claude.json' || true
```

Stage 이후에는 아래 기준을 사용한다.

```text
git diff --cached --name-only | grep -E 'settings.local.json|\.env|\.pem|\.key|\.p12|\.pfx|id_rsa|id_ed25519|\.kube|\.aws|\.ssh|claude.json' || true
```

## 출력 형식

```text
OpenManager 구현 검증 결과

1. 변경 요약
-

2. 변경 파일
- 생성:
- 수정:
- 삭제:
- 제외:

3. 변경 유형
- Backend:
- Frontend:
- OTel:
- Deploy:
- Harness:
- Docs:

4. 수행한 검증
- 문법:
- 테스트:
- 빌드:
- 수동 확인:
- 단계 전용 점검 스크립트:

5. 검증 결과
- PASS:
- WARN:
- FAIL:

6. 보안 확인
- 민감 파일 포함 여부:
- Secret 유사 문자열:
- 개인 설정 파일 포함 여부:

7. 기존 SigNoz 보존 확인
- Playwright Agent:
- upstream 영향:

8. Quality Gate 진행 가능 여부
- 가능 / 불가

9. 추가 조치 필요 사항
-
```

## 금지 사항

- 검증 없이 Commit을 제안하지 않는다.
- FAIL이 있는 상태에서 Commit을 권장하지 않는다.
- 민감 파일 또는 Secret이 포함된 상태에서 Commit을 권장하지 않는다.
- 운영 명령을 실행하지 않는다.
- Secret, `.env`, key, pem, 개인 설정 파일을 읽지 않는다.
- 기존 SigNoz Playwright Agent를 수정하지 않는다.
- 통합 점검 스크립트를 작성하지 않는다.