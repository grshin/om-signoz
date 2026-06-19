# SigNoz OSS Feature Inventory Template

## 1. 문서 정보

| 항목 | 내용 |
|---|---|
| 작성일 | YYYY-MM-DD |
| 작성자 |  |
| 분석 대상 브랜치 |  |
| 분석 대상 Commit |  |
| 분석 목적 |  |

## 2. 기능 영역 요약

| 구분 | 기능 영역 | 주요 설명 | OpenManager 활용 가능성 |
|---|---|---|---|
| 1 | Dashboard |  |  |
| 2 | Metrics |  |  |
| 3 | Traces |  |  |
| 4 | Logs |  |  |
| 5 | Alerts |  |  |
| 6 | OTel Collector |  |  |
| 7 | Query Service |  |  |
| 8 | Frontend UI |  |  |
| 9 | Deploy / Helm |  |  |
| 10 | Auth / RBAC |  |  |

## 3. 기능별 상세 분석

### 3.1 기능명

| 항목 | 내용 |
|---|---|
| 기능명 |  |
| 기능 설명 |  |
| 관련 화면 |  |
| 관련 API |  |
| 관련 Backend 경로 |  |
| 관련 Frontend 경로 |  |
| 관련 OTel / Collector 경로 |  |
| 관련 Deploy 경로 |  |
| 관련 문서 |  |

### 3.2 현재 기능 상태

| 점검 항목 | 내용 |
|---|---|
| 기능 제공 여부 | 제공 / 일부 제공 / 미제공 |
| 사용 가능 수준 | 바로 사용 가능 / 설정 필요 / 개선 필요 / 신규 개발 필요 |
| OpenManager 관점 적합성 | 높음 / 보통 / 낮음 |
| UI 개선 필요 여부 | 있음 / 없음 |
| API 개선 필요 여부 | 있음 / 없음 |
| OTel Pipeline 개선 필요 여부 | 있음 / 없음 |
| 배포 설정 개선 필요 여부 | 있음 / 없음 |
| 보안 검토 필요 여부 | 있음 / 없음 |

### 3.3 OpenManager 관점 판단

| 분류 | 판단 |
|---|---|
| 그대로 활용 |  |
| 설정으로 해결 |  |
| OpenManager 확장으로 해결 |  |
| Adapter API로 해결 |  |
| SigNoz API 활용 |  |
| SigNoz OSS 직접 수정 필요 |  |
| 수정 금지 또는 보류 |  |

## 4. 관련 파일 목록

아래 형식으로 관련 파일을 작성한다.

    frontend/src/...
    pkg/...
    cmd/...
    deploy/...
    charts/...

## 5. 개선 후보

| 번호 | 개선 후보 | 유형 | 우선순위 | 근거 |
|---|---|---|---|---|
| 1 |  | UI 개선 / API 개선 / 설정 개선 / 신규 기능 / 문서 보강 | High / Medium / Low |  |

## 6. HarnessOps 바이브 코딩 후보 여부

| 항목 | 판단 |
|---|---|
| 작은 단위로 구현 가능한가 | 예 / 아니오 |
| Search-First 분석이 가능한가 | 예 / 아니오 |
| Change Plan으로 범위 제한이 가능한가 | 예 / 아니오 |
| 검증 방법이 명확한가 | 예 / 아니오 |
| Hook / Quality Gate / Audit 검증에 적합한가 | 예 / 아니오 |
| Pilot 후보로 적합한가 | 예 / 아니오 |

## 7. 메모

분석 중 확인한 내용, 의사결정 필요 사항, 추후 확인 사항을 작성한다.