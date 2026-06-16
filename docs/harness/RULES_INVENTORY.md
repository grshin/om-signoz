# OpenManager Claude Code Rules 목록

## 목적

OpenManager Claude Code 하네스에 포함된 Rule과 적용 범위를 관리합니다.

## 공통 Rule

다음 Rule은 `paths` 조건 없이 모든 세션에 적용합니다.

| Rule | 역할 |
|---|---|
| `.claude/rules/om/architecture.md` | OpenManager 아키텍처 원칙과 구현 우선순위 |
| `.claude/rules/om/upstream-boundary.md` | SigNoz OSS 원본과 OM 변경사항의 경계 |
| `.claude/rules/om/security-policy.md` | Secret, Credential, 운영환경 보호 원칙 |
| `.claude/rules/om/quality-gate.md` | 변경 범위 통제와 검증 결과 보고 기준 |

## 경로별 Rule

다음 Rule은 YAML Frontmatter의 `paths`에 일치하는 파일을 작업할 때 적용합니다.

| Rule | 주요 적용 경로 | 역할 |
|---|---|---|
| `.claude/rules/om/backend-go.md` | `**/*.go`, `cmd/**/*`, `pkg/**/*`, `go.mod` | Go Backend 개발 규칙 |
| `.claude/rules/om/frontend-react.md` | `frontend/**/*` | Frontend 개발 규칙 |
| `.claude/rules/om/otel-pipeline.md` | `conf/**/*`, `**/*otel*`, `**/*collector*` | OpenTelemetry Pipeline 규칙 |
| `.claude/rules/om/deploy-kubernetes.md` | `deploy/**/*`, Helm, Kubernetes YAML | Kubernetes 배포 규칙 |

## Rule 작성 원칙

- Rule 파일은 `.claude/rules/om/` 아래에 저장합니다.
- 공통 Rule은 짧고 명확하게 유지합니다.
- 경로별 Rule은 `paths` Frontmatter를 사용합니다.
- Rule은 한 가지 주제만 다룹니다.
- 상세한 반복 작업 절차는 Skill로 분리합니다.
- 강제 차단이 필요한 항목은 Permission과 Hook으로 분리합니다.
- Markdown 문서의 설명은 한국어로 작성합니다.

## 기존 SigNoz 자산 보존

다음 기존 Playwright Agent는 수정하지 않습니다.

- `.claude/agents/playwright-test-planner.md`
- `.claude/agents/playwright-test-generator.md`
- `.claude/agents/playwright-test-healer.md`