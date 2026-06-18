# OpenManager HarnessOps Training Scenario

## 문서 목적

본 문서는 OpenManager HarnessOps를 팀원이 실습할 수 있도록 구성한 교육 시나리오이다.

교육 시나리오는 실제 운영 코드 변경이 아니라, Read-only 분석과 문서 기반 절차 검증을 중심으로 진행한다.

## 교육 목표

교육 목표는 다음과 같다.

```text
- HarnessOps 기본 흐름을 이해한다.
- Jira Issue 또는 내부 요청을 분석할 수 있다.
- Search-First 절차를 수행할 수 있다.
- Change Plan을 작성할 수 있다.
- 사용자 승인 전 구현을 중단할 수 있다.
- Quality Gate와 Audit 기준을 설명할 수 있다.
- Lessons Learned와 Metrics를 작성할 수 있다.
```

## 교육 대상

| 대상 | 목표 |
|---|---|
| 신규 개발자 | HarnessOps 기본 작업 흐름 이해 |
| 기존 개발자 | AI Agent 기반 절차 적용 |
| DevOps 담당자 | Worktree, HookOps, Quality Gate 이해 |
| PM / PL | Jira Issue 기반 요청 관리 이해 |
| 검토자 | Change Plan, Quality Gate, Lessons 확인 |

## 사전 준비

교육 전 다음 환경을 준비한다.

| 항목 | 기준 |
|---|---|
| 저장소 | `/home/grshin/project/next-om/om-signoz` |
| 브랜치 | `feature/om-harness-bootstrap` |
| Claude Code | 설치 및 실행 가능 |
| Jira MCP | 선택, Read-only 기준 |
| 샘플 Jira Issue | 선택 |
| HookOps 문서 | 존재 |
| Worktree 문서 | 존재 |
| Metrics 문서 | 존재 |

사전 확인 명령은 다음과 같다.

```bash
cd /home/grshin/project/next-om/om-signoz
pwd
git branch --show-current
git status --short
claude --version
```

## 교육 시나리오 1. 내부 요청 분석

### 요청 예시

```text
OpenManager Dashboard 카드에서 데이터 로딩 중 상태를 더 명확하게 보여줄 수 있는지 검토해 주세요.
```

### 수행 절차

1. 요청 목적을 요약한다.
2. 작업 유형을 Frontend로 분류한다.
3. 실제 구현 전 Search-First 필요 여부를 판단한다.
4. Change Plan 필요 여부를 판단한다.
5. 사용자 승인 전 구현하지 않는다.

### 기대 결과

```text
- 요청 유형: Frontend
- 영향 영역: Dashboard Component
- Search-First 필요: 필요
- Change Plan 필요: 필요
- 사용자 승인 전 구현: 금지
```

## 교육 시나리오 2. Jira Issue Read-only 분석

### 요청 예시

```text
Jira Issue <이슈키>를 읽기 전용으로 조회하고 요구사항을 요약해 주세요.
```

### 수행 절차

1. Jira Issue Key를 확인한다.
2. Jira MCP 사용이 Read-only인지 확인한다.
3. Summary, Description, Status, Priority만 요약한다.
4. Jira Issue를 수정하지 않는다.
5. Spec, Search-First, Change Plan 필요 여부를 정리한다.

### 금지 작업

```text
- Jira Issue 수정
- Jira 댓글 작성
- Jira 상태 변경
- 담당자 변경
- Label 변경
```

## 교육 시나리오 3. Search-First 분석

### 요청 예시

```text
Dashboard 카드 로딩 상태와 관련된 기존 Frontend 구조를 Search-First로 분석해 주세요.
```

### 수행 절차

1. 관련 디렉터리를 검색한다.
2. 기존 Component 구조를 확인한다.
3. API 호출 상태 처리 방식을 확인한다.
4. Loading, Empty, Error State 처리 여부를 확인한다.
5. 변경 후보를 정리한다.

### 기대 결과

```text
- 확인한 파일 목록
- 관련 Component 후보
- 기존 로딩 상태 처리 방식
- 개선 필요 여부
- Change Plan 필요 여부
```

## 교육 시나리오 4. Change Plan 작성

### 요청 예시

```text
Search-First 분석 결과를 기준으로 Change Plan을 작성해 주세요.
```

### 수행 절차

1. 변경 목적을 정리한다.
2. 변경 대상 파일을 정리한다.
3. 제외 범위를 정리한다.
4. 영향도를 평가한다.
5. 검증 방법을 정의한다.
6. 사용자 승인 필요 사항을 정리한다.

### 기대 결과

```text
- 변경 목적
- 변경 대상
- 제외 범위
- 영향도
- 검증 방법
- 사용자 승인 필요 사항
```

## 교육 시나리오 5. Quality Gate 확인

### 요청 예시

```text
해당 변경에 필요한 Quality Gate를 정리해 주세요.
```

### 수행 절차

1. 작업 유형을 확인한다.
2. 필요한 검증 명령을 정리한다.
3. 수동 검증 항목을 정리한다.
4. 실패 시 조치 기준을 정리한다.

### 기대 결과

```text
- 빌드 검증
- 테스트 검증
- Lint 검증
- 수동 검증
- 실패 시 중단 기준
```

## 교육 시나리오 6. Lessons Learned 작성

### 요청 예시

```text
Pilot 결과를 기준으로 Lessons Learned를 작성해 주세요.
```

### 수행 절차

1. 잘 된 점을 정리한다.
2. 개선 필요 사항을 정리한다.
3. 반복 적용 가능성을 판단한다.
4. 다음 단계 반영 사항을 정리한다.
5. Metrics와 연결한다.

### 기대 결과

```text
- 잘 된 점
- 개선 필요 사항
- 반복 적용 가능성
- 21단계 온보딩 반영 사항
- 운영 지표 연결
```

## 교육 완료 기준

교육 완료 기준은 다음과 같다.

| 항목 | 완료 기준 |
|---|---|
| 요청 분석 | 요청 목적과 유형을 설명할 수 있음 |
| Jira Read-only | 조회와 Write 금지 기준을 설명할 수 있음 |
| Search-First | 기존 코드 검색 절차를 수행할 수 있음 |
| Change Plan | 변경 계획을 작성할 수 있음 |
| Quality Gate | 검증 기준을 설명할 수 있음 |
| Audit | Change History와 Tool Usage Audit 필요성을 설명할 수 있음 |
| Lessons | 회고와 개선사항을 작성할 수 있음 |
| Metrics | 핵심 운영 지표를 설명할 수 있음 |

## 실습 결과 기록

실습 결과는 다음 템플릿에 기록한다.

```text
docs/harness/templates/onboarding-checklist-template.md
docs/harness/templates/lessons-learned-template.md
docs/harness/templates/harnessops-metrics-template.md
```

## 금지 사항

교육 중 다음 작업은 수행하지 않는다.

- 실제 운영 배포
- 사용자 승인 없는 코드 수정
- 사용자 승인 없는 Git Commit / Push
- Jira Issue 수정
- Jira 댓글 작성
- 민감 파일 열람
- Token, Secret, Credential 출력
- Hook 차단 기준 완화

## 결론

HarnessOps 교육 시나리오는 팀원이 AI Agent를 안전하게 사용하는 방법을 실습하기 위한 기준이다.

교육의 목표는 빠른 구현이 아니라, 요청 분석, Search-First, Change Plan, 승인, 검증, 감사 흐름을 반복 가능하게 만드는 것이다.