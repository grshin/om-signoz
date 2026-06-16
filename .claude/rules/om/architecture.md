# OpenManager 아키텍처 공통 규칙

## 목적

SigNoz OSS 기반 OpenManager 고도화 작업에서 아키텍처 변경 범위를 최소화하고, 향후 `upstream` 병합 가능성을 유지합니다.

## 구현 우선순위

기능 요구사항은 다음 순서로 해결 가능성을 검토합니다.

1. Dashboard, Alert Rule, OpenTelemetry 설정으로 해결합니다.
2. OpenManager 전용 확장 영역에서 구현합니다.
3. OM Adapter API 또는 Control Plane에서 구현합니다.
4. SigNoz가 제공하는 API를 활용합니다.
5. 불가피한 경우에만 SigNoz OSS 원본 소스를 직접 수정합니다.

## Search-First 원칙

새로운 파일, Component, Handler, Helper, API, 설정을 추가하기 전에 다음 항목을 먼저 탐색합니다.

- 기존 구현
- 유사한 기능
- 공통 Helper와 Utility
- 기존 API Endpoint
- Dashboard와 Alert Rule
- OpenTelemetry Pipeline 설정
- 기존 테스트와 문서

재사용 가능한 기존 구현이 있다면 중복 구현하지 않습니다.

## OM 전용 네임스페이스

OpenManager 전용 하네스 파일은 다음 위치에 작성합니다.

- Agent: `.claude/agents/om/`
- Rule: `.claude/rules/om/`
- Hook: `.claude/hooks/om/`
- Skill: `.claude/skills/om-*/SKILL.md`
- 문서: `docs/harness/`

OM 전용 Agent, Hook, Skill 이름에는 `om-` 접두어를 사용합니다.

## 아키텍처 결정 제한

사용자의 명시적인 승인 없이 다음 결정을 확정하지 않습니다.

- 신규 서비스 추가
- 데이터 저장소 변경
- 외부 의존성 추가
- 인증 및 권한 구조 변경
- API 호환성을 깨는 변경
- 운영환경 토폴로지 변경
- SigNoz OSS 원본 소스 직접 수정

아키텍처 변경이 필요하면 변경 이유, 대체 방안, 영향 범위, 검증 방법을 먼저 보고합니다.