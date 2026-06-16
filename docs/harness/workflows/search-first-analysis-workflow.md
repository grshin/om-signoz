# OpenManager Search-First Analysis Workflow

## 문서 목적

본 문서는 OpenManager 고도화 작업에서 Claude Code가 구현 전에 반드시 수행해야 하는 Search-First 분석 절차를 정의한다.

Search-First는 다음 원칙을 따른다.

- 구현보다 검색이 먼저다.
- 수정보다 영향 분석이 먼저다.
- 자동 적용보다 사용자 승인이 먼저다.
- 기존 SigNoz 구조와 OpenManager 하네스 기준을 먼저 확인한다.

## 적용 대상

이 Workflow는 다음 요청에 적용한다.

| 요청 유형 | 적용 여부 |
|---|---:|
| Backend Go 변경 | 적용 |
| Frontend React 변경 | 적용 |
| OTel Pipeline 변경 | 적용 |
| Docker / Kubernetes / Helm 변경 | 적용 |
| 하네스 Rule / Skill / Agent 변경 | 적용 |
| 문서만 단순 수정 | 선택 적용 |
| 단순 설명 요청 | 미적용 |

## 기본 수행 순서

| 순서 | 작업 | 목적 |
|---:|---|---|
| 1 | 요청 요약 | 사용자의 요청을 한 문장으로 정리 |
| 2 | 요청 유형 분류 | Backend / Frontend / OTel / Deploy / Harness / Docs 구분 |
| 3 | 관련 Rule 확인 | 05단계 Rule 기준 적용 |
| 4 | 관련 Skill 확인 | 08단계, 10단계 Skill 활용 |
| 5 | 관련 Agent 확인 | 09단계 전문 Agent 활용 |
| 6 | 기존 파일 검색 | 관련 소스와 문서 위치 파악 |
| 7 | 기존 구현 분석 | 현재 구조와 변경 영향 파악 |
| 8 | 위험 요소 정리 | 보안, 운영, upstream, 품질 영향 확인 |
| 9 | 변경 계획 필요 여부 판단 | 구현 전 계획 수립 여부 결정 |
| 10 | 사용자 승인 요청 | 위험하거나 범위가 큰 작업은 승인 후 진행 |

## 요청 유형 분류 기준

| 요청 유형 | 판단 기준 | 우선 Agent |
|---|---|---|
| Backend Go | Go API, service, query, model 변경 | `om-backend-go-reviewer` |
| Frontend React | React UI, route, component, state 변경 | `om-frontend-react-reviewer` |
| OTel Pipeline | Collector, receiver, processor, exporter, ClickHouse 변경 | `om-otel-pipeline-reviewer` |
| Deploy Kubernetes | Docker, Helm, values, manifest 변경 | `om-deploy-kubernetes-reviewer` |
| Security / Quality | Secret, 권한, 품질 게이트, 검증 누락 확인 | `om-security-quality-reviewer` |
| Architecture | 모듈 구조, upstream 경계, 설계 영향 확인 | `om-architecture-reviewer` |

## 적용 Rule 선택 기준

### 공통 Rule

모든 구현 요청에는 아래 Rule을 우선 확인한다.

| Rule | 적용 목적 |
|---|---|
| `.claude/rules/om/architecture.md` | 전체 구조와 설계 기준 확인 |
| `.claude/rules/om/upstream-boundary.md` | SigNoz upstream 충돌 방지 |
| `.claude/rules/om/security-policy.md` | 보안과 민감 정보 보호 |
| `.claude/rules/om/quality-gate.md` | 검증과 품질 기준 확인 |

### 경로별 Rule

| 변경 영역 | 적용 Rule |
|---|---|
| Backend Go | `.claude/rules/om/backend-go.md` |
| Frontend React | `.claude/rules/om/frontend-react.md` |
| OTel Pipeline | `.claude/rules/om/otel-pipeline.md` |
| Deploy Kubernetes | `.claude/rules/om/deploy-kubernetes.md` |

## 검색 대상

Search-First 분석 시 다음 순서로 검색한다.

| 우선순위 | 검색 대상 | 목적 |
|---:|---|---|
| 1 | 요청과 직접 관련된 파일명 또는 키워드 | 변경 후보 위치 확인 |
| 2 | `docs/harness` | 하네스 기준과 기존 가이드 확인 |
| 3 | `.claude/rules/om` | 적용 Rule 확인 |
| 4 | `.claude/skills` | 사용 가능한 Skill 확인 |
| 5 | `.claude/agents` | 관련 Agent 확인 |
| 6 | backend / frontend / deploy 관련 소스 | 실제 구현 구조 확인 |
| 7 | 기존 테스트 또는 검증 스크립트 | 검증 가능성 확인 |

## 권장 검색 명령

요청과 관련된 파일을 찾을 때 사용한다.

```text
git status --short
git diff --name-only
find docs/harness -maxdepth 3 -type f | sort
find .claude -maxdepth 4 -type f | sort
rg "<검색어>" .
```

Backend Go 관련 요청일 때 사용한다.

```text
rg "func |type |interface " . -g "*.go"
find . -name "*.go" | sort
```

Frontend React 관련 요청일 때 사용한다.

```text
find frontend -name "*.tsx" -o -name "*.ts" 2>/dev/null | sort
rg "component|route|hook|api" frontend 2>/dev/null
```

OTel Pipeline 관련 요청일 때 사용한다.

```text
rg "otel|collector|receiver|processor|exporter|clickhouse" .
find . -iname "*otel*" -o -iname "*collector*" -o -iname "*clickhouse*"
```

Deploy Kubernetes 관련 요청일 때 사용한다.

```text
find . -iname "values*.yaml" -o -iname "*.yaml" -o -iname "*.yml"
rg "apiVersion:|kind:|helm|kubernetes|deployment|service|ingress" .
```

## 금지 또는 승인 필요 작업

Search-First 분석 단계에서는 아래 작업을 수행하지 않는다.

| 작업 | 기준 |
|---|---|
| 파일 직접 수정 | 금지 |
| 대량 파일 생성 | 금지 |
| Git Commit / Push | 금지 |
| 운영 배포 명령 | 금지 |
| Secret 조회 | 금지 |
| `.env`, key, pem 파일 읽기 | 금지 |
| `kubectl apply`, `helm upgrade` | 사용자 승인 전 금지 |
| `rm -rf`, `git reset --hard`, `git clean -fdx` | 금지 |

## Search-First 분석 출력 형식

Claude Code는 Search-First 분석 후 아래 형식으로 응답한다.

```text
OpenManager Search-First 분석 결과

1. 요청 요약
-

2. 요청 유형
-

3. 확인한 기준 문서 / Rule / Skill / Agent
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

9. 변경 계획 필요 여부
- 필요 / 불필요

10. 사용자 승인 필요 사항
-
```

## 완료 기준

Search-First 분석은 다음 조건을 만족해야 한다.

| 항목 | 기준 |
|---|---|
| 요청 요약 | 한 문장으로 정리 |
| 요청 유형 | Backend / Frontend / OTel / Deploy / Harness / Docs 중 분류 |
| Rule 확인 | 공통 Rule과 경로별 Rule 확인 |
| 검색 수행 | 관련 파일과 기존 구현 확인 |
| 영향 분석 | 변경 후보와 영향 범위 정리 |
| 위험 검토 | 보안, 운영, upstream, 품질 영향 확인 |
| 구현 보류 | 사용자 승인 전 직접 수정하지 않음 |