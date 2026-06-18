---
name: OpenManager Change Risk Review
description: OpenManager 하네스 또는 소스 변경사항의 위험도, 민감 파일 포함 여부, upstream 충돌 가능성을 검토할 때 사용한다.
when_to_use: Commit 전 변경사항 검토, PR 전 위험 점검, stage 파일 검토, 민감 정보 포함 여부 확인이 필요할 때 사용한다.
disable-model-invocation: true
allowed-tools: Read Grep Glob Bash
---

# OpenManager Change Risk Review Skill

## 목적

OpenManager 프로젝트 변경사항을 Commit 또는 Push 전에 검토한다.

## 사용자 호출 예시

```text
/om-change-risk-review
```

```text
/om-change-risk-review 08단계 변경사항 검토
```

## 검토 기준

다음 항목을 확인한다.

| 항목 | 확인 내용 |
|---|---|
| 변경 범위 | 현재 변경 파일이 요청 단계와 일치하는가 |
| 민감 파일 | `.env`, key, pem, settings.local.json, ssh/aws/kube 설정 포함 여부 |
| upstream 영향 | SigNoz 원본 구조와 충돌 가능성 |
| Hook 영향 | 위험 명령 차단 또는 민감 파일 보호 영향 |
| MCP 영향 | 외부 도구 인증, 개인 데이터 접근 가능성 |
| 품질 검증 | 해당 단계 전용 점검 스크립트 실행 여부 |
| 문서 정합성 | Inventory, README, 정책 문서 갱신 여부 |

## Git 작업 기준

- Git Commit은 해당 단계 점검 스크립트가 통과한 뒤 제안한다.
- Git Push는 사용자가 요청했거나 단계별 Checkpoint에서만 제안한다.
- 여러 단계를 한 번에 검사하는 통합 점검 스크립트는 작성하지 않는다.
- 현재 단계 전용 점검 스크립트만 사용한다.

## 출력 형식

다음 형식으로 정리한다.

```text
변경사항 위험 검토 결과

1. 변경 범위
- 단계:
- 주요 파일:

2. 위험 요소
- 민감 파일:
- upstream 충돌:
- 실행 제어 영향:
- 외부 연동 영향:

3. 검증 상태
- 실행한 점검 스크립트:
- PASS/WARN/FAIL 요약:

4. Git Checkpoint 제안
- Commit 권장 여부:
- Push 권장 여부:
- Commit 메시지 초안:

5. 결론
- 진행 가능 여부:
- 추가 확인 사항:
```

## 주의 사항

- 인증 정보 원문을 출력하지 않는다.
- 민감 파일 내용을 읽지 않는다.
- 사용자가 요청하지 않은 Git Commit 또는 Push 명령을 실행하지 않는다.
- 기존 SigNoz Playwright Agent 파일을 수정 대상으로 제안하지 않는다.