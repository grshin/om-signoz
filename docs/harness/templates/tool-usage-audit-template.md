# OpenManager Tool Usage Audit 템플릿

## 1. 감사 개요

| 항목 | 내용 |
|---|---|
| 감사 ID |  |
| 감사 일자 |  |
| 감사자 |  |
| 대상 작업 |  |
| 대상 단계 |  |
| 대상 브랜치 | `feature/om-harness-bootstrap` |
| 감사 결과 | PASS / WARN / FAIL / N/A |

## 2. 감사 대상 로그

| 항목 | 내용 |
|---|---|
| 기본 로그 위치 | `.claude/logs/tool-usage.log` |
| 실제 로그 위치 |  |
| 로그 존재 여부 | 있음 / 없음 |
| 확인 시간대 |  |
| 확인 범위 | 최근 100줄 / 전체 / 특정 시간대 |
| 로그 미존재 사유 |  |

## 3. Tool 사용 요약

| Tool 유형 | 사용 여부 | 비고 |
|---|---:|---|
| Bash |  |  |
| Read |  |  |
| Write |  |  |
| Edit |  |  |
| Grep |  |  |
| Glob |  |  |
| Git 명령 |  |  |
| Kubernetes 명령 |  |  |
| Helm 명령 |  |  |
| Docker 명령 |  |  |

## 4. Bash 명령 감사

### 위험 명령 확인

| 위험 명령 패턴 | 감지 여부 | 실행 여부 | 승인 여부 | 조치 |
|---|---:|---:|---:|---|
| `rm -rf` |  |  |  |  |
| `git reset --hard` |  |  |  |  |
| `git clean -fdx` |  |  |  |  |
| `kubectl delete` |  |  |  |  |
| `kubectl apply` |  |  |  |  |
| `helm upgrade` |  |  |  |  |
| `helm uninstall` |  |  |  |  |
| `docker system prune` |  |  |  |  |
| `chmod -R 777` |  |  |  |  |
| `chown -R` |  |  |  |  |

### Bash 감사 결과

```text
위험 명령 사용 여부:
차단된 명령:
사용자 승인 여부:
추가 확인 사항:
```

## 5. 민감 파일 접근 감사

아래 파일 또는 경로가 Tool 사용 로그에 감지되면 원문을 확인하지 않고 접근 여부만 기록합니다.

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

| 민감 파일 유형 | 감지 여부 | 원문 기록 여부 | 조치 |
|---|---:|---:|---|
| `.env` |  | 아니오 |  |
| `.pem` |  | 아니오 |  |
| `.key` |  | 아니오 |  |
| `.p12`, `.pfx` |  | 아니오 |  |
| SSH key |  | 아니오 |  |
| `.kube` |  | 아니오 |  |
| `.aws` |  | 아니오 |  |
| `.ssh` |  | 아니오 |  |
| `settings.local.json` |  | 아니오 |  |
| `claude.json` |  | 아니오 |  |

### 민감 파일 감사 결과

```text
민감 파일 접근 여부:
Secret 원문 기록 여부:
사용자 확인 필요 여부:
조치 필요 사항:
```

## 6. 운영 명령 감사

| 운영 명령 | 감지 여부 | 실행 환경 | 승인 여부 | 영향 범위 | 결과 |
|---|---:|---|---:|---|---|
| `kubectl apply` |  |  |  |  |  |
| `kubectl delete` |  |  |  |  |  |
| `kubectl rollout` |  |  |  |  |  |
| `helm upgrade` |  |  |  |  |  |
| `helm uninstall` |  |  |  |  |  |
| `docker compose down` |  |  |  |  |  |
| `docker compose up -d` |  |  |  |  |  |
| `docker stop` |  |  |  |  |  |
| `docker rm` |  |  |  |  |  |

### 운영 영향 감사 결과

```text
운영 명령 사용 여부:
실행 환경:
사용자 승인 여부:
영향 범위:
Rollback 필요 여부:
추가 확인 사항:
```

## 7. Git 명령 감사

| Git 명령 | 감지 여부 | 승인 여부 | 대상 | 결과 |
|---|---:|---:|---|---|
| `git add` |  |  |  |  |
| `git commit` |  |  |  |  |
| `git push` |  |  |  |  |
| `git reset` |  |  |  |  |
| `git clean` |  |  |  |  |
| `git checkout` |  |  |  |  |
| `git restore` |  |  |  |  |

### Git 감사 결과

```text
Stage 수행 여부:
Commit 수행 여부:
Push 수행 여부:
강제 원복 명령 여부:
사용자 승인 필요 여부:
```

## 8. Hook 차단 기록

| 항목 | 결과 | 비고 |
|---|---|---|
| 위험 Bash 차단 기록 | 있음 / 없음 |  |
| 민감 파일 접근 차단 기록 | 있음 / 없음 |  |
| Tool 사용 로그 기록 | 있음 / 없음 |  |
| 차단 후 재시도 여부 | 있음 / 없음 |  |

### 차단 기록 상세

```text
차단된 명령 또는 파일:
차단 사유:
사용자 확인 여부:
후속 조치:
```

## 9. 감사 결과 분류

| 결과 | 내용 |
|---|---|
| PASS |  |
| WARN |  |
| FAIL |  |
| N/A |  |

## 10. Change History 반영 항목

아래 내용을 Change History에 반영합니다.

```text
Tool 사용 로그 위치:
위험 명령 여부:
민감 파일 접근 여부:
운영 명령 여부:
Git 명령 여부:
사용자 승인 필요 사항:
감사 결과:
```

## 11. 사용자 확인 필요 사항

| 항목 | 확인 필요 여부 | 내용 |
|---|---:|---|
| 위험 명령 사용 |  |  |
| 민감 파일 접근 |  |  |
| 운영 명령 사용 |  |  |
| Git Push 수행 |  |  |
| Hook 차단 기록 |  |  |
| 로그 파일 없음 |  |  |

## 12. 감사 결과 최종 요약

```text
Tool 사용 감사 결과를 요약한다.
Secret 원문, 인증 정보, 개인 설정 파일 내용은 기록하지 않는다.
WARN 또는 FAIL이 있으면 Commit / Push 전에 조치한다.
```