# OpenManager Implementation Validation Workflow

## 문서 목적

본 문서는 OpenManager 고도화 작업에서 구현 완료 후 수행해야 하는 검증 절차를 정의한다.

Implementation Validation은 다음 원칙을 따른다.

- 구현 후에는 변경 범위를 먼저 확인한다.
- 문법 오류, 테스트 실패, 빌드 실패를 Commit 전에 확인한다.
- 변경 영역에 맞는 검증만 수행한다.
- 현재 단계 전용 점검 스크립트만 실행한다.
- 통합 점검 스크립트는 작성하지 않는다.
- 검증 결과를 기록한 뒤 Quality Gate로 넘긴다.

## 적용 대상

이 Workflow는 다음 작업에 적용한다.

| 작업 유형 | 적용 여부 |
|---|---:|
| Backend Go 구현 | 적용 |
| Frontend React 구현 | 적용 |
| OTel Pipeline 변경 | 적용 |
| Docker / Kubernetes / Helm 변경 | 적용 |
| 하네스 Rule / Skill / Agent 변경 | 적용 |
| Hook / Guardrail 변경 | 적용 |
| 문서 변경 | 선택 적용 |
| 단순 질의 응답 | 미적용 |

## 기본 수행 순서

| 순서 | 작업 | 목적 |
|---:|---|---|
| 1 | 변경 파일 확인 | 실제 변경 범위 파악 |
| 2 | 변경 유형 분류 | Backend / Frontend / OTel / Deploy / Harness / Docs 구분 |
| 3 | 적용 Rule 재확인 | 05단계 Rule 기준 검증 |
| 4 | 관련 Agent 검토 | 09단계 전문 Agent 기준 영향 검토 |
| 5 | 문법 확인 | Shell, Markdown, JSON, YAML, Go, TypeScript 등 |
| 6 | 테스트 또는 빌드 확인 | 변경 영역별 검증 명령 수행 |
| 7 | 보안 위험 확인 | Secret, 개인 설정, 인증 정보 포함 여부 확인 |
| 8 | 기존 Agent 보존 확인 | SigNoz Playwright Agent 미수정 확인 |
| 9 | 단계 전용 점검 스크립트 실행 | 해당 단계 산출물만 확인 |
| 10 | 검증 결과 정리 | Quality Gate로 넘길 결과 작성 |

## 변경 파일 확인 기준

구현 후 먼저 아래 항목을 확인한다.

```text
git status --short
git diff --name-only
git diff --stat
```

Stage 이후에는 아래 항목도 확인한다.

```text
git diff --cached --name-only
git diff --cached --stat
```

확인해야 할 내용은 다음과 같다.

| 항목 | 확인 기준 |
|---|---|
| 변경 파일 수 | 요청 범위와 일치하는가 |
| 변경 경로 | 의도한 경로만 변경되었는가 |
| 생성 파일 | 불필요한 파일이 추가되지 않았는가 |
| 삭제 파일 | 의도하지 않은 삭제가 없는가 |
| 개인 설정 파일 | `.claude/settings.local.json`, `.env`, key 파일이 포함되지 않았는가 |

## 변경 유형별 검증 기준

### Harness 문서 변경

| 검증 항목 | 검증 방법 |
|---|---|
| 파일 존재 | `ls -l <file>` |
| 문서 필수 항목 | `grep` 또는 수동 확인 |
| Markdown 구조 | 제목, 표, 코드블록 확인 |
| Secret 문자열 | Secret 유사 문자열 검사 |
| 단계 전용 점검 | 해당 단계 점검 스크립트 실행 |

### Skill 변경

| 검증 항목 | 검증 방법 |
|---|---|
| `SKILL.md` 존재 | 파일 존재 확인 |
| frontmatter 시작/종료 | `---` 확인 |
| `name` | Skill 이름 확인 |
| `description` | Skill 설명 확인 |
| `allowed-tools` | 허용 도구 확인 |
| 자동 호출 여부 | `disable-model-invocation` 필요 여부 확인 |

### Agent 변경

