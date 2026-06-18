# OpenManager HookOps Policy

## 문서 목적

본 문서는 OpenManager HarnessOps 환경에서 Hook을 운영하는 기준을 정의한다.

HookOps는 Claude Code가 도구를 사용할 때 발생할 수 있는 위험 작업을 사전에 통제하고, 실행 결과를 감사 가능하게 남기기 위한 운영 체계이다.

## 적용 대상

본 정책은 다음 Hook에 적용한다.

| Hook | 목적 |
|---|---|
| `om-block-dangerous-bash.sh` | 위험 Bash 명령 차단 |
| `om-protect-sensitive-files.sh` | 민감 파일 접근 보호 |
| `om-log-tool-usage.sh` | Tool 사용 로그 기록 |

## HookOps 운영 원칙

HookOps는 다음 원칙을 따른다.

1. 위험 작업은 기본 차단한다.
2. 운영 명령은 사용자 승인 후 수행한다.
3. Secret, Token, Credential, kubeconfig는 읽기와 쓰기를 차단한다.
4. Hook 차단 결과는 사용자에게 이해 가능한 메시지로 안내한다.
5. Tool 사용 로그는 감사 추적이 가능하도록 남긴다.
6. 예외가 필요한 경우 사유, 범위, 승인자, 유효기간을 기록한다.
7. 기존 SigNoz OSS 구조와 Playwright Agent는 HookOps 대상에서 임의로 변경하지 않는다.

## Hook 분류

### PreToolUse Hook

도구 실행 전에 위험 여부를 판단한다.

적용 대상은 다음과 같다.

| 대상 | 처리 기준 |
|---|---|
| 위험 Bash 명령 | 차단 |
| 민감 파일 Read/Edit/Write | 차단 |
| 운영 명령 | 승인 필요 |
| 외부 네트워크 호출 | 승인 필요 |
| 일반 조회 명령 | 허용 가능 |

### PostToolUse Hook

도구 실행 후 결과를 기록한다.

적용 대상은 다음과 같다.

| 대상 | 처리 기준 |
|---|---|
| 도구 실행 성공 | 로그 기록 |
| 도구 실행 실패 | 실패 로그 기록 |
| 차단된 명령 | 차단 사유 기록 |
| 승인 기반 명령 | 승인 여부 기록 |

## 위험 명령 기준

다음 명령은 기본 차단 대상으로 본다.

```text
rm -rf
sudo rm -rf
git reset --hard
git clean -fd
git clean -fdx
git push --force
git push -f
chmod -R 777
chown -R
mkfs
shutdown
reboot
```

## 승인 필요 명령 기준

다음 명령은 기본적으로 사용자 승인 후 수행한다.

```text
git add
git commit
git push
git pull
git fetch
docker
kubectl
helm
curl
wget
npm install
pnpm install
yarn install
go get
go mod tidy
```

## 민감 파일 보호 기준

다음 파일과 디렉터리는 기본적으로 Read, Edit, Write를 차단한다.

```text
.env
.env.*
**/.env
**/.env.*
~/.ssh/**
~/.aws/**
~/.kube/**
~/.claude.json
~/.claude/settings.json
.claude/settings.local.json
```

## Hook 실패 시 처리 기준

Hook 실행 실패 시 다음 기준으로 처리한다.

| 상황 | 처리 |
|---|---|
| Hook 문법 오류 | 즉시 수정 후 재점검 |
| Hook 실행 권한 없음 | `chmod +x` 적용 후 재점검 |
| 잘못된 차단 | 예외 승인 검토 |
| 차단 누락 | Hook 정책 보강 대상으로 등록 |
| 로그 미기록 | Tool Usage Audit 기준으로 원인 분석 |

## HookOps 결과 기록 기준

HookOps 실행 결과는 다음 경우에 기록한다.

- 위험 명령이 차단된 경우
- 민감 파일 접근이 차단된 경우
- 운영 명령 승인이 필요한 경우
- Hook 예외가 승인된 경우
- Hook 정책 변경이 필요한 경우
- Tool 사용 로그 누락이 발견된 경우

결과 기록에는 다음 항목을 포함한다.

| 항목 | 내용 |
|---|---|
| 일시 | HookOps 검토 일시 |
| 요청 내용 | 사용자의 작업 요청 요약 |
| 실행 도구 | Bash, Read, Edit, Write 등 |
| 차단 여부 | 허용 / 경고 / 차단 |
| 차단 사유 | 위험 명령, 민감 파일, 운영 명령 등 |
| 예외 필요 여부 | 필요 / 불필요 |
| 승인자 | 예외 승인 시 기록 |
| 후속 조치 | Hook 보강, 정책 보완, 사용자 안내 등 |

## 변경 관리 기준

HookOps 정책 또는 Hook 파일을 변경할 때는 다음 절차를 따른다.

1. 변경 필요 사유 작성
2. 기존 Hook 영향 분석
3. Guardrail 예외 여부 확인
4. 변경 전 테스트 계획 작성
5. 변경 후 Hook 문법 검사
6. 16단계 또는 해당 단계 점검 스크립트 실행
7. Change History 기록
8. Tool Usage Audit 기록
9. Commit / Push 수행

## 금지 사항

다음 작업은 사용자 승인 없이 수행하지 않는다.

- 기존 Hook 삭제
- 기존 Hook 차단 조건 완화
- 민감 파일 접근 허용
- 운영 명령 자동 허용
- `.claude/settings.local.json` Git 추가
- `~/.ssh`, `~/.aws`, `~/.kube` 접근 허용
- Force Push
- 운영 클러스터 직접 변경