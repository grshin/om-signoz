# OpenManager OTel Pipeline 변경 시나리오

## 시나리오 목적

OTel Pipeline 변경 요청이 들어왔을 때 Claude Code 하네스가 receiver, processor, exporter, ClickHouse, cardinality 영향을 올바르게 분석하는지 검증한다.

## 사용자 요청 예시

```text
OpenManager에서 서비스별 커스텀 메트릭 attribute를 추가 수집하고 ClickHouse에 저장할 수 있는지 검토해 주세요.
기존 OTel pipeline과 저장 구조를 먼저 검색하고 cardinality 위험을 분석해 주세요.
```

## 요청 유형

| 요청 유형 | 해당 여부 | 판단 근거 |
|---|---:|---|
| Backend Go | 선택 | 조회 API 변경 가능 |
| Frontend React | 선택 | 화면 표시 변경 가능 |
| OTel Pipeline | 예 | attribute 수집과 처리 영향 |
| ClickHouse | 예 | 저장 구조, query, retention 영향 가능 |
| Docker / Kubernetes / Helm | 선택 | collector config 배포 영향 가능 |
| Harness | 아니오 | 하네스 자체 변경 요청 아님 |
| Security / Quality | 예 | 민감 attribute와 검증 기준 필요 |
| Architecture | 예 | pipeline과 storage 구조 영향 |

## 적용 Rule

| Rule | 적용 여부 | 사유 |
|---|---:|---|
| `.claude/rules/om/architecture.md` | 예 | pipeline 구조와 책임 확인 |
| `.claude/rules/om/upstream-boundary.md` | 예 | SigNoz 원본 구조 충돌 방지 |
| `.claude/rules/om/otel-pipeline.md` | 예 | OTel 변경 기준 적용 |
| `.claude/rules/om/security-policy.md` | 예 | 민감 attribute 수집 방지 |
| `.claude/rules/om/quality-gate.md` | 예 | 검증과 품질 기준 적용 |
| `.claude/rules/om/deploy-kubernetes.md` | 선택 | 배포 설정 변경 시 적용 |

## 관련 Skill

| Skill | 적용 여부 | 사용 목적 |
|---|---:|---|
| `om-search-first-analysis` | 예 | 기존 collector, processor, exporter, ClickHouse 검색 |
| `om-change-plan` | 예 | 변경 대상과 승인 항목 정리 |
| `om-change-risk-review` | 예 | cardinality, 저장소, 운영 영향 검토 |
| `om-validation-plan` | 예 | pipeline 검증 계획 작성 |
| `om-implementation-validation` | 예 | 구현 후 검증 결과 정리 |
| `om-quality-gate` | 예 | Commit 전 품질 확인 |
| `om-tool-audit` | 선택 | 배포 명령 또는 운영 명령 사용 여부 확인 |

## 관련 Agent

| Agent | 적용 여부 | 사용 목적 |
|---|---:|---|
| `om-otel-pipeline-reviewer` | 예 | OTel pipeline 변경 검토 |
| `om-architecture-reviewer` | 예 | 구조와 upstream 경계 검토 |
| `om-security-quality-reviewer` | 예 | 보안과 품질 검토 |
| `om-deploy-kubernetes-reviewer` | 선택 | collector 배포 변경 시 검토 |
| `om-backend-go-reviewer` | 선택 | 조회 API 변경 시 검토 |
| `om-frontend-react-reviewer` | 선택 | 화면 변경 시 검토 |

## Search-First 확인 항목

| 확인 항목 | 설명 |
|---|---|
| receiver 설정 | 수집 protocol과 입력 데이터 확인 |
| processor 설정 | attribute 추가, filtering, sampling 확인 |
| exporter 설정 | ClickHouse 저장 흐름 확인 |
| ClickHouse table | 저장 schema, partition, retention 확인 |
| query 영향 | 기존 dashboard, API query 영향 확인 |
| cardinality | label, attribute 증가 위험 확인 |
| deploy config | collector config 배포 방식 확인 |

## Change Plan 확인 항목

| 항목 | 확인 내용 |
|---|---|
| 생성 파일 | 신규 config, migration, 문서 필요 여부 |
| 수정 파일 | collector, processor, exporter, ClickHouse 관련 파일 |
| 제외 파일 | Backend, Frontend 변경 제외 여부 |
| 위험도 | cardinality, storage 비용, query 성능 |
| 검증 계획 | config 검증, sample telemetry, query 영향 확인 |

## 구현 검증 기준

| 검증 항목 | 기준 |
|---|---|
| Pipeline 구조 | receiver → processor → exporter 흐름 유지 |
| Cardinality | attribute 증가로 저장소 폭증 위험 없음 |
| ClickHouse 영향 | table, query, retention 영향 분석됨 |
| 민감 정보 | 개인정보, token, secret attribute 저장 방지 |
| 배포 영향 | config 변경 시 사용자 승인 필요 |
| Rollback | 기존 config로 원복 가능성 확인 |

## Quality Gate 기준

| Gate | 확인 내용 |
|---|---|
| 변경 범위 | OTel, ClickHouse, deploy 관련 파일 중심인지 확인 |
| 민감 파일 | Secret, 인증 정보 미포함 |
| 기존 Agent | SigNoz Playwright Agent 미수정 |
| Stage 파일 | 현재 변경 대상만 포함 |
| Commit 메시지 | OTel Pipeline 변경 목적 포함 |

## 승인 필요 항목

| 항목 | 승인 필요 여부 | 사유 |
|---|---:|---|
| Collector config 변경 | 필요 | 수집 동작 영향 |
| ClickHouse table 변경 | 필요 | 저장 구조 영향 |
| Cardinality 증가 가능성 | 필요 | 저장 비용과 성능 영향 |
| Kubernetes / Helm 반영 | 필요 | 배포 영향 |
| 운영 배포 | 필요 | 운영 반영은 별도 승인 필요 |

## 시나리오 검증 결과 기준

| 항목 | 기대 결과 |
|---|---|
| 요청 유형 분류 | OTel Pipeline과 ClickHouse 중심으로 분류 |
| Rule 선택 | otel-pipeline, architecture, upstream, security, quality 적용 |
| Agent 선택 | om-otel-pipeline-reviewer 중심 |
| Workflow 흐름 | Search-First → Change Plan → Risk Review → Validation → Quality Gate |
| 위험 작업 | 실제 config 적용 없이 승인 필요 항목으로만 기록 |