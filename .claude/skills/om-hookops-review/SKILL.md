---
name: OpenManager HookOps Review
description: OpenManager HarnessOps에서 Hook, Guardrail, 위험 명령 차단, 민감 파일 보호, Tool 사용 로그, 예외 승인 필요 여부를 검토할 때 사용한다.
when_to_use: HookOps, Guardrail, 위험 명령, 민감 파일, Tool Usage Audit, 운영 명령 승인, 예외 승인, Hook 정책 검토가 필요할 때 사용한다.
allowed-tools: Read Grep Glob Bash
---

# OpenManager HookOps Review Skill

## 목적

OpenManager HarnessOps 환경에서 HookOps 정책 준수 여부와 Guardrail 예외 필요성을 검토한다.

## 참조 문서

우선 다음 문서를 확인한다.

```text
docs/harness/hookops/HOOKOPS_POLICY.md
docs/harness/hookops/GUARDRAIL_EXCEPTION_POLICY.md
docs/harness/templates/hookops-result-template.md
docs/harness/AUDIT_TRAIL_INVENTORY.md
docs/harness/HOOKOPS_INVENTORY.md
```

## 검토 대상

다음 항목을 검토한다.

| 대상 | 검토 내용 |
|---|---|
| 위험 Bash 명령 | 차단 대상인지 확인 |
| Git 명령 | 승인 필요 여부 확인 |
| Docker 명령 | 로컬 검증 또는 운영 영향 여부 확인 |
| Kubernetes 명령 | 대상 환경과 승인 필요 여부 확인 |
| Helm 명령 | dry-run 여부와 배포 영향 확인 |
| curl / wget | 외부 네트워크 호출 목적 확인 |
| 민감 파일 접근 | Secret, Token, kubeconfig 접근 여부 확인 |
| Tool 사용 로그 | 감사 로그 기록 가능 여부 확인 |
| Guardrail 예외 | 예외 승인 필요 여부 확인 |

## 수행 절차

요청을 받으면 다음 순서로 검토한다.

1. 사용자 요청을 요약한다.
2. 실행하려는 명령 또는 접근 파일을 식별한다.
3. HookOps Policy 기준으로 허용, 경고, 차단, 승인 필요 여부를 판단한다.
4. Guardrail Exception Policy 기준으로 예외 가능 여부를 판단한다.
5. 운영 환경 영향 여부를 확인한다.
6. 민감정보 노출 가능성을 확인한다.
7. Tool Usage Audit 기록 필요 여부를 확인한다.
8. HookOps Result Template 형식으로 결과를 정리한다.

## 출력 형식

```text
OpenManager HookOps 검토 결과

1. 요청 요약
-

2. 대상 명령 또는 파일
-

3. 적용 HookOps 기준
-

4. 처리 판단
- 허용 / 경고 / 차단 / 승인 필요:

5. Guardrail 예외 필요 여부
- 필요 / 불필요:
- 사유:

6. 위험도 평가
- Git 이력 영향:
- 민감정보 영향:
- 운영 환경 영향:
- 외부 네트워크 영향:

7. 감사 기록 필요 여부
- Change History:
- Tool Usage Audit:

8. 결론
- 진행 가능 여부:
- 사용자 승인 필요 사항:
- 후속 조치:
```

## 금지 사항

- 사용자의 승인 없이 위험 명령을 실행하지 않는다.
- 민감 파일 내용을 출력하지 않는다.
- `.claude/settings.local.json` 내용을 읽거나 요약하지 않는다.
- `~/.ssh`, `~/.aws`, `~/.kube` 하위 파일을 읽지 않는다.
- 운영 환경 변경 명령을 자동 실행하지 않는다.
- Hook 차단 조건을 임의로 완화하지 않는다.