# OpenManager Change History Workflow

## 문서 목적

본 문서는 OpenManager 고도화 작업에서 변경 이력을 기록하는 절차를 정의한다.

Change History는 다음 원칙을 따른다.

- 변경 작업은 사용자 요청에서 시작된다.
- 구현 전 Search-First 분석과 Change Plan 여부를 기록한다.
- 구현 후 검증 결과와 Quality Gate 결과를 기록한다.
- Commit / Push 여부와 메시지를 기록한다.
- 운영 영향, 보안 영향, 사용자 승인 필요 항목을 기록한다.
- 감사 추적이 가능하도록 변경 근거를 남긴다.

## 적용 대상

이 Workflow는 다음 작업에 적용한다.

| 작업 유형 | 적용 여부 |
|---|---:|
| Backend Go 변경 | 적용 |
| Frontend React 변경 | 적용 |
| OTel Pipeline 변경 | 적용 |
| Docker / Kubernetes / Helm 변경 | 적용 |
| 하네스 Rule / Skill / Agent 변경 | 적용 |
| Hook / Guardrail 변경 | 적용 |
| Workflow / Template 변경 | 적용 |
| 문서 변경 | 선택 적용 |
| 단순 질의 응답 | 미적용 |

## 기본 수행 순서

| 순서 | 작업 | 목적 |
|---:|---|---|
| 1 | 요청 식별 | 사용자 요청 요약 |
| 2 | 작업 유형 분류 | 변경 영역 구분 |
| 3 | Search-First 결과 확인 | 구현 전 분석 여부 확인 |
| 4 | Change Plan 결과 확인 | 구현 전 계획 여부 확인 |
| 5 | 변경 파일 기록 | 생성, 수정, 삭제, 제외 파일 정리 |
| 6 | 검증 결과 기록 | Implementation Validation 결과 정리 |
| 7 | Quality Gate 결과 기록 | Commit / Push 전 품질 확인 |
| 8 | Tool 사용 로그 위치 기록 | 감사 추적 근거 연결 |
| 9 | Commit / Push 기록 | Git 이력 연결 |
| 10 | 승인 필요 항목 기록 | 사용자 확인 또는 보류 사항 정리 |

## 변경 이력 기록 단위

변경 이력은 하나의 사용자 요청 또는 하나의 단계 작업을 기준으로 작성한다.

| 기록 단위 | 예시 |
|---|---|
| 단계 작업 | 13단계 변경 이력 및 감사 추적 구성 |
| 기능 변경 | Backend API 응답 필드 추가 |
| 화면 변경 | Frontend 대시보드 필터 개선 |
| 배포 변경 | Helm values 설정 추가 |
| 하네스 변경 | Skill, Agent, Workflow 추가 |
| 문서 변경 | RunBook 또는 Inventory 문서 갱신 |

## 기록 대상 항목

Change History에는 다음 항목을 기록한다.

| 항목 | 설명 |
|---|---|
| 요청 요약 | 사용자의 요청을 한 문장으로 정리 |
| 작업 유형 | Backend, Frontend, OTel, Deploy, Harness, Docs |
| 관련 Spec | 10단계 Spec 기반 요청 여부 |
| Search-First | 11단계 Search-First 분석 여부 |
| Change Plan | 11단계 Change Plan 작성 여부 |
| 구현 변경 파일 | 생성, 수정, 삭제, 제외 파일 |
| 검증 결과 | 12단계 Implementation Validation 결과 |
| Quality Gate 결과 | 12단계 Quality Gate 결과 |
| Tool 사용 로그 | 06단계 Tool usage log 기준 |
| Commit 메시지 | 실제 또는 권장 Commit 메시지 |
| Push 여부 | 원격 저장소 반영 여부 |
| 승인 필요 항목 | 사용자 승인 또는 보류 사항 |
| 보안 확인 | 민감 파일, Secret 포함 여부 |
| 기존 구조 보존 | SigNoz Playwright Agent, upstream 영향 |

## 변경 파일 분류 기준

