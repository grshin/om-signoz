# OpenManager Claude Code Harness

## 목적

SigNoz OSS 기반 OpenManager 고도화 프로젝트에 Claude Code 기반 AI 하네스 엔지니어링을 적용합니다.

## 기본 원칙

- 기존 SigNoz OSS 설정과 자동화 구조를 먼저 분석합니다.
- 기존 파일은 임의로 삭제하거나 덮어쓰지 않습니다.
- OpenManager 전용 파일은 `om-` 접두어 또는 `om/` 하위 디렉터리로 구분합니다.
- SigNoz OSS 직접 수정은 최소화합니다.
- 구현 전 기존 코드 탐색과 영향도 분석을 수행합니다.
- 위험 작업은 Permission, Sandbox, Hook으로 통제합니다.
- 문서의 설명은 한국어로 작성합니다.

## 기존 SigNoz Claude Code 설정

기존 SigNoz 저장소에는 Playwright E2E 테스트 자동화를 위한 Agent가 포함되어 있습니다.

- `.claude/agents/playwright-test-planner.md`
- `.claude/agents/playwright-test-generator.md`
- `.claude/agents/playwright-test-healer.md`

기존 Agent는 삭제하거나 수정하지 않고 유지합니다.

## OpenManager 전용 구조

- `.claude/agents/om/`
- `.claude/rules/om/`
- `.claude/hooks/om/`
- `.claude/skills/om-*/`
- `docs/harness/`
