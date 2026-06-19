---
name: OpenManager Rule Router
description: 변경 대상 파일이나 작업 내용을 기준으로 적용해야 할 OpenManager Rule을 선택할 때 사용한다.
when_to_use: 사용자가 특정 파일, 디렉터리, 기능 변경, backend, frontend, otel, deploy, k8s 작업을 요청할 때 사용한다.
allowed-tools: Read Grep Glob
---

# OpenManager Rule Router Skill

## 목적

작업 대상 경로와 변경 유형을 기준으로 적용할 Rule을 선택한다.

## 공통 Rule

모든 OpenManager 작업에는 다음 공통 Rule을 우선 검토한다.

| Rule | 적용 기준 |
|---|---|
| `.claude/rules/om/architecture.md` | 구조, 모듈 경계, 설계 방향 |
| `.claude/rules/om/upstream-boundary.md` | SigNoz upstream과 충돌 가능성 |
| `.claude/rules/om/security-policy.md` | 인증 정보, 민감 데이터, 외부 연동 |
| `.claude/rules/om/quality-gate.md` | 테스트, 빌드, 린트, 검증 기준 |

## 경로별 Rule

| Rule | 적용 기준 |
|---|---|
| `.claude/rules/om/backend-go.md` | Go backend, API, service, model, query 변경 |
| `.claude/rules/om/frontend-react.md` | React frontend, UI, route, component, state 변경 |
| `.claude/rules/om/otel-pipeline.md` | OpenTelemetry Collector, receiver, processor, exporter, metrics/logs/traces 변경 |
| `.claude/rules/om/deploy-kubernetes.md` | Docker, Kubernetes, Helm, deployment, values 변경 |

## 적용 절차

작업을 시작하기 전에 다음 표로 정리한다.

| 항목 | 내용 |
|---|---|
| 요청 요약 | 사용자의 요청을 한 문장으로 정리 |
| 변경 후보 경로 | 수정 가능성이 있는 파일 또는 디렉터리 |
| 적용 공통 Rule | architecture, upstream-boundary, security-policy, quality-gate 중 선택 |
| 적용 경로 Rule | backend-go, frontend-react, otel-pipeline, deploy-kubernetes 중 선택 |
| 위험도 | 낮음, 보통, 높음 |
| 사용자 확인 필요 여부 | 필요 또는 불필요 |

## 판단 기준

- backend와 frontend가 모두 변경되면 두 Rule을 모두 적용한다.
- 배포 파일이 포함되면 deploy-kubernetes Rule을 반드시 검토한다.
- OTel pipeline 관련 변경이면 otel-pipeline Rule을 우선 적용한다.
- upstream SigNoz 구조 변경 가능성이 있으면 upstream-boundary Rule을 반드시 적용한다.
- Secret, Token, 인증, 권한, 외부 시스템 연동이 있으면 security-policy Rule을 반드시 적용한다.

## 출력 형식

다음 형식으로 응답한다.

```text
적용 Rule 판단 결과
- 요청 요약:
- 변경 후보 경로:
- 적용 공통 Rule:
- 적용 경로 Rule:
- 주요 위험:
- 검증 필요 항목:
- 사용자 승인 필요 여부:
```