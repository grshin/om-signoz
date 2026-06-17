# OpenManager Frontend Dashboard 변경 시나리오

## 시나리오 목적

Frontend Dashboard 변경 요청이 들어왔을 때 Claude Code 하네스가 React UI 변경 흐름을 올바르게 검증하는지 확인한다.

## 사용자 요청 예시

```text
OpenManager 대시보드에 서비스별 오류율 카드와 추세 차트를 추가해 주세요.
기존 대시보드 컴포넌트와 API 연동 구조를 먼저 확인한 뒤 변경 계획을 작성해 주세요.
```

## 요청 유형

| 요청 유형 | 해당 여부 | 판단 근거 |
|---|---:|---|
| Backend Go | 선택 | 신규 API가 필요할 수 있음 |
| Frontend React | 예 | 대시보드 UI, component, chart 변경 |
| OTel Pipeline | 아니오 | 수집 파이프라인 변경 요청 아님 |
| ClickHouse | 선택 | API가 신규 집계를 요구할 경우 영향 가능 |
| Docker / Kubernetes / Helm | 아니오 | 배포 설정 변경 요청 아님 |
| Harness | 아니오 | 하네스 자체 변경 요청 아님 |
| Security / Quality | 예 | UI 검증, API error handling 확인 필요 |
| Architecture | 예 | 화면 구조와 데이터 흐름 확인 필요 |

## 적용 Rule

| Rule | 적용 여부 | 사유 |
|---|---:|---|
| `.claude/rules/om/architecture.md` | 예 | Frontend 구조와 책임 확인 |
| `.claude/rules/om/frontend-react.md` | 예 | React component, route, state 변경 기준 |
| `.claude/rules/om/security-policy.md` | 예 | 민감 정보 노출 방지 |
| `.claude/rules/om/quality-gate.md` | 예 | build, lint, 수동 확인 기준 |
| `.claude/rules/om/backend-go.md` | 선택 | API 변경이 동반될 경우 적용 |

## 관련 Skill

| Skill | 적용 여부 | 사용 목적 |
|---|---:|---|
| `om-spec-request` | 예 | 화면 변경 목적과 제외 대상 정리 |
| `om-search-first-analysis` | 예 | 기존 dashboard, component, API client 검색 |
| `om-change-plan` | 예 | 변경 대상 component와 API 연동 계획 |
| `om-validation-plan` | 예 | UI 검증, build, type check 기준 |
| `om-implementation-validation` | 예 | 구현 후 검증 결과 정리 |
| `om-quality-gate` | 예 | Commit 전 품질 확인 |
| `om-change-history` | 예 | 변경 이력 기록 |

## 관련 Agent

| Agent | 적용 여부 | 사용 목적 |
|---|---:|---|
| `om-frontend-react-reviewer` | 예 | React UI, state, component 변경 검토 |
| `om-architecture-reviewer` | 예 | 화면 구조와 데이터 흐름 검토 |
| `om-security-quality-reviewer` | 예 | 보안과 품질 기준 검토 |
| `om-backend-go-reviewer` | 선택 | API 변경이 동반될 경우 검토 |

## Search-First 확인 항목

| 확인 항목 | 설명 |
|---|---|
| dashboard route | 기존 대시보드 경로 확인 |
| component 구조 | 카드, 차트, table 컴포넌트 위치 확인 |
| API client | 데이터 조회 방식 확인 |
| state 관리 | loading, error, empty 상태 처리 방식 확인 |
| chart library | 기존 차트 표현 방식 확인 |
| test / story | 기존 검증 방법 확인 |

## Change Plan 확인 항목

| 항목 | 확인 내용 |
|---|---|
| 생성 파일 | 신규 card, chart component 여부 |
| 수정 파일 | 기존 dashboard, API client, type 변경 |
| 제외 파일 | Backend 변경 제외 여부 명시 |
| 위험도 | UI regression, API 오류 처리, 대량 데이터 렌더링 |
| 검증 계획 | type check, build, 수동 화면 확인 |

## 구현 검증 기준

| 검증 항목 | 기준 |
|---|---|
| TypeScript | type 오류 없음 |
| UI 상태 | loading, error, empty data 처리 |
| API 연동 | 기존 API 구조와 호환 |
| Chart / Card | 데이터가 없는 경우에도 화면 깨짐 없음 |
| Build | 가능한 범위에서 build 또는 type check |
| 접근성 | 과도한 색상 의존, 텍스트 누락 방지 |

## Quality Gate 기준

| Gate | 확인 내용 |
|---|---|
| 변경 범위 | Frontend 관련 파일 중심인지 확인 |
| 민감 파일 | Secret, 개인 설정 미포함 |
| 기존 Agent | SigNoz Playwright Agent 미수정 |
| Stage 파일 | 현재 변경 대상만 포함 |
| Commit 메시지 | Frontend Dashboard 변경 목적 포함 |

## 승인 필요 항목

| 항목 | 승인 필요 여부 | 사유 |
|---|---:|---|
| 신규 Backend API 필요 | 필요 | Backend 작업 범위 추가 |
| API 응답 구조 변경 | 필요 | 기존 화면 영향 가능 |
| 대시보드 UX 변경 | 선택 | 사용자 경험 변경 영향 |
| 운영 배포 | 필요 | 운영 반영은 별도 승인 필요 |

## 시나리오 검증 결과 기준

| 항목 | 기대 결과 |
|---|---|
| 요청 유형 분류 | Frontend React 중심으로 분류 |
| Rule 선택 | frontend-react, architecture, security, quality 적용 |
| Agent 선택 | frontend-react-reviewer 중심 |
| Workflow 흐름 | Spec → Search-First → Change Plan → Validation → Quality Gate |
| 위험 작업 | 실제 변경 또는 배포 없이 승인 필요 항목으로만 기록 |