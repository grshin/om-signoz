@AGENTS.md

# OpenManager Claude Code 프로젝트 지침

## 프로젝트 개요

- 이 저장소는 SigNoz OSS를 기반으로 OpenManager Observability Engine을 고도화하기 위한 Fork 저장소입니다.
- SigNoz 공식 저장소의 변경사항은 `upstream` Remote를 통해 추적합니다.
- `main` 브랜치는 SigNoz OSS 동기화 기준으로 유지합니다.
- `om-main` 브랜치는 OpenManager 통합 기준 브랜치입니다.
- 기능 개발은 `feature/*`, 오류 수정은 `fix/*` 브랜치에서 수행합니다.

## 기존 SigNoz Claude Code 설정 보존

다음 기존 Playwright E2E Sub-Agent는 SigNoz OSS의 기존 자동화 자산입니다.

- `.claude/agents/playwright-test-planner.md`
- `.claude/agents/playwright-test-generator.md`
- `.claude/agents/playwright-test-healer.md`

사용자가 명시적으로 요청하지 않는 한 기존 Playwright Agent를 삭제하거나 수정하지 마세요.

## OpenManager 전용 네임스페이스

OpenManager 전용 하네스 파일은 기존 SigNoz 설정과 구분합니다.

- Agent: `.claude/agents/om/`
- Rule: `.claude/rules/om/`
- Hook: `.claude/hooks/om/`
- Skill: `.claude/skills/om-*/SKILL.md`
- 문서: `docs/harness/`

OM 전용 Agent, Hook, Skill 이름에는 `om-` 접두어를 사용하세요.

## 작업 방식

- 단순하지 않은 변경은 먼저 분석하고 계획을 제시한 뒤 진행하세요.
- 현재 요청의 범위와 제외 범위를 먼저 구분하세요.
- 새로운 파일이나 로직을 만들기 전에 기존 구현, Helper, API, 설정을 먼저 탐색하세요.
- 기존 구현을 재사용할 수 있으면 중복 구현하지 마세요.
- 요청 범위 밖의 파일은 임의로 수정하지 마세요.
- 여러 파일을 변경한 경우 파일별 변경 이유를 설명하세요.

## SigNoz OSS 수정 원칙

구현 방법은 다음 우선순위로 검토하세요.

1. Dashboard, Alert Rule, OpenTelemetry 설정으로 해결
2. OpenManager 전용 확장 영역에서 구현
3. OM Adapter API 또는 Control Plane에서 구현
4. SigNoz가 제공하는 API를 활용
5. 불가피한 경우에만 SigNoz OSS 원본 소스를 직접 수정

SigNoz OSS 원본을 직접 수정해야 한다면 다음 내용을 먼저 보고하세요.

- 직접 수정이 필요한 이유
- 변경 대상 파일
- 영향 범위
- 대체 구현 가능 여부
- 향후 `upstream` 병합 시 충돌 위험

## 문서 작성 원칙

- 새로 작성하거나 수정하는 Markdown 문서의 설명은 한국어로 작성하세요.
- 코드, 명령어, 파일 경로, API 이름, 제품명, 표준 기술 용어는 원문을 유지할 수 있습니다.
- 문서는 목적, 적용 범위, 실행 방법, 검증 방법을 구분하여 작성하세요.

## 위험 작업 제한

사용자가 명시적으로 요청하지 않는 한 다음 작업을 수행하지 마세요.

- `git commit`, `git push`, Force Push
- 브랜치 삭제
- `git reset --hard`, `git clean -fd`
- 운영환경 배포
- `kubectl apply`, `kubectl delete`, Helm Upgrade
- 데이터베이스 스키마 변경 또는 데이터 삭제
- Secret, Token, Credential 값 조회
- `.env`, `.env.*`, Secret 관련 파일 내용 출력
- `.claude/settings.local.json` 내용 출력
- 기존 SigNoz Playwright Agent 수정

## 검증 및 결과 보고

파일을 수정한 뒤 다음 내용을 반드시 보고하세요.

- 변경한 파일 목록
- 파일별 변경 목적
- 실행한 검증 명령
- 검증 성공 또는 실패 결과
- 실행하지 못한 검증 항목
- 남아 있는 위험 요소
- 사용자 확인이 필요한 사항

실제로 실행하지 않은 테스트를 통과했다고 보고하지 마세요.

## 규칙 분리 원칙

이 파일에는 모든 세션에서 필요한 공통 원칙만 유지합니다.

다음 내용은 후속 단계에서 분리합니다.

- Backend, Frontend, OTel, Kubernetes 세부 규칙: `.claude/rules/om/`
- 반복 작업 절차: `.claude/skills/om-*/SKILL.md`
- 전문 역할: `.claude/agents/om/`
- 실제 차단 정책: `.claude/settings.json`, `.claude/hooks/om/`