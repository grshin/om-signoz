# OpenManager OTel Pipeline Spec 요청 템플릿

## 1. 요청 개요

| 항목 | 내용 |
|---|---|
| 요청 제목 |  |
| 변경 유형 | Receiver / Processor / Exporter / Collector Config / Schema / Query / Retention |
| Telemetry 유형 | Metrics / Logs / Traces / Events |
| 관련 ClickHouse 여부 | 없음 / 있음 |
| 관련 Backend 여부 | 없음 / 있음 |
| 관련 Deploy 여부 | 없음 / 있음 |

## 2. 적용 Rule 및 Agent

| 구분 | 대상 |
|---|---|
| 공통 Rule | architecture, upstream-boundary, security-policy, quality-gate |
| 경로 Rule | otel-pipeline, backend-go, deploy-kubernetes |
| 관련 Skill | om-project-context, om-rule-router, om-validation-plan |
| 관련 Agent | om-otel-pipeline-reviewer, om-backend-go-reviewer, om-deploy-kubernetes-reviewer |

## 3. Pipeline 요구사항

### 수집

```text
- 수집 대상:
- Protocol:
- Receiver:
- 예상 수집량:
- Cardinality 위험:
```

### 처리

```text
- Processor:
- Attribute 처리:
- Filtering:
- Sampling:
- Enrichment:
```

### 저장

```text
- Exporter:
- ClickHouse table:
- Materialized View:
- Retention:
- Query 영향:
```

## 4. 영향 검토

| 항목 | 검토 내용 |
|---|---|
| Metrics 영향 |  |
| Logs 영향 |  |
| Traces 영향 |  |
| ClickHouse 저장소 영향 |  |
| Query 성능 영향 |  |
| 배포 설정 영향 |  |

## 5. 위험 검토

```text
- Cardinality 증가 위험:
- Storage 증가 위험:
- Query 지연 위험:
- Collector 부하 위험:
- 기존 SigNoz 호환성 위험:
```

## 6. 검증 계획

| 검증 항목 | 명령 또는 방법 |
|---|---|
| 변경 파일 확인 | git diff --name-only |
| Config 문법 확인 |  |
| Local Collector 확인 |  |
| Query 확인 |  |
| 배포 영향 확인 |  |
| 단계 전용 점검 | 해당 단계 점검 스크립트 |

## 7. Claude Code 요청 문장

```text
om-otel-pipeline-reviewer를 사용해서 이 OTel Pipeline Spec을 검토해 주세요.
바로 구현하지 말고 telemetry 흐름, ClickHouse 영향, cardinality 위험, 배포 영향, 검증 계획을 먼저 정리해 주세요.
```