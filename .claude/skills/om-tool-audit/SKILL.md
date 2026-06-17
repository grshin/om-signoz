---
name: OpenManager Tool Usage Audit
description: OpenManager 변경 작업 중 Claude Code Tool 사용 로그를 확인하고 위험 명령, 민감 파일 접근, 운영 명령, Git 명령 사용 여부를 감사할 때 사용한다.
when_to_use: Commit 전, Push 전, 변경 이력 작성 전, Tool 사용 로그 기반 감사 결과를 정리해야 할 때 사용한다.
disable-model-invocation: true
allowed-tools: Read Grep Glob Bash
---

# OpenManager Tool Usage Audit Skill

## 목적

OpenManager 변경 작업 중 발생한 Tool 사용 로그를 확인하고 감사 결과를 정리한다.

이 Skill은 위험 명령, 민감 파일 접근, 운영 명령, Git 명령 사용 여부를 확인하여 변경 이력에 연결할 감사 근거를 만든다.

## 사용 방식

사용자가 다음과 같이 직접 호출한다.

```text
/om-tool-audit 13단계 작업의 Tool 사용 로그를 감사해 주세요.
```

```text
/om-tool-audit Commit 전에 위험 명령과 민감 파일 접근 여부를 확인해 주세요.
```

```text
/om-tool-audit Tool 사용 로그를 확인하고 Change History에 반영할 감사 결과를 정리해 주세요.
```

## 참조 Workflow 및 Template

| 구분 | 경로 |
|---|---|
| Tool Usage Audit Workflow | `docs/harness/workflows/tool-usage-audit-workflow.md` |
| Tool Usage Audit Template | `docs/harness/templates/tool-usage-audit-template.md` |
| Change History Workflow | `docs/harness/workflows/change-history-workflow.md` |
| Change History Template | `docs/harness/templates/change-history-template.md` |

## 수행 절차

1. Tool 사용 로그 파일 존재 여부를 확인한다.
2. 현재 작업과 관련된 로그 확인 범위를 정한다.
3. 위험 Bash 명령 사용 여부를 확인한다.
4. 민감 파일 접근 여부를 확인한다.
5. 운영 명령 사용 여부를 확인한다.
6. Git 명령 사용 여부를 확인한다.
7. Hook 차단 기록 여부를 확인한다.
8. 감사 결과를 PASS, WARN, FAIL, N/A로 분류한다.
9. Change History에 반영할 항목을 정리한다.
10. 사용자 확인 필요 사항을 정리한다.

## 기본 로그 위치

06단계 Tool 사용 로그 Hook 기준으로 아래 경로를 기본 로그 위치로 사용한다.

```text
.claude/logs/tool-usage.log
```

로그 파일이 없는 경우에는 실패로 단정하지 않고 N/A로 분류한다.

```text
로그 파일 없음
분류: N/A
사유: 해당 작업에서 Tool 사용 로그가 아직 생성되지 않았거나 Hook 기록 대상 작업이 없었음
```

## 감사 대상

| 감사 항목 | 확인 내용 |
|---|---|
| Bash 사용 | 위험 명령, 운영 명령 실행 여부 |
| Read 사용 | 민감 파일 접근 여부 |
| Write / Edit 사용 | 변경 파일 범위 |
| Grep / Glob 사용 | 검색 대상 |
| Git 명령 | add, commit, push, reset, clean 사용 여부 |
| Kubernetes 명령 | kubectl 사용 여부 |
| Helm 명령 | helm 사용 여부 |
| Docker 명령 | docker, docker compose 사용 여부 |
| Hook 차단 | 위험 명령 또는 민감 파일 차단 여부 |

## 위험 명령 기준

아래 패턴은 주의 대상으로 확인한다.

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

## 민감 파일 기준

아래 파일 또는 경로는 민감 파일로 분류한다.

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

민감 파일 접근이 감지되면 원문을 읽거나 기록하지 않는다.

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

## 권장 확인 명령

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
grep -E 'rm -rf|git reset --hard|git clean -fdx|kubectl delete|kubectl apply|helm upgrade|helm uninstall|docker system prune|chmod -R 777|chown -R' .claude/logs/tool-usage.log || true
```

민감 파일 접근 여부를 확인한다.

```text
grep -E '\.env|\.pem|\.key|\.p12|\.pfx|id_rsa|id_ed25519|\.kube|\.aws|\.ssh|settings.local.json|claude.json' .claude/logs/tool-usage.log || true
```

Git 명령 사용 여부를 확인한다.

```text
grep -E 'git add|git commit|git push|git reset|git clean|git checkout|git restore' .claude/logs/tool-usage.log || true
```

## 감사 결과 분류

| 결과 | 의미 |
|---|---|
| PASS | 위험 작업, 민감 파일 접근, 승인 없는 운영 명령이 없음 |
| WARN | 확인이 필요한 항목이 있으나 즉시 실패로 보기 어려움 |
| FAIL | 위험 작업, 민감 정보 처리 문제, 승인 없는 운영 명령이 있음 |
| N/A | 로그가 없거나 해당 작업에서 감사 대상 로그가 없음 |

## 출력 형식

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

## 금지 사항

- Secret 원문을 출력하지 않는다.
- `.env`, key, pem 내용을 읽거나 기록하지 않는다.
- 개인 설정 파일 내용을 기록하지 않는다.
- 사용자 승인 없이 운영 명령을 실행하지 않는다.
- 사용자 승인 없이 Push를 실행하지 않는다.
- 기존 Hook 파일을 임의 수정하지 않는다.
- 통합 점검 스크립트를 작성하지 않는다.