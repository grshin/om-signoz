---
name: OpenManager Validation Plan
description: OpenManager 변경 작업 전후에 실행할 단계별 검증 계획을 간단히 수립할 때 사용한다.
when_to_use: 구현 전 검증 계획, 변경 후 확인 절차, 단계별 점검 스크립트 실행 기준을 정리해야 할 때 사용한다.
allowed-tools: Read Grep Glob
---

# OpenManager Validation Plan Skill

## 목적

OpenManager 변경 작업의 검증 범위를 짧고 명확하게 정리한다.

## 기본 원칙

- 현재 단계 전용 점검 스크립트만 실행한다.
- 여러 단계를 한 번에 검사하는 통합 점검 스크립트는 작성하지 않는다.
- 변경 대상과 무관한 전체 상태 점검을 반복하지 않는다.
- 검증 결과는 PASS, WARN, FAIL로 구분한다.
- WARN은 허용 가능한 경고인지 별도 판단한다.
- FAIL은 Commit 전에 반드시 해소한다.

## 검증 계획 작성 기준

| 변경 유형 | 검증 기준 |
|---|---|
| 문서 변경 | Markdown 구조, 링크, Inventory 정합성 |
| Rule 변경 | Rule 파일 존재, 필수 키워드, 경로별 적용 기준 |
| Hook 변경 | Shell 문법, 실행 권한, smoke test |
| Skill 변경 | SKILL.md frontmatter, description, 호출 가능성 |
| MCP 변경 | `.mcp.json` 문법, Secret 포함 여부, Inventory 반영 |
| Agent 변경 | Agent frontmatter, 역할, 사용 도구, 기존 Agent 보존 |
| 소스 변경 | 관련 테스트, lint, build, 영향 범위 확인 |
| 배포 변경 | values, manifest, namespace, rollback 영향 확인 |

## 출력 형식

다음 형식으로 검증 계획을 작성한다.

```text
OpenManager 검증 계획

1. 변경 대상
- 단계:
- 파일:
- 작업 목적:

2. 적용 Rule
- 공통 Rule:
- 경로별 Rule:

3. 검증 항목
- 문법:
- 구조:
- 보안:
- 기능:
- 문서:
- Git 상태:

4. 실행할 점검
- 단계 전용 점검 스크립트:
- 추가 수동 확인:

5. 완료 기준
- PASS 기준:
- 허용 가능한 WARN:
- FAIL 조치 기준:
```

## 주의 사항

- 검증 계획은 작업을 단순화하기 위한 것이며, 사용자가 요청하지 않은 구현을 진행하지 않는다.
- 단계별 점검 스크립트는 해당 단계 전용으로만 작성한다.
- 전체 상태 확인용 통합 스크립트를 제안하지 않는다.