# OpenManager Claude Code Usage Guide

## 문서 목적

본 문서는 OpenManager HarnessOps 환경에서 Claude Code를 사용하는 기준을 정의한다.

Claude Code는 OpenManager 개발, 문서화, 검증, 분석을 보조하는 AI Agent 도구로 사용한다.
단, 사용자 승인 없이 위험 명령, 운영 명령, Git 변경, 외부 시스템 Write 작업을 수행하지 않는다.

## 기본 원칙

Claude Code 사용 원칙은 다음과 같다.

1. 모든 답변은 한국어 중심으로 작성한다.
2. 요청을 받으면 먼저 목적과 범위를 확인한다.
3. 바로 구현하지 않고 Search-First를 먼저 수행한다.
4. 변경 전에는 Change Plan을 작성한다.
5. 실제 파일 수정은 사용자 승인 후 수행한다.
6. Git Add, Commit, Push는 사용자 승인 후 수행한다.
7. 운영 명령은 사용자 승인 후 수행한다.
8. Jira MCP는 Read-only 기준으로 사용한다.
9. 민감 정보는 읽거나 출력하지 않는다.
10. 변경 이력과 도구 사용 이력을 남긴다.

## 권장 프롬프트 기본형

Claude Code에 요청할 때는 다음 형식을 권장한다.

```text
OpenManager HarnessOps 기준으로 아래 요청을 처리해줘.

요청:
-

조건:
- 파일을 바로 수정하지 말고 먼저 읽기 전용으로 분석
- Search-First 수행
- 영향 범위 정리
- Change Plan 작성
- 사용자 승인 전 구현 금지
- 결과는 한국어로 정리
```

## 읽기 전용 분석 요청 예시

```text
OpenManager HarnessOps 기준으로 현재 요청을 읽기 전용으로 분석해줘.
파일은 수정하지 말고 관련 파일, Rule, Skill, Workflow만 확인해줘.
Search-First 분석 결과와 Change Plan 필요 여부를 정리해줘.
```

## Jira Issue 분석 요청 예시

```text
atlassian-rovo MCP를 사용해서 Jira Issue <이슈키>를 읽기 전용으로 조회해줘.
Issue를 생성, 수정, 삭제, 댓글 작성, 상태 변경하지 말고 Summary, Description, Status, Priority, Label만 요약해줘.
요약 후 Spec, Search-First, Change Plan 필요 여부를 정리해줘.
```

## Change Plan 요청 예시

```text
Search-First 분석 결과를 기준으로 Change Plan을 작성해줘.
실제 파일은 수정하지 말고 변경 대상, 영향 범위, 검증 방법, 사용자 승인 필요 사항만 정리해줘.
```

## 구현 요청 예시

```text
앞서 작성한 Change Plan 기준으로 구현을 진행해줘.
단, 변경 전 현재 브랜치와 git status를 확인하고, 변경 파일 목록을 먼저 알려줘.
민감 파일은 수정하지 말고, 구현 후 Validation과 Quality Gate 기준도 함께 제안해줘.
```

## Git 작업 요청 예시

Git 작업은 사용자 승인 후 진행한다.

```text
현재 변경 파일을 확인하고 21단계 파일만 stage 해줘.
민감 파일이나 다른 단계 파일이 포함되어 있으면 중단하고 알려줘.
```

Commit 요청 예시는 다음과 같다.

```text
21단계 파일만 포함되어 있는지 확인한 뒤 아래 메시지로 commit 해줘.

docs: 21단계 팀 온보딩 및 배포 패키지 기준 추가
```

## 금지 프롬프트

다음과 같은 요청은 사용하지 않는다.

```text
바로 수정해줘.
다 알아서 커밋하고 푸시해줘.
에러 나도 무시하고 진행해줘.
운영 서버에 바로 적용해줘.
.env 파일 열어서 확인해줘.
Jira 댓글 달아줘.
Jira 상태 Done으로 바꿔줘.
```

## Claude Code 사용 가능 작업

| 작업 | 사용 가능 여부 | 기준 |
|---|---:|---|
| 문서 읽기 | 가능 | Read-only |
| 문서 작성 | 가능 | 사용자 요청 기준 |
| 코드 검색 | 가능 | Search-First |
| 코드 분석 | 가능 | Read-only 우선 |
| 코드 수정 | 제한 가능 | 사용자 승인 후 |
| 테스트 실행 | 제한 가능 | 영향 범위 확인 후 |
| Git Add | 제한 가능 | 사용자 승인 후 |
| Git Commit | 제한 가능 | 사용자 승인 후 |
| Git Push | 제한 가능 | 사용자 승인 후 |
| Jira 조회 | 가능 | Read-only |
| Jira 수정 | 금지 | Write 작업 금지 |

## MCP 사용 기준

MCP는 다음 기준으로 사용한다.

| MCP 유형 | 기준 |
|---|---|
| Jira MCP | Read-only |
| Confluence MCP | Read-only |
| GitHub MCP | 조회 우선 |
| Calendar / Gmail | 본 프로젝트에서는 기본 사용하지 않음 |
| Write MCP | 별도 승인 Workflow 전까지 금지 |

Read-only MCP에서 허용되는 도구 이름 후보는 다음과 같다.

```text
read
get
search
list
fetch
find
lookup
```

사용하지 않는 도구 이름 후보는 다음과 같다.

```text
create
update
delete
remove
transition
comment
assign
upload
attach
edit
write
move
```

## HookOps와 Guardrail 기준

Claude Code 사용 중 다음 작업은 HookOps 또는 Guardrail 대상이다.

| 작업 | 처리 |
|---|---|
| 위험 삭제 명령 | 차단 |
| Force Push | 차단 |
| 민감 파일 접근 | 차단 |
| Git Add / Commit / Push | 승인 필요 |
| Docker 명령 | 승인 필요 |
| Kubernetes / Helm 명령 | 승인 필요 |
| 외부 URL 호출 | 승인 필요 |

## 민감 정보 보호 기준

다음 파일과 경로는 읽거나 출력하지 않는다.

```text
.env
.env.*
**/.env
**/.env.*
.claude/settings.local.json
~/.ssh/**
~/.aws/**
~/.kube/**
```

## 응답 형식 기준

Claude Code 응답은 다음 기준을 따른다.

```text
1. 요청 요약
2. 확인한 파일
3. 영향 범위
4. 위험도
5. 변경 계획
6. 사용자 승인 필요 사항
7. 다음 단계
```

코드나 문서 내용을 제공할 때는 복사 가능한 코드 블록으로 제공한다.

## 결론

Claude Code는 OpenManager HarnessOps에서 생산성을 높이는 도구이지만, 모든 작업은 분석, 계획, 승인, 검증, 감사 기준 안에서 수행해야 한다.

팀원은 Claude Code를 사용할 때 항상 Read-only 분석, Search-First, Change Plan, 사용자 승인 기준을 먼저 적용한다.