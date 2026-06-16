# SigNoz OSS Upstream 경계 규칙

## 목적

OpenManager 전용 변경사항과 SigNoz OSS 원본 변경사항의 경계를 명확하게 유지합니다.

## Remote와 브랜치 역할

- `upstream/main`: SigNoz OSS 공식 저장소 기준입니다.
- `origin/main`: 개인 Fork의 OSS 동기화 기준입니다.
- `origin/om-main`: OpenManager 통합 기준 브랜치입니다.
- `feature/*`: OpenManager 기능 개발 브랜치입니다.
- `fix/*`: 오류 수정 브랜치입니다.

## 기본 원칙

- `main` 브랜치에서 OpenManager 전용 기능을 직접 개발하지 않습니다.
- `upstream`에는 Push하지 않습니다.
- 사용자가 명시적으로 요청하지 않으면 `git commit`, `git push`, Force Push를 수행하지 않습니다.
- SigNoz OSS 원본 파일 수정은 최소화합니다.
- OpenManager 전용 확장으로 해결할 수 있는지 먼저 검토합니다.
- 기존 SigNoz Playwright Agent는 삭제하거나 수정하지 않습니다.

## OSS 원본 수정 보고

SigNoz OSS 원본 파일을 직접 수정해야 한다면 다음 항목을 먼저 보고합니다.

| 항목 | 기록 내용 |
|---|---|
| 변경 이유 | OM 확장만으로 해결할 수 없는 이유 |
| 변경 파일 | 직접 수정이 필요한 파일 목록 |
| 영향 범위 | API, UI, Pipeline, 배포 영향 |
| 대체 방안 | Adapter, 설정, API 활용 가능 여부 |
| 검증 방법 | 실행할 테스트와 확인 항목 |
| 병합 위험 | 향후 `upstream` 병합 충돌 가능성 |

## 금지 작업

사용자의 명시적인 승인 없이 다음 작업을 수행하지 않습니다.

- `git push upstream`
- `git push --force`
- `git reset --hard`
- `git clean -fd`
- 브랜치 삭제
- 기존 SigNoz Playwright Agent 수정