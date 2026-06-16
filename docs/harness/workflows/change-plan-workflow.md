# OpenManager Change Plan Workflow

## 문서 목적

본 문서는 OpenManager 고도화 작업에서 Search-First 분석 이후 구현 전에 작성해야 하는 변경 계획 절차를 정의한다.

Change Plan은 다음 원칙을 따른다.

- 변경 대상과 제외 대상을 먼저 구분한다.
- 기존 SigNoz 구조와 OpenManager 확장 영역을 구분한다.
- 위험 작업은 사용자 승인 후 진행한다.
- 구현 전 검증 계획과 Rollback 기준을 먼저 정리한다.
- Git Commit / Push는 검증 이후 Checkpoint에서만 수행한다.

## 적용 대상

Change Plan은 다음 상황에서 작성한다.

| 상황 | 작성 여부 |
|---|---:|
| 여러 파일을 수정하는 작업 | 작성 |
| Backend와 Frontend가 함께 변경되는 작업 | 작성 |
| OTel Pipeline 또는 ClickHouse 영향이 있는 작업 | 작성 |
| Kubernetes, Helm, Docker 변경 작업 | 작성 |
| 보안 또는 인증 관련 변경 | 작성 |
| upstream 충돌 가능성이 있는 변경 | 작성 |
| 단순 오타 수정 | 선택 |
| 단순 설명 요청 | 미작성 |

## Change Plan 작성 순서

| 순서 | 작업 | 설명 |
|---:|---|---|
| 1 | Search-First 결과 확인 | 검색 결과와 기존 구현 확인 |
| 2 | 변경 목표 정리 | 이번 변경으로 달성할 결과 정의 |
| 3 | 변경 대상 파일 정리 | 수정 또는 생성할 파일 목록 정리 |
| 4 | 변경 제외 대상 정리 | 건드리지 않을 파일 명시 |
| 5 | 적용 Rule 정리 | 공통 Rule과 경로별 Rule 확인 |
| 6 | 관련 Agent 정리 | 검토에 사용할 Agent 선택 |
| 7 | 변경 방식 작성 | 파일별 변경 내용 요약 |
| 8 | 위험도 평가 | 보안, 운영, upstream, 품질 위험 평가 |
| 9 | 검증 계획 작성 | 실행할 점검과 테스트 정리 |
| 10 | 사용자 승인 항목 정리 | 구현 전 확인이 필요한 사항 명시 |

## 변경 대상 구분 기준

| 구분 | 설명 |
|---|---|
| 생성 | 새 파일을 추가하는 경우 |
| 수정 | 기존 파일 내용을 변경하는 경우 |
| 삭제 | 기존 파일을 제거하는 경우 |
| 이동 | 파일 경로를 변경하는 경우 |
| 제외 | 이번 작업에서 명시적으로 건드리지 않는 경우 |

## 변경 계획에 반드시 포함할 항목

| 항목 | 설명 |
|---|---|
| 요청 요약 | 사용자의 요청을 한 문장으로 정리 |
| 변경 목표 | 작업 완료 후 기대 결과 |
| 변경 대상 | 수정 또는 생성할 파일 |
| 변경 제외 대상 | 수정하지 않을 파일 |
| 적용 Rule | 공통 Rule과 경로별 Rule |
| 관련 Agent | 검토에 사용할 전문 Agent |
| 변경 방식 | 파일별 변경 방향 |
| 위험 요소 | 보안, 운영, 품질, upstream 영향 |
| 검증 계획 | 실행할 검증 명령 또는 수동 확인 |
| 승인 필요 항목 | 사용자 확인 후 진행할 항목 |
| Git Checkpoint | Commit / Push 권장 시점 |

## 위험도 평가 기준

| 위험도 | 기준 |
|---|---|
| 낮음 | 문서 또는 템플릿 추가 수준, 운영 영향 없음 |
| 보통 | 일부 소스 변경, 테스트 필요, 영향 범위 제한적 |
| 높음 | 여러 컴포넌트 영향, API 또는 배포 변경 포함 |
| 긴급 / 주의 | 운영 배포, Secret, 인증, 데이터 삭제, Rollback 어려움 포함 |

## 사용자 승인 필요 기준

아래 항목이 포함되면 구현 전 사용자 승인을 요청한다.

| 항목 | 승인 필요 여부 |
|---|---:|
| 운영 환경 영향 | 필요 |
| Kubernetes / Helm 적용 | 필요 |
| Secret 또는 인증 설정 변경 | 필요 |
| DB schema 또는 ClickHouse table 변경 | 필요 |
| 데이터 삭제 또는 migration | 필요 |
| upstream 구조 변경 | 필요 |
| 대량 파일 수정 | 필요 |
| Git Commit / Push | 필요 |

## 권장 검증 기준

변경 계획에는 가능한 범위에서 아래 검증 계획을 포함한다.

| 변경 영역 | 검증 기준 |
|---|---|
| Harness 문서 | 파일 존재, 문서 필수 항목, Secret 문자열 검사 |
| Skill | frontmatter, description, allowed-tools 확인 |
| Agent | name, description, tools, Edit / Write 미포함 확인 |
| Hook | Shell 문법, 실행 권한, smoke test |
| Backend Go | go test, API 영향 확인 |
| Frontend React | lint, type check, build |
| OTel Pipeline | config 문법, cardinality 위험, ClickHouse 영향 |
| Deploy Kubernetes | YAML 문법, Helm template, dry-run |
| Git | stage 파일 확인, 민감 파일 포함 여부 확인 |

## 금지 또는 제한 사항

Change Plan 단계에서는 아래 작업을 수행하지 않는다.

| 작업 | 기준 |
|---|---|
| 사용자 승인 전 구현 | 금지 |
| 운영 명령 실행 | 금지 |
| Secret 파일 조회 | 금지 |
| Git Commit / Push 직접 실행 | 금지 |
| 기존 SigNoz Playwright Agent 수정 | 금지 |
| `.claude/settings.local.json` 추적 | 금지 |
| 통합 점검 스크립트 생성 | 금지 |
| 현재 단계 외 점검 강제 실행 | 금지 |

## Change Plan 출력 형식

Claude Code는 변경 계획을 아래 형식으로 작성한다.

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

## 완료 기준

Change Plan은 다음 조건을 만족해야 한다.

| 항목 | 기준 |
|---|---|
| 변경 대상 명확화 | 생성, 수정, 삭제, 제외 파일 구분 |
| 적용 Rule 명시 | 공통 Rule과 경로별 Rule 포함 |
| 관련 Agent 명시 | 검토에 사용할 Agent 포함 |
| 위험도 평가 | 보안, 운영, upstream, 품질 위험 포함 |
| 검증 계획 | 실행 가능한 검증 방법 포함 |
| 승인 항목 | 사용자 확인 필요 사항 명시 |
| Git 기준 | Commit / Push 시점과 메시지 초안 포함 |