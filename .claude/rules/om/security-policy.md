# OpenManager 보안 공통 규칙

## 목적

AI Agent가 Secret, Credential, 운영환경, 데이터 삭제와 관련된 고위험 작업을 임의로 수행하지 않도록 행동 원칙을 정의합니다.

## 보호 대상

사용자의 명시적인 승인 없이 다음 파일과 디렉터리의 내용을 출력하거나 수정하지 않습니다.

- `.env`
- `.env.*`
- `secrets/`
- `credentials/`
- `token/`
- `deploy/prod/`
- `.claude/settings.local.json`

다음 값도 출력하지 않습니다.

- Password
- API Key
- Access Token
- Refresh Token
- Client Secret
- Private Key
- 인증서 개인키
- 데이터베이스 접속 비밀번호

## 위험 작업 제한

사용자의 명시적인 승인 없이 다음 작업을 수행하지 않습니다.

- 운영환경 배포
- `kubectl apply`
- `kubectl delete`
- `helm upgrade`
- 데이터베이스 스키마 변경
- 데이터베이스 데이터 삭제
- Secret 생성, 변경, 조회
- Credential 파일 내용 출력
- Force Push
- 대량 파일 삭제

## 안전한 보고 원칙

- Secret 값은 마스킹하여 보고합니다.
- 로그에 인증정보가 포함되면 값을 출력하지 않습니다.
- 운영환경과 개발환경을 명확하게 구분합니다.
- 위험 작업이 필요하면 명령을 실행하지 않고 영향 범위와 승인 필요 사항을 먼저 보고합니다.

## 강제 차단 정책

이 문서는 AI Agent의 행동을 안내하는 Rule입니다.

실제 명령 차단은 후속 단계의 Permission과 Hook에서 적용합니다.