---
paths:
  - "conf/**/*"
  - "**/*otel*.yaml"
  - "**/*otel*.yml"
  - "**/*opentelemetry*.yaml"
  - "**/*opentelemetry*.yml"
  - "**/*collector*.yaml"
  - "**/*collector*.yml"
  - "deploy/**/*otel*"
  - "deploy/**/*collector*"
---

# OpenManager OpenTelemetry Pipeline 규칙

## 적용 범위

이 Rule은 OpenTelemetry Collector와 Telemetry Pipeline 관련 설정을 작업할 때 적용합니다.

## 기본 원칙

- Logs, Metrics, Traces 신호를 구분합니다.
- 기존 Receiver, Processor, Exporter, Extension 구성을 먼저 확인합니다.
- Pipeline 순서를 임의로 변경하지 않습니다.
- 기존 데이터 흐름과 호환성을 유지합니다.
- Endpoint, Token, Credential 값을 출력하지 않습니다.
- 운영환경 설정은 사용자의 승인 없이 변경하지 않습니다.

## 변경 전 확인

Pipeline 설정을 수정하기 전에 다음 내용을 보고합니다.

| 항목 | 확인 내용 |
|---|---|
| 대상 신호 | Logs, Metrics, Traces |
| Receiver | 데이터 수신 방식 |
| Processor | 필터, 배치, 변환, 메모리 제한 |
| Exporter | 데이터 전달 대상 |
| Extension | 인증, Health Check 등 |
| 영향 범위 | 수집, 처리, 저장, 조회 영향 |
| 롤백 방법 | 기존 설정 복구 방식 |

## 변경 원칙

- OM 전용 요구사항은 가능한 범위에서 별도 설정으로 분리합니다.
- 기존 Pipeline을 제거하지 않습니다.
- Processor 순서 변경 시 영향 범위를 설명합니다.
- Sampling, Filtering, Attribute 변환은 데이터 유실 가능성을 먼저 검토합니다.
- Secret 값은 설정 파일에 직접 기록하지 않습니다.

## 검증 원칙

변경한 설정 파일에 맞는 검증을 수행합니다.

```text
YAML 또는 설정 문법 확인
변경 전후 Diff 확인
Receiver, Processor, Exporter 연결 관계 확인
Logs, Metrics, Traces별 영향 범위 확인
운영 반영 전 개발환경 검증
```

실제 Collector 실행이나 운영 반영은 사용자의 명시적인 승인 후 진행합니다.