| 구분 | 설명 |
|---|---|
| 생성 | 새로 추가한 파일 |
| 수정 | 기존 내용을 변경한 파일 |
| 삭제 | 제거한 파일 |
| 이동 | 경로가 변경된 파일 |
| 제외 | 요청 범위에서 명시적으로 제외한 파일 |

## 관련 Workflow 연결

Change History는 이전 단계 Workflow 결과와 연결한다.

| 단계 | 연결 대상 |
|---|---|
| 10단계 | Spec 기반 개발 요청 템플릿 |
| 11단계 | Search-First 분석 결과, Change Plan |
| 12단계 | Implementation Validation 결과, Quality Gate 결과 |
| 13단계 | Change History, Tool Usage Audit |

## Tool 사용 로그 연결 기준

06단계에서 구성한 Tool 사용 로그를 변경 이력의 감사 근거로 사용한다.

기본 로그 위치는 아래 경로를 기준으로 한다.

```text
.claude/logs/tool-usage.log
```

로그 파일이 없거나 아직 생성되지 않은 경우에는 아래처럼 기록한다.

```text
Tool 사용 로그: 현재 시점에 생성된 로그 없음
사유: 해당 작업에서 Hook 로그가 발생하지 않았거나 Claude Code 세션에서 Tool 사용 기록이 남지 않음
```

## 보안 및 민감 정보 확인 기준

변경 이력에는 다음 항목을 기록한다.

| 항목 | 확인 기준 |
|---|---|
| `.env` 포함 여부 | Git 변경 대상에 포함되면 안 됨 |
| `.pem`, `.key` 포함 여부 | Git 변경 대상에 포함되면 안 됨 |
| `settings.local.json` 포함 여부 | Git 추적 대상에 포함되면 안 됨 |
| Secret 유사 문자열 | token, password, api key 등 포함 여부 확인 |
| 인증 정보 | 원문 기록 금지 |
| 개인 설정 | Git 이력에 포함 금지 |

## 기존 SigNoz 구조 보존 확인

아래 파일은 의도 없이 수정되어서는 안 된다.

```text
.claude/agents/playwright-test-planner.md
.claude/agents/playwright-test-generator.md
.claude/agents/playwright-test-healer.md
```

변경 이력에는 기존 Agent 보존 여부를 기록한다.

```text
기존 SigNoz Playwright Agent: 미수정
```

변경이 감지된 경우에는 의도 여부와 사유를 반드시 기록한다.

## Change History 출력 형식

Claude Code는 변경 이력을 아래 형식으로 정리한다.

```text
OpenManager Change History

1. 요청 요약
-

2. 작업 유형
- Backend:
- Frontend:
- OTel:
- Deploy:
- Harness:
- Docs:

3. 관련 사전 절차
- Spec 기반 요청:
- Search-First 분석:
- Change Plan:

4. 변경 파일
- 생성:
- 수정:
- 삭제:
- 제외:

5. 검증 결과
- Implementation Validation:
- Quality Gate:
- 단계 전용 점검 스크립트:

6. 보안 확인
- 민감 파일 포함 여부:
- Secret 유사 문자열:
- 개인 설정 파일 포함 여부:

7. 기존 구조 보존
- SigNoz Playwright Agent:
- upstream 영향:

8. Tool 사용 로그
- 로그 위치:
- 확인 결과:
- 특이 사항:

9. Git 이력
- Commit 여부:
- Commit 메시지:
- Push 여부:
- 대상 브랜치:

10. 사용자 승인 및 보류 항목
- 승인 완료:
- 승인 필요:
- 보류:
```

## 금지 사항

- Secret 원문을 변경 이력에 기록하지 않는다.
- 인증 토큰, password, api key를 기록하지 않는다.
- 개인 로컬 설정 내용을 기록하지 않는다.
- `.claude/settings.local.json`을 Git 추적 대상으로 만들지 않는다.
- 기존 SigNoz Playwright Agent를 임의 수정하지 않는다.
- 통합 점검 스크립트를 작성하지 않는다.
- 현재 단계와 무관한 전체 점검을 강제하지 않는다.