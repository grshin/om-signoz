---
name: OpenManager Project Context
description: OpenManager 고도화 프로젝트의 기본 맥락, 기술 스택, 보존 원칙, 작업 우선순위를 정리할 때 사용한다.
when_to_use: OpenManager, OM, SigNoz, Observability Engine, OTel, ClickHouse, React, Go, Kubernetes 관련 작업을 시작하거나 프로젝트 맥락을 다시 정리해야 할 때 사용한다.
allowed-tools: Read Grep Glob
---

# OpenManager Project Context Skill

## 목적

OpenManager 고도화 프로젝트의 기본 맥락을 기준으로 작업 방향을 정렬한다.

## 프로젝트 기준

- 본 프로젝트는 SigNoz OSS Fork 기반 OpenManager Observability Engine 고도화 프로젝트이다.
- 작업 브랜치는 `feature/om-harness-bootstrap`을 기준으로 한다.
- 기존 SigNoz 구조와 동작을 최대한 보존한다.
- OpenManager 고도화 코드는 upstream SigNoz와 충돌을 최소화하는 방향으로 분리한다.
- 설명 문서와 프로젝트 가이드는 한국어로 작성한다.

## 기술 기준

| 영역 | 기준 |
|---|---|
| Backend | Go 기반 SigNoz backend 구조 존중 |
| Frontend | React 기반 SigNoz frontend 구조 존중 |
| Observability | OpenTelemetry Collector, Metrics, Logs, Traces 중심 |
| Storage | ClickHouse 중심 데이터 흐름 고려 |
| Deploy | Docker Compose, Kubernetes, Helm 구성 고려 |
| 운영 | 보안, 감사, 품질 게이트, upstream 병합 가능성 고려 |

## 보존 원칙

다음 파일은 기존 SigNoz Playwright Agent이므로 삭제하거나 수정하지 않는다.

```text
.claude/agents/playwright-test-planner.md
.claude/agents/playwright-test-generator.md
.claude/agents/playwright-test-healer.md
```

## 작업 응답 기준

작업 요청을 받으면 다음 순서로 정리한다.

1. 요청 목적 요약
2. 관련 경로와 적용 Rule 후보
3. upstream 영향 가능성
4. 보안 또는 민감 정보 영향
5. 검증 방법
6. 사용자가 승인해야 할 작업

## 금지 기준

- 근거 없이 upstream 구조를 대규모 변경하지 않는다.
- Git Commit 또는 Push는 사용자 요청 또는 명시된 Git Checkpoint에서만 제안한다.
- 민감 파일, 인증 정보, 개인 설정 파일을 읽거나 저장하지 않는다.
- 현재 단계 외의 점검 스크립트를 과도하게 실행하지 않는다.