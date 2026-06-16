# OpenManager Frontend React Spec 요청 템플릿

## 1. 요청 개요

| 항목 | 내용 |
|---|---|
| 요청 제목 |  |
| Frontend 변경 유형 | Page / Route / Component / Hook / State / API Client / Chart / Table / 기타 |
| 대상 경로 |  |
| 관련 Backend API 여부 | 없음 / 있음 |
| 관련 권한 또는 인증 여부 | 없음 / 있음 |
| 사용자 영향 | 낮음 / 보통 / 높음 |

## 2. 적용 Rule 및 Agent

| 구분 | 대상 |
|---|---|
| 공통 Rule | architecture, upstream-boundary, security-policy, quality-gate |
| 경로 Rule | frontend-react |
| 관련 Skill | om-project-context, om-rule-router, om-validation-plan |
| 관련 Agent | om-frontend-react-reviewer, om-architecture-reviewer, om-security-quality-reviewer |

## 3. UI 요구사항

### 화면 또는 컴포넌트

```text
- 화면명:
- 컴포넌트명:
- 사용자 액션:
- 표시 데이터:
- 빈 데이터 처리:
- 오류 처리:
```

### API 연동

```text
- API Endpoint:
- Request Parameter:
- Response Field:
- Loading 처리:
- Error 처리:
```

### 상태 관리

```text
- Local state:
- Global state:
- URL query parameter:
- Cache 영향:
```

## 4. UX 및 성능 검토

| 항목 | 검토 내용 |
|---|---|
| 대량 데이터 표시 |  |
| Filter / Search 영향 |  |
| Chart 렌더링 영향 |  |
| Table Pagination 영향 |  |
| 접근성 또는 사용성 |  |

## 5. 보안 검토

```text
- 권한별 노출 제어:
- 민감 데이터 화면 표시 여부:
- URL parameter에 민감 정보 포함 여부:
- 외부 링크 또는 다운로드 여부:
```

## 6. 검증 계획

| 검증 항목 | 명령 또는 방법 |
|---|---|
| 변경 파일 확인 | `git diff --name-only` |
| Type Check |  |
| Lint |  |
| Build |  |
| UI 수동 확인 |  |
| 단계 전용 점검 | 해당 단계 점검 스크립트 |

## 7. Claude Code 요청 문장

```text
om-frontend-react-reviewer를 사용해서 이 Frontend React Spec을 검토해 주세요.
바로 구현하지 말고 UI 구조, API 연동, 상태 관리, 성능 영향, 보안 위험, 검증 계획을 먼저 정리해 주세요.
```