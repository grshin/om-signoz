---
name: OpenManager Change Plan
description: OpenManager 변경 작업을 구현하기 전에 변경 대상, 변경 방식, 위험도, 검증 계획, 사용자 승인 항목을 정리할 때 사용한다.
when_to_use: Search-First 분석 이후 구현 계획, 파일별 변경 계획, 위험도 평가, 검증 계획, Git Checkpoint 기준을 작성해야 할 때 사용한다.
disable-model-invocation: true
allowed-tools: Read Grep Glob Bash
---

# OpenManager Change Plan Skill

## 목적

OpenManager 변경 요청을 구현하기 전에 변경 계획을 먼저 작성한다.

Change Plan은 Search-First 분석 결과를 바탕으로 작성하며, 구현 전 사용자 승인 여부를 판단하는 기준으로 사용한다.

## 사용 방식

사용자가 다음과 같이 직접 호출한다.

```text
/om-change-plan 방금 Search-First 분석 결과를 기준으로 변경 계획을 작성해 주세요.
```

```text
/om-change-plan backend와 frontend가 함께 변경되는 작업의 파일별 변경 계획을 작성해 주세요.
```

```text
/om-change-plan OTel pipeline 변경 작업의 위험도와 검증 계획을 정리해 주세요.
```

```text
/om-change-plan Kubernetes 배포 설정 변경 전 승인 필요 항목을 정리해 주세요.
```

## 참조 Workflow

| Workflow | 경로 |
|---|---|
| Change Plan Workflow | `docs/harness/workflows/change-plan-workflow.md` |
| Change Plan Template | `docs/harness/templates/change-plan-template.md` |
| Search-First Analysis Workflow | `docs/harness/workflows/search-first-analysis-workflow.md` |
| Search-First Analysis Template | `docs/harness/templates/search-first-analysis-template.md` |

## 수행 절차

1. Search-First 분석 결과를 확인한다.
2. 요청 요약과 변경 목표를 정리한다.
3. 변경 대상 파일을 생성, 수정, 삭제, 제외로 구분한다.
4. 적용 Rule을 정리한다.
5. 관련 Skill과 Agent를 정리한다.
6. 파일별 변경 방식을 작성한다.
7. 위험도를 평가한다.
8. 사용자 승인 필요 항목을 정리한다.
9. 검증 계획을 작성한다.
10. Rollback 계획이 필요한지 판단한다.
11. Git Checkpoint 기준을 제안한다.

## 변경 대상 구분 기준

| 구분 | 설명 |
|---|---|
| 생성 | 새 파일을 추가하는 경우 |
| 수정 | 기존 파일 내용을 변경하는 경우 |
| 삭제 | 기존 파일을 제거하는 경우 |
| 이동 | 파일 경로를 변경하는 경우 |
| 제외 | 이번 작업에서 명시적으로 건드리지 않는 경우 |

## 위험도 평가 기준

| 위험도 | 기준 |
|---|---|
| 낮음 | 문서, 템플릿, Skill 추가 수준이며 운영 영향 없음 |
| 보통 | 일부 소스 변경이 있고 테스트 또는 빌드 확인 필요 |
| 높음 | 여러 컴포넌트에 영향이 있거나 API, OTel, 배포 변경 포함 |
| 주의 | 운영 배포, Secret, 인증, DB schema, 데이터 삭제, Rollback 어려움 포함 |

## 사용자 승인 필요 기준

아래 항목은 구현 전에 사용자 승인이 필요하다.

| 항목 | 기준 |
|---|---|
| 운영 환경 영향 | 서비스 동작 또는 배포 환경에 영향 |
| Kubernetes / Helm 적용 | `kubectl`, `helm` 적용 또는 삭제 |
| Secret 또는 인증 설정 변경 | 인증, 권한, token, key 관련 변경 |
| DB schema 또는 ClickHouse table 변경 | 저장 구조 변경 |
| 데이터 삭제 또는 migration | 데이터 손실 가능성 |
| upstream 구조 변경 | SigNoz 원본 구조와 충돌 가능성 |
| 대량 파일 수정 | 영향 범위가 넓은 변경 |
| Git Commit / Push | repository 이력 변경 |

## 출력 형식

```text
OpenManager Change Plan

1. 요청 요약
-

2. 변경 목표
-

3. 변경 대상 파일
- 생성:
- 수정:
- 삭제:
- 제외:

4. 적용 Rule
- 공통 Rule:
- 경로별 Rule:

5. 관련 Skill / Agent
- Skill:
- Agent:

6. 파일별 변경 계획
| 파일 | 변경 방식 | 변경 내용 | 위험도 |
|---|---|---|---|

7. 위험 요소
- upstream:
- security:
- operation:
- quality:
- rollback:

8. 검증 계획
- 문법:
- 테스트:
- 빌드:
- 수동 확인:
- 단계 전용 점검 스크립트:

9. 사용자 승인 필요 사항
-

10. Git Checkpoint 제안
- Commit 권장 여부:
- Push 권장 여부:
- Commit 메시지 초안:
```

## 금지 사항

- 사용자 승인 전 구현하지 않는다.
- 운영 명령을 실행하지 않는다.
- Secret 파일을 읽지 않는다.
- Git Commit 또는 Push를 직접 실행하지 않는다.
- 기존 SigNoz Playwright Agent를 수정하지 않는다.
- `.claude/settings.local.json`을 Git 추적 대상으로 만들지 않는다.
- 통합 점검 스크립트를 작성하지 않는다.