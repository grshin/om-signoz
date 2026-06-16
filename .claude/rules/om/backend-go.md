---
paths:
  - "**/*.go"
  - "go.mod"
  - "go.sum"
  - ".golangci.yml"
  - "Makefile"
  - "cmd/**/*"
  - "pkg/**/*"
---

# OpenManager Go Backend 규칙

## 적용 범위

이 Rule은 Go Backend 코드, Go Module 설정, Lint 설정, Backend Build 설정을 작업할 때 적용합니다.

## Search-First 원칙

새로운 Package, Handler, Service, Repository, Helper를 추가하기 전에 다음 항목을 먼저 탐색합니다.

- `cmd/`
- `pkg/`
- 기존 Interface와 구현체
- 기존 Error 처리 방식
- 기존 Config 로딩 방식
- 기존 Test 파일
- 기존 Mock과 Fixture

재사용 가능한 기존 구현이 있다면 중복 생성하지 않습니다.

## 변경 원칙

- 기존 Package 구조와 Naming Convention을 따릅니다.
- 요청 범위 밖의 대규모 리팩터링을 수행하지 않습니다.
- 공개 API와 Interface를 변경하면 영향 범위를 먼저 보고합니다.
- 새로운 외부 의존성을 추가하기 전에 필요성과 대체 방안을 보고합니다.
- 생성 코드와 Vendor 코드는 명시적인 요청 없이 수정하지 않습니다.
- 오류를 무시하지 않습니다.
- 로그에 Secret, Token, Credential을 출력하지 않습니다.

## 검증 원칙

변경 파일에 맞는 검증 명령을 확인하고 가능한 범위에서 실행합니다.

```bash
gofmt -w <변경한-go-파일>
go test <영향받는-package>
go test ./...
golangci-lint run
```

실행하지 못한 검증은 `미실행`으로 보고하고 이유를 설명합니다.

## OSS 수정 경계

SigNoz OSS 원본 Backend 코드를 직접 수정하면 다음 내용을 보고합니다.

- 변경 파일
- OM 전용 확장으로 해결할 수 없는 이유
- API 호환성 영향
- 데이터 모델 영향
- 향후 `upstream` 병합 위험