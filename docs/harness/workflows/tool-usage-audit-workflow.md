# OpenManager Tool Usage Audit Workflow

## 문서 목적

본 문서는 OpenManager Claude Code 하네스에서 Tool 사용 로그를 감사하고 추적하는 절차를 정의한다.

Tool Usage Audit은 다음 원칙을 따른다.

- Tool 사용은 변경 작업의 감사 근거가 된다.
- 위험 명령, 민감 파일 접근, 운영 영향 작업은 별도로 확인한다.
- Secret 원문은 조회하거나 기록하지 않는다.
- Git Commit / Push 전 Tool 사용 로그를 확인한다.
- 이상 징후가 있으면 변경 이력에 기록하고 사용자 확인을 받는다.

## 적용 대상

이 Workflow는 다음 시점에 적용한다.

| 시점 | 적용 여부 |
|---|---:|
| 구현 완료 후 | 적용 |
| Quality Gate 수행 전 | 적용 |
| Commit 전 | 적용 |
| Push 전 | 선택 적용 |
| 운영 명령 실행 전후 | 적용 |
| 단순 질의 응답 | 미적용 |

## 감사 대상 Tool 사용

Tool Usage Audit은 다음 항목을 확인한다.

| 감사 항목 | 설명 |
|---|---|
| Bash 사용 | 위험 명령 실행 여부 확인 |
| Read 사용 | 민감 파일 접근 여부 확인 |
| Write / Edit 사용 | 변경 파일 범위 확인 |
| Grep / Glob 사용 | 검색 대상 확인 |
| Git 명령 | Stage, Commit, Push 여부 확인 |
| Kubernetes 명령 | `kubectl`, `helm` 사용 여부 확인 |
| Secret 접근 | `.env`, key, pem, token, password 접근 여부 확인 |
| 운영 영향 명령 | 배포, 삭제, 초기화 명령 사용 여부 확인 |

## 기본 로그 위치

06단계에서 구성한 Tool 사용 로그 Hook 기준으로 아래 경로를 기본 로그 위치로 사용한다.

```text
.claude/logs/tool-usage.log
```

로그 위치가 다르게 구성되어 있다면 실제 Hook 설정을 기준으로 변경 이력에 기록한다.

```text
실제 로그 위치:
확인 근거:
```

## 기본 수행 순서

| 순서 | 작업 | 목적 |
|---:|---|---|
| 1 | 로그 파일 존재 확인 | Tool 사용 로그 생성 여부 확인 |
| 2 | 작업 시간대 확인 | 현재 변경 작업과 관련된 로그 범위 확인 |
| 3 | 위험 Bash 명령 확인 | 삭제, 초기화, 강제 변경 명령 여부 확인 |
| 4 | 민감 파일 접근 확인 | Secret, key, env 접근 여부 확인 |
| 5 | 운영 명령 확인 | kubectl, helm, docker, compose 영향 확인 |
| 6 | Git 명령 확인 | stage, commit, push 여부 확인 |
| 7 | Hook 차단 여부 확인 | guardrail에 의해 차단된 작업 확인 |
| 8 | 특이 사항 정리 | WARN 또는 FAIL 항목 기록 |
| 9 | 변경 이력 연결 | Change History에 감사 결과 반영 |

## 위험 명령 기준

아래 명령 또는 패턴은 감사 시 주의 대상으로 분류한다.

```text
rm -rf
git reset --hard
git clean -fdx
kubectl delete
kubectl apply
helm upgrade
helm uninstall
docker system prune
docker volume rm
sudo rm
chmod -R 777
chown -R
```

위 명령이 발견되면 다음 항목을 기록한다.

| 항목 | 기록 내용 |
|---|---|
| 명령 | 실제 명령 또는 요약 |
| 실행 여부 | 실행 / 차단 / 미확인 |
| 사용자 승인 여부 | 승인 / 미승인 / 해당 없음 |
| 영향 범위 | 로컬 / 개발 / 운영 / 미확인 |
| 조치 | 진행 / 중단 / 추가 확인 |

## 민감 파일 접근 기준

아래 파일 또는 패턴은 민감 파일로 분류한다.

```text
.env
.pem
.key
.p12
.pfx
id_rsa
id_ed25519
.kube
.aws
.ssh
settings.local.json
claude.json
```

민감 파일 접근이 감지되면 원문을 기록하지 않고 아래 형식으로만 남긴다.

```text
민감 파일 접근 감지: 예
파일 유형: .env / key / pem / 개인 설정
원문 기록 여부: 아니오
조치: 사용자 확인 필요
```

## 운영 명령 기준

아래 명령은 운영 영향 가능성이 있으므로 사용자 승인 여부를 확인한다.

