# 기존 SigNoz Claude Code 설정 분석 기록

## 분석 목적

SigNoz OSS 저장소의 Claude Code 관련 파일을 조사하고 OpenManager 하네스 파일과의 충돌 가능성을 관리합니다.

## 분석 결과

| 파일 또는 디렉터리 | 기존 존재 여부 | Git 추적 여부 | 용도 | 처리 방식 |
|---|---:|---:|---|---|
| `CLAUDE.md` | 없음 | 해당 없음 | 프로젝트 공통 Steering | 04단계에서 신규 작성 |
| `CLAUDE.local.md` | 없음 | 해당 없음 | 개인 로컬 Steering | 현재 생성하지 않음 |
| `AGENTS.md` | 없음 | 해당 없음 | Agent 공통 규칙 | 04단계에서 신규 작성 |
| `.claude/CLAUDE.md` | 없음 | 해당 없음 | 하위 Steering | 현재 생성하지 않음 |
| `.claude/settings.json` | 없음 | 해당 없음 | 팀 공통 Claude 설정 | 06단계에서 신규 작성 |
| `.claude/settings.local.json` | 있음 | Git 제외 | 개인 Sandbox 설정 | Commit 금지 |
| `.mcp.json` | 없음 | 해당 없음 | MCP 연결 설정 | 12단계에서 검토 |
| `.claude/agents/playwright-test-planner.md` | 있음 | Git 추적 | E2E 테스트 계획 Agent | 기존 파일 유지 |
| `.claude/agents/playwright-test-generator.md` | 있음 | Git 추적 | Playwright Spec 생성 Agent | 기존 파일 유지 |
| `.claude/agents/playwright-test-healer.md` | 있음 | Git 추적 | 실패한 E2E 테스트 보정 Agent | 기존 파일 유지 |

## OpenManager 전용 네임스페이스

| 구성요소 | 적용 경로 | 명명 원칙 |
|---|---|---|
| Agent | `.claude/agents/om/` | Agent 이름에 `om-` 접두어 사용 |
| Rule | `.claude/rules/om/` | 기능 영역별 Markdown 파일 작성 |
| Hook | `.claude/hooks/om/` | Script 이름에 `om-` 접두어 사용 |
| Skill | `.claude/skills/om-*/SKILL.md` | Skill 디렉터리에 `om-` 접두어 사용 |
| 문서 | `docs/harness/` | 설명은 한국어로 작성 |

## 주의사항

- 기존 Playwright Agent는 삭제하거나 수정하지 않습니다.
- `.claude/settings.local.json`은 Git에 Commit하지 않습니다.
- Secret, Token, Credential 내용은 문서에 기록하지 않습니다.
- `/init`은 기존 설정과 Skeleton 검토가 완료되기 전에는 실행하지 않습니다.
