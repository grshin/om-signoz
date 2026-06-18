# OpenManager Guardrail Exception Policy

## 문서 목적

본 문서는 OpenManager HarnessOps 환경에서 Guardrail 예외를 요청하고 승인하는 기준을 정의한다.

Guardrail 예외는 기본적으로 제한한다.  
다만 정상적인 개발, 검증, 배포 준비 과정에서 일시적으로 필요한 경우 승인 절차에 따라 제한적으로 허용할 수 있다.

## 예외 승인 기본 원칙

Guardrail 예외는 다음 원칙을 따른다.

1. 예외는 최소 범위로 허용한다.
2. 예외는 유효기간을 가진다.
3. 예외는 사유와 승인자를 기록한다.
4. 민감 파일 접근 예외는 원칙적으로 허용하지 않는다.
5. 운영 명령 예외는 실행 대상과 영향을 명확히 기록한다.
6. 예외 승인 후 실행 결과를 반드시 기록한다.
7. 동일 예외가 반복되면 Hook 정책 또는 Workflow 개선 대상으로 등록한다.

## 예외 승인 가능 대상

다음 항목은 제한적으로 예외 승인을 검토할 수 있다.

| 대상 | 예외 가능 여부 | 기준 |
|---|---:|---|
| `git add` | 가능 | 변경 파일 확인 후 승인 |
| `git commit` | 가능 | Quality Gate 통과 후 승인 |
| `git push` | 가능 | Commit 내용 확인 후 승인 |
| `git pull` | 가능 | 브랜치와 원격 저장소 확인 후 승인 |
| `docker` | 가능 | 로컬 검증 목적일 때 승인 |
| `kubectl` | 제한 가능 | 운영계가 아닌 개발·검증 환경일 때 승인 |
| `helm` | 제한 가능 | dry-run 또는 개발 환경 기준 승인 |
| `curl` / `wget` | 가능 | 대상 URL과 목적 확인 후 승인 |
| `npm install` / `pnpm install` | 가능 | 의존성 변경 영향 확인 후 승인 |
| `go get` / `go mod tidy` | 가능 | 의존성 변경 영향 확인 후 승인 |

## 예외 승인 불가 대상

다음 항목은 원칙적으로 예외 승인하지 않는다.

| 대상 | 사유 |
|---|---|
| `rm -rf /` | 시스템 파괴 위험 |
| `git push --force` | 원격 이력 훼손 위험 |
| `git reset --hard` | 변경 이력 손실 위험 |
| `git clean -fdx` | 미추적 파일 삭제 위험 |
| `chmod -R 777` | 과도한 권한 부여 위험 |
| `~/.ssh/**` 접근 | SSH Key 노출 위험 |
| `~/.aws/**` 접근 | Cloud Credential 노출 위험 |
| `~/.kube/**` 접근 | Kubernetes 접근 정보 노출 위험 |
| `.env`, `.env.*` 접근 | Secret 노출 위험 |
| `.claude/settings.local.json` Git 추가 | 개인 설정 노출 위험 |

## 예외 승인 요청 항목

Guardrail 예외가 필요한 경우 다음 항목을 기록한다.

| 항목 | 내용 |
|---|---|
| 요청 일시 | 예외 요청 일시 |
| 요청자 | 예외 요청자 |
| 대상 명령 또는 파일 | 예외 대상 |
| 요청 사유 | 왜 예외가 필요한지 |
| 적용 범위 | 파일, 명령, 브랜치, 환경 |
| 대상 환경 | local / dev / stage / prod |
| 예상 영향 | 보안, 운영, Git 이력 영향 |
| 대체 가능성 | 예외 없이 가능한 방법 |
| 승인자 | 승인자 이름 |
| 유효기간 | 1회성 / 기간 지정 |
| 실행 결과 | 성공 / 실패 / 차단 |
| 후속 조치 | 정책 보강 또는 재발 방지 |

## 예외 승인 절차

예외 승인 절차는 다음과 같다.

```text
1. 예외 필요 상황 발생
2. 예외 요청 항목 작성
3. 관련 Rule과 Workflow 확인
4. 위험도 평가
5. 승인자 확인
6. 제한 범위와 유효기간 지정
7. 명령 실행 또는 파일 접근 수행
8. 실행 결과 기록
9. Change History와 Tool Usage Audit 반영
```

## 운영 명령 예외 기준

운영 명령은 다음 기준을 충족해야 승인할 수 있다.

| 확인 항목 | 기준 |
|---|---|
| 대상 환경 | dev 또는 검증 환경 우선 |
| 명령 목적 | 조회, dry-run, 검증 목적 우선 |
| 영향 범위 | Namespace, 리소스, 서비스 영향 명확화 |
| Rollback 가능성 | 되돌릴 수 있는 절차 확인 |
| 승인 여부 | 사용자 명시 승인 필요 |
| 로그 기록 | Tool Usage Audit에 기록 |

## 반복 예외 처리 기준

동일 유형의 예외가 반복되는 경우 다음 중 하나로 처리한다.

| 상황 | 처리 |
|---|---|
| 정상 반복 작업 | Workflow 또는 Skill 개선 |
| Hook 오탐 | Hook 조건 보강 |
| 정책 부재 | HookOps Policy 보완 |
| 위험 작업 반복 | 사용자 승인 절차 강화 |
| 운영 명령 반복 | 운영 RunBook 분리 |

## 예외 기록 보존 기준

예외 승인 기록은 다음 문서와 연결한다.

```text
docs/harness/templates/hookops-result-template.md
docs/harness/templates/tool-usage-audit-template.md
docs/harness/templates/change-history-template.md
docs/harness/AUDIT_TRAIL_INVENTORY.md
```

## 금지 사항

다음 행위는 금지한다.

- 승인 없는 예외 적용
- 예외 적용 후 결과 미기록
- 민감 파일 접근 허용
- 운영계 대상 변경 명령 자동 승인
- 예외 승인 기준을 Hook 파일 안에만 숨겨두는 행위
- 개인 Local 설정을 팀 공유 설정으로 이동하는 행위