| 검증 항목 | 검증 방법 |
|---|---|
| Agent 파일 존재 | `.claude/agents/om/*.md` 확인 |
| frontmatter | `name`, `description`, `tools` 확인 |
| 도구 제한 | `Edit`, `Write` 포함 여부 확인 |
| 기존 Agent 보존 | Playwright Agent 미수정 확인 |

### Hook 변경

| 검증 항목 | 검증 방법 |
|---|---|
| Shell 문법 | `bash -n <script>` |
| 실행 권한 | `test -x <script>` |
| 위험 명령 차단 | smoke test |
| 민감 파일 차단 | smoke test |
| 로그 기록 | smoke test |

### Backend Go 변경

| 검증 항목 | 검증 방법 |
|---|---|
| 변경 파일 확인 | `git diff --name-only` |
| Go 문법 | 대상 패키지 기준 확인 |
| 단위 테스트 | 가능한 범위에서 `go test` |
| API 영향 | request / response 영향 확인 |
| Query 영향 | ClickHouse query 영향 확인 |
| Error 처리 | context, timeout, logging 확인 |

### Frontend React 변경

| 검증 항목 | 검증 방법 |
|---|---|
| 변경 파일 확인 | `git diff --name-only` |
| TypeScript 확인 | 가능한 범위에서 type check |
| Lint | 가능한 범위에서 lint |
| Build | 가능한 범위에서 build |
| UI 수동 확인 | 화면, route, component 동작 확인 |
| API 연동 | loading, error, empty data 확인 |

### OTel Pipeline 변경

| 검증 항목 | 검증 방법 |
|---|---|
| 변경 파일 확인 | `git diff --name-only` |
| Collector 설정 | receiver, processor, exporter 확인 |
| Telemetry 영향 | Metrics, Logs, Traces 영향 확인 |
| ClickHouse 영향 | table, view, query, retention 확인 |
| Cardinality 위험 | label, attribute 증가 위험 확인 |
| 배포 영향 | values, config, manifest 영향 확인 |

### Deploy Kubernetes 변경

| 검증 항목 | 검증 방법 |
|---|---|
| YAML 문법 | 가능한 범위에서 YAML 확인 |
| Helm template | 필요한 경우 사용자 승인 후 수행 |
| Dry-run | 필요한 경우 사용자 승인 후 수행 |
| Secret 영향 | Secret 값 조회 없이 영향만 확인 |
| Rollback 가능성 | 원복 경로와 절차 확인 |
| 운영 영향 | namespace, service, ingress, pvc 영향 확인 |

## 금지 또는 승인 필요 작업

Implementation Validation 단계에서는 아래 기준을 따른다.

| 작업 | 기준 |
|---|---|
| 운영 배포 명령 | 사용자 승인 전 금지 |
| `kubectl apply` | 사용자 승인 전 금지 |
| `helm upgrade` | 사용자 승인 전 금지 |
| Secret 원문 조회 | 금지 |
| `.env`, key, pem 파일 읽기 | 금지 |
| `git reset --hard` | 금지 |
| `git clean -fdx` | 금지 |
| 통합 점검 스크립트 작성 | 금지 |
| 현재 단계 외 점검 강제 실행 | 금지 |

## 검증 결과 출력 형식

Claude Code는 구현 검증 후 아래 형식으로 결과를 정리한다.

```text
OpenManager 구현 검증 결과

1. 변경 요약
-

2. 변경 파일
- 생성:
- 수정:
- 삭제:
- 제외:

3. 변경 유형
- Backend:
- Frontend:
- OTel:
- Deploy:
- Harness:
- Docs:

4. 수행한 검증
- 문법:
- 테스트:
- 빌드:
- 수동 확인:
- 단계 전용 점검 스크립트:

5. 검증 결과
- PASS:
- WARN:
- FAIL:

6. 보안 확인
- 민감 파일 포함 여부:
- Secret 유사 문자열:
- 개인 설정 파일 포함 여부:

7. 기존 SigNoz 보존 확인
- Playwright Agent:
- upstream 영향:

8. Quality Gate 진행 가능 여부
- 가능 / 불가

9. 추가 조치 필요 사항
-
```