```text
kubectl apply
kubectl delete
kubectl rollout
helm upgrade
helm uninstall
docker compose down
docker compose up -d
docker stop
docker rm
```

운영 명령이 발견되면 다음을 확인한다.

| 항목 | 확인 기준 |
|---|---|
| 실행 환경 | local / dev / stage / prod |
| 사용자 승인 | 승인 여부 |
| 영향 범위 | 서비스, namespace, pod, volume |
| Rollback | 원복 가능성 |
| 결과 | 성공 / 실패 / 차단 / 미확인 |

## Git 명령 감사 기준

Git 관련 명령은 다음 기준으로 확인한다.

| 명령 | 감사 기준 |
|---|---|
| `git add` | Stage 대상 파일이 현재 단계 산출물인지 확인 |
| `git commit` | 사용자 요청 또는 승인 여부 확인 |
| `git push` | 사용자 승인 여부와 대상 브랜치 확인 |
| `git reset` | 강제 원복 여부 확인 |
| `git clean` | 삭제 영향 확인 |

## Tool 사용 로그 확인 명령

로그 파일 존재 여부를 확인한다.

```text
ls -l .claude/logs/tool-usage.log
```

최근 로그를 확인한다.

```text
tail -n 100 .claude/logs/tool-usage.log
```

위험 명령 사용 여부를 확인한다.

```text
grep -E 'rm -rf|git reset --hard|git clean -fdx|kubectl delete|kubectl apply|helm upgrade|helm uninstall|docker system prune|chmod -R 777' .claude/logs/tool-usage.log || true
```

민감 파일 접근 여부를 확인한다.

```text
grep -E '\.env|\.pem|\.key|\.p12|\.pfx|id_rsa|id_ed25519|\.kube|\.aws|\.ssh|settings.local.json|claude.json' .claude/logs/tool-usage.log || true
```

Git 명령 사용 여부를 확인한다.

```text
grep -E 'git add|git commit|git push|git reset|git clean' .claude/logs/tool-usage.log || true
```

## 감사 결과 분류

| 결과 | 의미 | 처리 |
|---|---|---|
| PASS | 위험 작업 없음, 민감 정보 없음 | 변경 이력에 정상 기록 |
| WARN | 확인 필요한 작업 있음 | 사유 기록 후 사용자 확인 |
| FAIL | 위험 작업 또는 민감 정보 처리 문제 있음 | Commit / Push 전 조치 필요 |
| N/A | 로그 없음 또는 해당 없음 | 사유 기록 |

## Tool Usage Audit 출력 형식

Claude Code는 Tool 사용 감사 결과를 아래 형식으로 정리한다.

```text
OpenManager Tool Usage Audit 결과

1. 감사 대상
- 작업 요약:
- 대상 시간대:
- 대상 로그:

2. 로그 파일 확인
- 로그 위치:
- 존재 여부:
- 확인 결과:

3. Bash 사용 확인
- 위험 명령:
- 운영 명령:
- 차단된 명령:

4. 민감 파일 접근 확인
- 민감 파일 접근 여부:
- Secret 원문 기록 여부:
- 조치 필요 여부:

5. Git 명령 확인
- Stage:
- Commit:
- Push:
- 강제 원복 명령:

6. 운영 영향 확인
- Kubernetes:
- Helm:
- Docker:
- 영향 범위:

7. 감사 결과
- PASS:
- WARN:
- FAIL:
- N/A:

8. 변경 이력 반영 항목
- Change History에 기록할 내용:

9. 사용자 확인 필요 사항
-
```

## 실패 또는 경고 시 처리 기준

| 항목 | 처리 |
|---|---|
| 위험 명령 발견 | 사용자 승인 여부 확인, 영향 범위 기록 |
| 민감 파일 접근 발견 | 원문 기록 금지, 접근 사유 확인 |
| 운영 명령 발견 | 환경과 승인 여부 확인 |
| Git Push 발견 | 사용자 승인 여부 확인 |
| 로그 파일 없음 | N/A로 기록하고 사유 작성 |
| Hook 차단 기록 발견 | 차단된 명령과 조치 결과 기록 |

## 금지 사항

- Secret 원문을 출력하지 않는다.
- `.env`, key, pem 내용을 읽거나 기록하지 않는다.
- 개인 설정 파일 내용을 기록하지 않는다.
- 사용자 승인 없이 운영 명령을 실행하지 않는다.
- 사용자 승인 없이 Push를 실행하지 않는다.
- 기존 Hook 파일을 임의 수정하지 않는다.
- 통합 점검 스크립트를 작성하지 않는다.
- 현재 단계와 무관한 전체 상태 점검을 강제하지 않는다.