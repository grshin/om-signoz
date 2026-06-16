---
name: OpenManager Search First Analysis
description: OpenManager 변경 요청을 구현하기 전에 기존 소스, 문서, Rule, Skill, Agent를 먼저 검색하고 영향 범위를 분석할 때 사용한다.
when_to_use: OpenManager 기능 개발, 개선, 리팩토링, backend, frontend, otel pipeline, deploy, harness 변경 요청을 구현 전에 분석해야 할 때 사용한다.
disable-model-invocation: true
allowed-tools: Read Grep Glob Bash
---

# OpenManager Search First Analysis Skill

## 목적

OpenManager 변경 요청을 바로 구현하지 않고, 기존 구현과 하네스 기준을 먼저 검색·분석한다.

## 사용 방식

사용자가 다음과 같이 직접 호출한다.

```text
/om-search-first-analysis backend API 변경 요청을 구현 전에 분석해 주세요.
```

```text
/om-search-first-analysis frontend 화면 개선 요청의 기존 구현 위치를 먼저 찾아 주세요.
```

```text
/om-search-first-analysis OTel pipeline 변경 요청의 영향 범위를 분석해 주세요.
```

```text
/om-search-first-analysis Kubernetes 배포 설정 변경 전 영향 범위를 분석해 주세요.
```

## 참조 Workflow

| Workflow | 경로 |
|---|---|
| Search-First Analysis Workflow | `docs/harness/workflows/search-first-analysis-workflow.md` |
| Search-First Analysis Template | `docs/harness/templates/search-first-analysis-template.md` |
| Change Plan Workflow | `docs/harness/workflows/change-plan-workflow.md` |
| Change Plan Template | `docs/harness/templates/change-plan-template.md` |

## 수행 절차

1. 사용자의 요청을 한 문장으로 요약한다.
2. 요청 유형을 분류한다.
3. 관련 Rule을 확인한다.
4. 관련 Skill과 Agent를 선택한다.
5. 기존 파일과 구현을 검색한다.
6. 발견한 기존 구조를 요약한다.
7. 변경 후보 파일을 정리한다.
8. 영향 범위를 분석한다.
9. 위험 요소를 정리한다.
10. Change Plan 작성 필요 여부를 판단한다.
11. 사용자 승인 필요 사항을 정리한다.

## 요청 유형 분류 기준

| 요청 유형 | 판단 기준 | 우선 Agent |
|---|---|---|
| Backend Go | API, service, query, model, Go code 변경 | `om-backend-go-reviewer` |
| Frontend React | UI, component, route, state, API client 변경 | `om-frontend-react-reviewer` |
| OTel Pipeline | collector, receiver, processor, exporter, ClickHouse 변경 | `om-otel-pipeline-reviewer` |
| Deploy Kubernetes | Docker, Kubernetes, Helm, values, manifest 변경 | `om-deploy-kubernetes-reviewer` |
| Security / Quality | Secret, 권한, 품질 게이트, 검증 누락 확인 | `om-security-quality-reviewer` |
| Architecture | 구조, upstream 경계, 모듈 분리 검토 | `om-architecture-reviewer` |
| Harness | `.claude`, `docs/harness`, Rule, Skill, Agent, Hook 변경 | `om-architecture-reviewer`, `om-security-quality-reviewer` |

## 우선 확인 Rule

### 공통 Rule

| Rule | 목적 |
|---|---|
| `.claude/rules/om/architecture.md` | 구조와 설계 기준 확인 |
| `.claude/rules/om/upstream-boundary.md` | SigNoz upstream 충돌 방지 |
| `.claude/rules/om/security-policy.md` | 보안과 민감 정보 보호 |
| `.claude/rules/om/quality-gate.md` | 검증과 품질 기준 확인 |

### 경로별 Rule

| 변경 영역 | Rule |
|---|---|
| Backend Go | `.claude/rules/om/backend-go.md` |
| Frontend React | `.claude/rules/om/frontend-react.md` |
| OTel Pipeline | `.claude/rules/om/otel-pipeline.md` |
| Deploy Kubernetes | `.claude/rules/om/deploy-kubernetes.md` |

## 권장 검색 명령

아래 명령은 필요한 경우에만 사용한다.

```text
git status --short
git diff --name-only
find docs/harness -maxdepth 3 -type f | sort
find .claude -maxdepth 4 -type f | sort
rg "<검색어>" .
```

Backend Go 관련 분석 시 사용한다.

```text
find . -name "*.go" | sort
rg "func |type |interface " . -g "*.go"
```

Frontend React 관련 분석 시 사용한다.

```text
find frontend -name "*.tsx" -o -name "*.ts" 2>/dev/null | sort
rg "component|route|hook|api" frontend 2>/dev/null
```

OTel Pipeline 관련 분석 시 사용한다.

```text
rg "otel|collector|receiver|processor|exporter|clickhouse" .
find . -iname "*otel*" -o -iname "*collector*" -o -iname "*clickhouse*"
```

Deploy Kubernetes 관련 분석 시 사용한다.

```text
find . -iname "values*.yaml" -o -iname "*.yaml" -o -iname "*.yml"
rg "apiVersion:|kind:|helm|kubernetes|deployment|service|ingress" .
```

## 출력 형식

```text
OpenManager Search-First 분석 결과

1. 요청 요약
-

2. 요청 유형
-

3. 확인한 기준
- Rule:
- Skill:
- Agent:

4. 검색한 키워드와 경로
-

5. 발견한 기존 구현
-

6. 변경 후보 파일
-

7. 영향 범위
- Backend:
- Frontend:
- OTel:
- Deploy:
- Harness:
- Docs:

8. 위험 요소
- upstream:
- security:
- operation:
- quality:

9. Change Plan 작성 필요 여부
- 필요 / 불필요

10. 사용자 승인 필요 사항
-
```

## 금지 사항

- 검색 없이 바로 구현하지 않는다.
- 사용자 승인 전 파일을 직접 수정하지 않는다.
- 운영 명령을 실행하지 않는다.
- Secret, `.env`, key, pem, 개인 설정 파일을 읽지 않는다.
- Git Commit 또는 Push를 실행하지 않는다.
- 기존 SigNoz Playwright Agent를 수정하지 않는다.
- 통합 점검 스크립트를 작성하지 않는다.