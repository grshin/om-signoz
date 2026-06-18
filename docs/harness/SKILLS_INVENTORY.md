# OpenManager Claude Code Skills Inventory

## 문서 목적

본 문서는 OpenManager Claude Code 하네스에서 사용하는 Project Skill의 목록, 목적, 호출 방식, 적용 범위를 관리한다.

08단계에서는 OpenManager 공통 작업에 필요한 Skill만 구성한다. 전문 Sub-Agent는 09단계에서 별도로 구성한다.

## Skill 저장 위치

| 구분 | 경로 | 적용 범위 |
|---|---|---|
| Project Skill | `.claude/skills/<skill-name>/SKILL.md` | 현재 OpenManager 프로젝트 |
| Personal Skill | `~/.claude/skills/<skill-name>/SKILL.md` | 사용자 전체 프로젝트 |
| Plugin Skill | Plugin 내부 `skills/` | Plugin 활성화 범위 |

OpenManager 하네스에서는 팀 공유가 필요한 Skill만 Project Skill로 관리한다.

## 08단계 생성 Skill

| Skill | 경로 | 목적 | 호출 방식 |
|---|---|---|---|
| `om-project-context` | `.claude/skills/om-project-context/SKILL.md` | 프로젝트 맥락 정렬 | 자동/수동 |
| `om-rule-router` | `.claude/skills/om-rule-router/SKILL.md` | 적용 Rule 선택 | 자동/수동 |
| `om-change-risk-review` | `.claude/skills/om-change-risk-review/SKILL.md` | 변경사항 위험 검토 | 수동 중심 |
| `om-validation-plan` | `.claude/skills/om-validation-plan/SKILL.md` | 검증 계획 수립 | 자동/수동 |

## 호출 예시

```text
/om-project-context
```

```text
/om-rule-router backend API 변경 작업 기준으로 적용 Rule 정리
```

```text
/om-change-risk-review 07단계 MCP 정책 변경사항 검토
```

```text
/om-validation-plan 08단계 Skill 구성 검증 계획 정리
```

## 설계 원칙

| 원칙 | 설명 |
|---|---|
| 짧은 description | Claude가 적절한 시점에 Skill을 찾을 수 있도록 간결하게 작성 |
| 단계 분리 | Workflow, Agent, Hook 역할과 중복 최소화 |
| 최소 도구 | 기본적으로 Read, Grep, Glob 중심 |
| 민감 정보 보호 | Secret, Token, 개인 설정 파일 접근 금지 |
| 수동 호출 분리 | Commit 전 검토 등 중요한 작업은 직접 호출 중심 |
| 한국어 문서화 | 프로젝트 설명과 운영 기준은 한국어로 작성 |

## Skill과 Rule의 역할 차이

| 구분 | 역할 |
|---|---|
| Rule | 항상 지켜야 하는 기준, 제약, 경계 |
| Skill | 특정 작업을 수행하는 절차, 템플릿, 반복 지시문 |
| Agent | 특정 전문 역할을 맡아 독립적으로 분석 또는 작업 수행 |
| Workflow | 여러 Skill, Rule, Agent를 묶은 작업 흐름 |

08단계에서는 Rule을 대체하지 않고, Rule을 더 쉽게 적용하기 위한 공통 Skill을 구성한다.

## 보안 기준

Skill에는 다음 내용을 포함하지 않는다.

```text
API Key
Token
Password
Private Key
.env 값
운영 DB 접속 정보
개인 Gmail/Calendar/Drive 정보
```

## 08단계 완료 기준

| 항목 | 완료 기준 |
|---|---|
| Project Skill | 4개 Skill 생성 완료 |
| Frontmatter | 각 `SKILL.md`에 YAML frontmatter 포함 |
| Description | 각 Skill에 description 포함 |
| Inventory | `docs/harness/SKILLS_INVENTORY.md` 작성 |
| 점검 스크립트 | `check-step08-skills.sh` 단독 실행 가능 |
| 기존 Agent | SigNoz Playwright Agent 미수정 |
| Git 제외 | 개인 설정과 Secret 미포함 |