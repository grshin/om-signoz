# OpenManager Spec Change Plan

## 문서 목적

본 문서는 23단계 선정 Spec과 24단계 Search-First 분석을 기준으로 실제 구현 전에 변경 계획을 정리하기 위한 Change Plan 문서이다.

24단계에서는 실제 소스코드를 수정하지 않는다.

## 기준 정보

| 항목 | 내용 |
|---|---|
| 기준 단계 | 24단계 |
| 관련 Feature ID | OM-FEAT-006 |
| 관련 Spec | `docs/harness/specs/OPENMANAGER_SELECTED_SPEC.md` |
| Search-First 문서 | `docs/harness/search-first/OPENMANAGER_SPEC_SEARCH_FIRST_ANALYSIS.md` |
| 기능명 | Dashboard 카드 로딩 상태 개선 |
| 개선 유형 | Frontend UX 개선 |
| 실제 구현 여부 | 미수행 |
| 사용자 승인 필요 여부 | 필요 |

## 변경 목적

Dashboard 카드에서 데이터 조회 상태를 사용자가 명확히 구분할 수 있도록 Loading, Empty, Error 상태 표현 기준을 정의한다.

이번 Change Plan은 실제 구현 전 계획이며, 변경 대상 파일은 Search-First 분석 완료 후 확정한다.

## 변경 범위

| 영역 | 포함 여부 | 설명 |
|---|---:|---|
| Frontend React | 포함 | Dashboard 카드 상태 표현 개선 후보 |
| Backend Go | 제외 | 신규 API 또는 API 변경 없음 |
| ClickHouse | 제외 | Query 변경 없음 |
| OTel Pipeline | 제외 | 수집 파이프라인 변경 없음 |
| Kubernetes / Helm | 제외 | 배포 설정 변경 없음 |
| 문서 | 포함 | Spec, Search-First, Change Plan 문서화 |

## 변경 후보

Search-First 결과에 따라 변경 후보는 다음 중에서 확정한다.

| 후보 | 설명 | 상태 |
|---|---|---|
| Dashboard Card Component | 카드 단위 상태 표현 추가 가능성 | 미확정 |
| Loading Component | 기존 Loading / Skeleton 재사용 가능성 | 미확정 |
| Empty State Component | 기존 Empty State 재사용 가능성 | 미확정 |
| Error State Component | 기존 Error State 재사용 가능성 | 미확정 |
| Dashboard 데이터 조회 Hook | loading, error, data 상태 전달 방식 확인 | 미확정 |

## 제외 범위

이번 Change Plan에서 제외하는 범위는 다음과 같다.

```text
- Backend API 변경
- DB Schema 변경
- ClickHouse Query 변경
- OTel Pipeline 변경
- Kubernetes / Helm 변경
- 운영 배포
- 권한 정책 변경
- Dashboard 전체 레이아웃 개편
- 디자인 시스템 신규 도입
```

## 구현 전 확인 사항

구현 전 반드시 확인해야 할 사항은 다음과 같다.

| 번호 | 확인 항목 | 상태 |
|---:|---|---|
| 1 | Dashboard 관련 Component 위치 확인 | 미확인 |
| 2 | 기존 Loading Component 존재 여부 확인 | 미확인 |
| 3 | 기존 Empty State 패턴 확인 | 미확인 |
| 4 | 기존 Error State 패턴 확인 | 미확인 |
| 5 | 데이터 조회 Hook의 loading / error 상태 확인 | 미확인 |
| 6 | 테스트 또는 Storybook 구조 확인 | 미확인 |
| 7 | 변경 대상 파일 목록 확정 | 미확인 |

## 구현 방향 후보

구현 방향은 Search-First 결과에 따라 다음 중 하나로 결정한다.

