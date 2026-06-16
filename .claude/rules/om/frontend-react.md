---
paths:
  - "frontend/**/*.ts"
  - "frontend/**/*.tsx"
  - "frontend/**/*.js"
  - "frontend/**/*.jsx"
  - "frontend/**/*.json"
  - "frontend/**/*.css"
  - "frontend/**/*.scss"
  - "frontend/**/package.json"
  - "frontend/**/pnpm-lock.yaml"
  - "frontend/**/yarn.lock"
  - "frontend/**/package-lock.json"
---

# OpenManager Frontend 규칙

## 적용 범위

이 Rule은 `frontend/` 아래의 UI 코드, 설정, 스타일, Package 의존성을 작업할 때 적용합니다.

## Search-First 원칙

새로운 Component, Hook, Utility, API Client, 상태 관리 로직을 추가하기 전에 다음 항목을 먼저 탐색합니다.

- 기존 Component
- 기존 Hook
- 공통 Utility
- 기존 API Client
- 기존 Type 정의
- 기존 스타일 패턴
- 기존 테스트
- 기존 `data-testid`

재사용 가능한 기존 구현이 있다면 중복 생성하지 않습니다.

## 변경 원칙

- 기존 Frontend 구조와 Naming Convention을 따릅니다.
- 요청 범위 밖의 UI 리팩터링을 수행하지 않습니다.
- 새로운 Package를 추가하기 전에 필요성과 대체 방안을 보고합니다.
- API 응답 Type을 임의로 추정하지 않습니다.
- 접근성 속성과 기존 `data-testid`를 불필요하게 제거하지 않습니다.
- 상태 기반 검증을 우선하고 고정 시간 대기에 의존하지 않습니다.
- 기존 Playwright Agent와 E2E Fixture를 임의로 수정하지 않습니다.

## 검증 원칙

먼저 `frontend/package.json`과 관련 Package 설정에서 실제 Script를 확인합니다.

프로젝트에 정의된 명령 중 변경 범위에 맞는 항목을 실행합니다.

```bash
npm run lint
npm run typecheck
npm test
npm run build
```

Package Manager와 Script 이름은 저장소의 실제 설정을 우선합니다.

실행하지 못한 검증은 `미실행`으로 보고합니다.

## E2E 테스트 원칙

`tests/e2e/`를 변경해야 하면 기존 Playwright Agent와 Fixture를 먼저 확인합니다.

- 통과 중인 테스트를 불필요하게 다시 작성하지 않습니다.
- Assertion을 약화하지 않습니다.
- `test.only`를 Commit하지 않습니다.
- 테스트 데이터는 독립적으로 생성하고 정리합니다.