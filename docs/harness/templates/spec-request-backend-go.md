# OpenManager Backend Go Spec 요청 템플릿

## 1. 요청 개요

| 항목 | 내용 |
|---|---|
| 요청 제목 |  |
| Backend 변경 유형 | API / Service / Query / Model / Storage / Auth / 기타 |
| 대상 경로 |  |
| 관련 Frontend 여부 | 없음 / 있음 |
| 관련 ClickHouse 여부 | 없음 / 있음 |
| 관련 OTel Pipeline 여부 | 없음 / 있음 |

## 2. 적용 Rule 및 Agent

| 구분 | 대상 |
|---|---|
| 공통 Rule | architecture, upstream-boundary, security-policy, quality-gate |
| 경로 Rule | backend-go |
| 관련 Skill | om-project-context, om-rule-router, om-validation-plan |
| 관련 Agent | om-backend-go-reviewer, om-architecture-reviewer, om-security-quality-reviewer |

## 3. Backend 요구사항

### API 변경

```text
- Endpoint:
- Method:
- Request:
- Response:
- Error:
```

### Service 변경

```text
- Service 책임:
- 기존 로직과의 관계:
- 새로 추가되는 처리:
- 제거 또는 변경되는 처리:
```

### Query / Storage 변경

```text
- 대상 저장소:
- 대상 테이블 또는 View:
- Query 변경 내용:
- 성능 영향:
- 호환성 영향:
```

## 4. 호환성 검토

| 항목 | 검토 내용 |
|---|---|
| 기존 SigNoz API 영향 |  |
| Frontend 호출부 영향 |  |
| ClickHouse Query 영향 |  |
| OTel Pipeline 영향 |  |
| upstream 병합 영향 |  |

## 5. 보안 검토

```text
- 인증 또는 권한 변경 여부:
- 민감 데이터 처리 여부:
- 로그 출력 주의 사항:
- 외부 시스템 호출 여부:
```

## 6. 검증 계획

| 검증 항목 | 명령 또는 방법 |
|---|---|
| 변경 파일 확인 | `git diff --name-only` |
| Go 문법 확인 |  |
| 단위 테스트 |  |
| API 수동 확인 |  |
| Query 검증 |  |
| 단계 전용 점검 | 해당 단계 점검 스크립트 |

## 7. Claude Code 요청 문장

```text
om-backend-go-reviewer를 사용해서 이 Backend Go Spec을 검토해 주세요.
바로 구현하지 말고 API 영향, service 책임, query/storage 영향, 보안 위험, 검증 계획을 먼저 정리해 주세요.
```