| 방향 | 설명 | 우선순위 |
|---|---|---:|
| 기존 공통 Component 재사용 | 기존 Loading, Empty, Error Component를 재사용 | 1 |
| Dashboard Card 내부 조건부 렌더링 | 카드 Component에서 상태별 표시를 분기 | 2 |
| 경량 상태 Component 추가 | 기존 패턴이 없을 경우 작은 상태 Component 추가 | 3 |
| 공통 UI 구조 변경 | 여러 화면 영향이 있는 공통 Component 수정 | 낮음 |

## 검증 계획

구현 후 검증 계획은 다음과 같다.

| 검증 항목 | 방법 |
|---|---|
| Loading 상태 확인 | Mock 또는 개발 환경에서 로딩 상태 유도 |
| Empty 상태 확인 | 빈 데이터 응답 또는 Mock 데이터 사용 |
| Error 상태 확인 | 오류 응답 또는 예외 상황 유도 |
| 레이아웃 유지 확인 | 기존 Dashboard 화면과 비교 |
| 변경 파일 확인 | Backend, DB, Deploy 파일이 변경되지 않았는지 확인 |
| 문서 확인 | Spec, Search-First, Change Plan 반영 여부 확인 |

## 예상 검증 명령

실제 명령은 프로젝트 구조 확인 후 확정한다.

```bash
git status --short
```

```bash
git diff --name-only
```

Frontend 구조가 확인되면 다음 유형의 명령을 검토한다.

```bash
cd frontend
npm run lint
npm run build
```

또는 프로젝트가 `yarn`, `pnpm`을 사용할 경우 해당 명령으로 대체한다.

```bash
pnpm lint
pnpm build
```

24단계에서는 위 명령을 실제 실행하지 않고, 검증 후보로만 정리한다.

## Rollback 기준

Rollback 기준은 다음과 같다.

```text
- Dashboard 화면이 렌더링되지 않는 경우
- 기존 카드 레이아웃이 깨지는 경우
- 기존 데이터 표시 기능이 사라지는 경우
- Loading / Empty / Error 상태가 잘못 표시되는 경우
- Backend 또는 배포 파일 변경이 의도치 않게 포함된 경우
```

Rollback 방식은 다음을 우선한다.

```text
- 변경 파일 단위 되돌리기
- 신규 Component 추가 시 해당 파일 제거
- 기존 Component 수정 시 기존 상태로 복원
- Git Commit 전이면 git checkout 또는 git restore로 되돌리기
```

## 사용자 승인 필요 사항

다음 작업 전에는 사용자 승인이 필요하다.

```text
- 실제 Frontend 파일 수정
- 신규 Component 생성
- 기존 공통 Component 수정
- 상태별 문구 확정
- 테스트 또는 Mock 데이터 추가
- Git Add
- Git Commit
- Git Push
```

## 위험도 평가

| 항목 | 위험도 | 설명 |
|---|---|---|
| 운영 영향 | 낮음 | 24단계는 계획 단계 |
| 구현 영향 | 중간 | 다음 단계에서 Dashboard 화면 영향 가능 |
| Backend 영향 | 없음 | Backend 변경 제외 |
| DB 영향 | 없음 | DB 변경 제외 |
| 배포 영향 | 없음 | Helm / Kubernetes 변경 제외 |
| 보안 영향 | 낮음 | 민감 정보 출력 금지 |
| Rollback 난이도 | 낮음 | Frontend 변경 중심 예상 |

## Change Plan 결론

`OM-FEAT-006 — Dashboard 카드 로딩 상태 개선`은 Frontend 중심 개선으로 진행 가능성이 있다.

다만 실제 구현 전 다음 조건을 만족해야 한다.

```text
1. 기존 Dashboard Component 구조 확인
2. 기존 Loading / Empty / Error 처리 패턴 확인
3. 변경 대상 파일 확정
4. 사용자 승인
5. 구현 후 Validation Plan과 Change Risk Review 수행
```

24단계에서는 실제 구현하지 않는다.

다음 단계에서 사용자 승인 후 구현을 진행한다.