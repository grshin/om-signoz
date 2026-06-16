# OpenManager AI Agent 공통 규칙

## 목적

이 문서는 SigNoz OSS 기반 OpenManager 고도화 프로젝트에서 활동하는 AI Agent가 공통으로 따라야 하는 행동 원칙을 정의합니다.

## 기본 역할 분담

사람과 AI Agent의 역할을 다음과 같이 구분합니다.

| 구분 | 주요 역할 |
|---|---|
| 사람 | 요구사항 판단, 아키텍처 결정, 위험 작업 승인, Diff 검토, Merge 승인, 운영 반영 승인 |
| AI Agent | 기존 코드 탐색, 영향도 분석, 구현 계획 작성, 최소 범위 수정, 테스트 실행, 결과 보고 |

AI Agent는 사용자의 승인 없이 아키텍처 결정을 확정하거나 운영환경에 변경을 적용하지 않습니다.

## 필수 작업 순서

모든 코드 변경 작업은 다음 순서로 진행합니다.

1. 요청 사항과 완료 조건을 확인합니다.
2. 작업 범위와 제외 범위를 구분합니다.
3. 관련 기존 코드, Helper, API, 설정, 문서를 먼저 탐색합니다.
4. 재사용 가능한 기존 구현이 있는지 확인합니다.
5. 영향 범위와 변경 계획을 작성합니다.
6. 필요한 파일만 최소 범위로 수정합니다.
7. 변경 대상에 맞는 검증을 수행합니다.
8. Diff와 검증 결과를 확인합니다.
9. 변경 파일, 검증 결과, 남은 위험 요소를 보고합니다.

## Search-First 원칙

새 파일, Helper, API, Component, 설정을 만들기 전에 기존 구현을 먼저 찾습니다.

최소한 다음 항목을 확인합니다.

- 동일하거나 유사한 파일명
- 동일한 기능의 기존 Component 또는 Handler
- 공통 Helper와 Utility
- 기존 API Endpoint
- 기존 Dashboard, Alert Rule, OpenTelemetry 설정
- 기존 테스트 Fixture와 Mock 데이터
- 기존 문서와 RunBook

기존 구현을 재사용할 수 있으면 중복 생성하지 않습니다.

## Scope Filtering 원칙

구현 전에 작업 범위를 명확하게 분리합니다.

- In Scope: 이번 작업에서 반드시 수정해야 하는 항목
- Out of Scope: 이번 작업에서 수정하지 않는 항목
- Impact Area: 변경으로 인해 영향을 받을 수 있는 항목
- Protected Area: 명시적 승인 없이 수정하지 않는 항목

작업 범위가 불명확하면 임의로 확장하지 않습니다.

## SigNoz OSS Fork 운영 원칙

SigNoz OSS 원본 직접 수정은 최소화합니다.

다음 우선순위로 해결 방식을 검토합니다.

1. 설정으로 해결
2. Dashboard와 Alert Rule로 해결
3. OpenTelemetry Pipeline 설정으로 해결
4. OpenManager 전용 확장으로 해결
5. Adapter 또는 API 연동으로 해결
6. SigNoz 제공 API를 활용
7. 마지막 수단으로 SigNoz OSS 직접 수정

직접 수정이 필요하면 변경 사유와 `upstream` 병합 위험을 문서화합니다.

## 보호 영역

다음 파일과 디렉터리는 고위험 영역입니다.

사용자가 명시적으로 승인하지 않으면 수정하거나 내용을 출력하지 않습니다.

- `.env`
- `.env.*`
- `secrets/`
- `credentials/`
- `token/`
- `deploy/prod/`
- `ee/`
- `.claude/settings.local.json`

다음 작업도 사용자의 명시적인 요청 없이는 수행하지 않습니다.

- `git commit`
- `git push`
- `git push --force`
- `git reset --hard`
- `git clean -fd`
- `kubectl apply`
- `kubectl delete`
- `helm upgrade`
- 데이터베이스 데이터 삭제
- 운영환경 배포

## 기존 SigNoz Playwright E2E 하네스 보존

기존 SigNoz 저장소에는 다음 Playwright E2E Agent가 있습니다.

- `.claude/agents/playwright-test-planner.md`
- `.claude/agents/playwright-test-generator.md`
- `.claude/agents/playwright-test-healer.md`

기존 Agent는 삭제하거나 임의로 수정하지 않습니다.

`tests/e2e/` 영역을 작업할 때는 다음 원칙을 따릅니다.

- 기존 E2E 가이드와 Fixture를 먼저 읽습니다.
- 기존 Helper를 우선 재사용합니다.
- 테스트 데이터는 독립적으로 생성하고 정리합니다.
- 통과 중인 테스트를 불필요하게 다시 작성하지 않습니다.
- Assertion을 약화하여 억지로 통과시키지 않습니다.
- `test.only`를 Commit하지 않습니다.
- 고정 시간 대기보다 상태 기반 검증을 사용합니다.

## 문서 작성 원칙

새로 작성하거나 수정하는 Markdown 문서의 설명은 한국어로 작성합니다.

다음 항목은 원문을 유지할 수 있습니다.

- 코드
- Shell 명령어
- 파일 경로
- 변수명과 함수명
- API Endpoint
- 제품명
- 표준 기술 용어

## 검증 원칙

검증은 변경 범위에 맞게 수행합니다.

다음 내용을 결과 보고에 포함합니다.

| 구분 | 기록 내용 |
|---|---|
| 변경 파일 | 수정하거나 생성한 파일 목록 |
| 변경 목적 | 파일별 변경 이유 |
| 검증 명령 | 실제 실행한 명령 |
| 검증 결과 | 성공, 실패, 미실행 |
| 남은 위험 | 추가 확인이 필요한 항목 |
| 승인 필요 | 사용자의 결정이 필요한 항목 |

실행하지 않은 검증은 반드시 `미실행`으로 표시합니다.

## 결과 보고 형식

작업 완료 후 다음 순서로 보고합니다.

1. 변경 요약
2. 변경 파일 목록
3. 파일별 변경 목적
4. 실행한 검증 명령
5. 검증 결과
6. 실행하지 못한 검증
7. 남아 있는 위험 요소
8. 사용자 확인이 필요한 사항

## 하네스 확장 원칙

공통 원칙은 이 문서에 유지합니다.

상세 규칙과 반복 작업은 다음 위치에 분리합니다.

- 경로별 Rule: `.claude/rules/om/`
- 반복 작업 Skill: `.claude/skills/om-*/SKILL.md`
- 전문 Sub-Agent: `.claude/agents/om/`
- 실제 차단 Hook: `.claude/hooks/om/`
- 팀 공통 Claude 설정: `.claude/settings.json`