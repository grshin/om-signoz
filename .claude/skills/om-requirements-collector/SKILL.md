---
name: OpenManager Requirements Collector
description: OpenManager HarnessOps에서 사용자 요청, Jira Issue, 회의 메모, 고객 요청을 기능별 요구사항으로 수집하고 정리할 때 사용한다.
when_to_use: 기능 요구사항 수집, 비기능 요구사항 분리, 화면/API/데이터/권한/연동 요구사항 정리, Acceptance Criteria 초안 작성, Spec 작성 전 요구사항 정리가 필요할 때 사용한다.
allowed-tools: Read Grep Glob
---

# OpenManager Requirements Collector Skill

## 목적

OpenManager HarnessOps 환경에서 사용자 요청, Jira Issue, 회의 메모, 고객 요청을 기능별 요구사항으로 수집하고 정리한다.

이 Skill은 요구사항을 바로 구현하지 않는다.

요구사항을 구조화한 뒤 Feature List, Spec 요청, Search-First 분석, Change Plan으로 연결한다.

## 참조 문서

우선 다음 문서를 확인한다.

```text
docs/harness/templates/requirements-collection-template.md
docs/harness/features/OPENMANAGER_FEATURE_LIST.md
docs/harness/templates/spec-request-common.md
docs/harness/workflows/search-first-analysis-workflow.md
docs/harness/workflows/change-plan-workflow.md
docs/harness/SKILLS_INVENTORY.md
```

## 입력 대상

다음 입력을 요구사항 수집 대상으로 본다.

| 입력 | 설명 |
|---|---|
| 사용자 직접 요청 | 대화창에서 전달된 기능 요청 |
| Jira Issue | Summary, Description, Acceptance Criteria |
| 회의 메모 | 회의 중 나온 개선 요구 |
| 고객 요청 | 고객사 또는 운영팀의 개선 요청 |
| 내부 개선안 | 개발팀, 운영팀, PM의 개선 아이디어 |
| 장애 후속 조치 | 장애 재발 방지를 위한 기능 요구 |

## 요구사항 분류 기준

요구사항은 다음 기준으로 분류한다.

| 구분 | 설명 |
|---|---|
| 기능 요구사항 | 사용자가 원하는 기능 또는 동작 |
| 화면 요구사항 | UI, Dashboard, Table, Chart, Form, Modal |
| API 요구사항 | 조회, 등록, 수정, 삭제, 필터, 정렬, 페이징 |
| 데이터 요구사항 | 저장 대상, 조회 조건, 보존 기간, 집계 기준 |
| 권한 요구사항 | 관리자, 운영자, 조회자, 감사자 등 |
| 연동 요구사항 | OTel, ClickHouse, Kubernetes, Alert, 외부 시스템 |
| 운영 요구사항 | 배포, 설정, 장애 대응, 로그, 모니터링 |
| 비기능 요구사항 | 성능, 보안, 안정성, 감사, 확장성 |
| 제외 범위 | 이번 작업에서 하지 않는 것 |
| 확인 필요 사항 | 사용자에게 다시 확인해야 하는 것 |
| 완료 기준 | Acceptance Criteria |

## 수행 절차

요청을 받으면 다음 순서로 진행한다.

1. 요청 원문을 요약한다.
2. 요청 배경과 목적을 분리한다.
3. 기능 요구사항을 도출한다.
4. 화면 요구사항을 도출한다.
5. API 요구사항을 도출한다.
6. 데이터 요구사항을 도출한다.
7. 권한 요구사항을 도출한다.
8. 연동 요구사항을 도출한다.
9. 운영 요구사항과 비기능 요구사항을 정리한다.
10. 제외 범위를 정리한다.
11. 확인 필요 사항을 질문 목록으로 정리한다.
12. Acceptance Criteria 초안을 작성한다.
13. Feature List 등록 또는 갱신 필요 여부를 판단한다.
14. Spec 요청 정리 필요 여부를 판단한다.
15. Search-First 분석 필요 여부를 판단한다.
16. Change Plan 필요 여부를 판단한다.

## 출력 형식

```text
OpenManager 기능별 요구사항 정리 결과

1. 요청 요약
-

2. 요청 배경
-

3. 기능 요구사항
| ID | 기능 | 설명 | 우선순위 |
|---|---|---|---|

4. 화면 요구사항
-

5. API 요구사항
-

6. 데이터 요구사항
-

7. 권한 요구사항
-

8. 연동 요구사항
-

9. 운영 요구사항
-

10. 비기능 요구사항
-

11. 제외 범위
-

12. 확인 필요 사항
-

13. Acceptance Criteria
-

14. Feature List 반영
- 신규 Feature 등록 필요 여부:
- 기존 Feature 갱신 필요 여부:
- 예상 Feature 영역:
- 예상 Feature ID:

15. 다음 단계
- Spec 요청 정리 필요 여부:
- Search-First 분석 필요 여부:
- Change Plan 필요 여부:
- 사용자 승인 필요 여부:
```

## 판단 기준

다음 경우에는 바로 구현하지 않고 사용자에게 확인한다.

| 상황 | 처리 |
|---|---|
| 요구사항이 모호함 | 확인 질문 작성 |
| 화면과 API 범위가 불명확함 | 범위 분리 |
| DB 영향 가능성 있음 | Change Plan 필요 |
| 운영 영향 가능성 있음 | 사용자 승인 필요 |
| 보안 영향 가능성 있음 | 사용자 승인 필요 |
| Jira Issue와 실제 요청이 다름 | 차이점 정리 |
| 고객 정보 또는 민감 정보 포함 | 비식별 처리 |
| Feature List에 동일 기능이 있음 | 중복 여부 확인 |

## OpenManager 특화 요구사항 예시

OpenManager에서 자주 나오는 요구사항은 다음과 같이 분류한다.

| 요청 | 요구사항 분류 |
|---|---|
| 대시보드에서 장애 현황을 보기 쉽게 해줘 | 화면 요구사항, 기능 요구사항 |
| 알람 조회 조건을 추가해줘 | API 요구사항, 데이터 요구사항 |
| 서비스별 상태를 한눈에 보고 싶어 | 화면 요구사항, 데이터 집계 요구사항 |
| OTel 수집 상태를 보여줘 | 연동 요구사항, 운영 요구사항 |
| 관리자만 설정을 바꿀 수 있게 해줘 | 권한 요구사항, 보안 요구사항 |
| 변경 이력을 남겨줘 | 감사 요구사항, 운영 요구사항 |

## 금지 사항

- 요구사항 수집 단계에서 바로 구현하지 않는다.
- 불명확한 내용을 임의로 확정하지 않는다.
- 사용자 승인 없이 파일을 수정하지 않는다.
- 고객사 실명, Token, Secret, Credential을 기록하지 않는다.
- Jira Issue를 수정하거나 댓글을 작성하지 않는다.
- Search-First 없이 변경 계획을 확정하지 않는다.
- Change Plan 없이 운영 영향 변경을 제안하지 않는다.
- Feature List에 중복 기능을 임의 등록하지 않는다.