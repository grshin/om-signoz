---
name: om-spec-request
description: OpenManager 개발 요청을 Spec 기반 템플릿으로 정리할 때 사용한다.
when_to_use: OpenManager 기능 개발, 개선, 리팩토링, OTel pipeline, backend, frontend, deploy 변경 요청을 구현 전에 구조화해야 할 때 사용한다.
disable-model-invocation: true
allowed-tools: Read Grep Glob
---

# OpenManager Spec Request Skill

## 목적

OpenManager 개발 요청을 바로 구현하지 않고, Spec 기반 요청서로 먼저 정리한다.

## 사용 방식

사용자가 다음과 같이 직접 호출한다.

```text
/om-spec-request backend API 변경 요청 정리
```

```text
/om-spec-request frontend 화면 개선 요청 정리
```

```text
/om-spec-request otel pipeline 변경 요청 정리
```

```text
/om-spec-request deploy kubernetes 변경 요청 정리
```

## 참조 템플릿

| 요청 유형 | 템플릿 |
|---|---|
| 공통 | `docs/harness/templates/spec-request-common.md` |
| Backend Go | `docs/harness/templates/spec-request-backend-go.md` |
| Frontend React | `docs/harness/templates/spec-request-frontend-react.md` |
| OTel Pipeline | `docs/harness/templates/spec-request-otel-pipeline.md` |
| Deploy Kubernetes | `docs/harness/templates/spec-request-deploy-kubernetes.md` |

## 수행 절차

1. 사용자의 요청을 한 문장으로 요약한다.
2. 요청 유형을 분류한다.
3. 적용할 템플릿을 선택한다.
4. 적용 Rule을 정리한다.
5. 관련 Skill과 Agent를 제안한다.
6. 위험 요소를 정리한다.
7. 검증 계획을 작성한다.
8. 구현 전 사용자 승인 필요 여부를 명시한다.

## 요청 유형 분류 기준

| 요청 유형 | 판단 기준 |
|---|---|
| Backend Go | API, service, query, model, Go code 변경 |
| Frontend React | UI, component, route, state, API client 변경 |
| OTel Pipeline | collector, receiver, processor, exporter, ClickHouse 흐름 변경 |
| Deploy Kubernetes | Docker, Kubernetes, Helm, values, manifest 변경 |
| Common | 여러 영역이 섞이거나 아직 범위가 불명확한 요청 |

## 출력 형식

```text
OpenManager Spec 요청 정리

1. 요청 요약
- 

2. 요청 유형
- 

3. 사용할 템플릿
- 

4. 적용 Rule
- 공통 Rule:
- 경로별 Rule:

5. 관련 Skill / Agent
- Skill:
- Agent:

6. 위험 요소
- upstream:
- security:
- operation:
- quality:

7. 검증 계획
- 

8. 사용자 승인 필요 사항
- 

9. 다음 단계
- 
```

## 금지 사항

- 사용자의 요청을 받은 즉시 구현하지 않는다.
- 파일을 직접 수정하지 않는다.
- 운영 명령을 실행하지 않는다.
- Git Commit 또는 Push를 실행하지 않는다.
- 민감 파일이나 개인 설정 파일을 읽지 않는다.