# OpenManager 공통 Spec 기반 개발 요청 템플릿

## 1. 요청 개요

| 항목 | 내용 |
|---|---|
| 요청 제목 |  |
| 요청자 |  |
| 요청 일자 |  |
| 대상 단계 |  |
| 요청 유형 | 신규 기능 / 개선 / 리팩토링 / 버그 수정 / 검증 / 문서화 |
| 우선순위 | 낮음 / 보통 / 높음 / 긴급 |

## 2. 배경 및 목적

### 배경

```text
왜 이 작업이 필요한지 작성한다.
```

### 목적

```text
이번 작업으로 달성하려는 결과를 작성한다.
```

### 비목표

```text
이번 작업에서 하지 않을 일을 명확히 작성한다.
```

## 3. 변경 범위

| 구분 | 내용 |
|---|---|
| 변경 대상 경로 |  |
| 변경 제외 경로 |  |
| 관련 컴포넌트 | Backend / Frontend / OTel / Deploy / Docs / Harness |
| 외부 연동 여부 | 없음 / 있음 |
| 운영 환경 영향 | 없음 / 있음 |

## 4. 적용 Rule

### 공통 Rule

| Rule | 적용 여부 | 비고 |
|---|---:|---|
| `.claude/rules/om/architecture.md` |  |  |
| `.claude/rules/om/upstream-boundary.md` |  |  |
| `.claude/rules/om/security-policy.md` |  |  |
| `.claude/rules/om/quality-gate.md` |  |  |

### 경로별 Rule

| Rule | 적용 여부 | 비고 |
|---|---:|---|
| `.claude/rules/om/backend-go.md` |  |  |
| `.claude/rules/om/frontend-react.md` |  |  |
| `.claude/rules/om/otel-pipeline.md` |  |  |
| `.claude/rules/om/deploy-kubernetes.md` |  |  |

## 5. 관련 Skill 및 Agent

### 관련 Skill

| Skill | 사용 목적 |
|---|---|
| `om-project-context` | 프로젝트 기준 정렬 |
| `om-rule-router` | 적용 Rule 선택 |
| `om-validation-plan` | 검증 계획 수립 |
| `om-change-risk-review` | 변경 위험 검토 |

### 관련 Agent

| Agent | 사용 목적 |
|---|---|
| `om-architecture-reviewer` | 아키텍처 및 upstream 경계 검토 |
| `om-security-quality-reviewer` | 보안 및 품질 검토 |

## 6. 요구사항

### 기능 요구사항

```text
1.
2.
3.
```

### 비기능 요구사항

```text
1. 성능:
2. 보안:
3. 운영:
4. 유지보수:
```

### 제약조건

```text
1.
2.
3.
```

## 7. 구현 요청 상세

### 기대 동작

```text
사용자 또는 시스템 관점에서 기대되는 동작을 작성한다.
```

### 예외 처리

```text
오류, 빈 데이터, 권한 없음, 외부 연동 실패 등의 처리 기준을 작성한다.
```

### 호환성

```text
기존 SigNoz OSS 동작과 호환되어야 하는 부분을 작성한다.
```

## 8. 위험 검토

| 위험 항목 | 영향 | 대응 |
|---|---|---|
| upstream 충돌 | 낮음 / 보통 / 높음 |  |
| 민감 정보 노출 | 낮음 / 보통 / 높음 |  |
| 운영 영향 | 낮음 / 보통 / 높음 |  |
| 테스트 부족 | 낮음 / 보통 / 높음 |  |
| 롤백 어려움 | 낮음 / 보통 / 높음 |  |

## 9. 검증 계획

| 검증 구분 | 검증 방법 |
|---|---|
| 문법 |  |
| 단위 테스트 |  |
| 빌드 |  |
| 통합 확인 |  |
| 수동 확인 |  |
| 단계 전용 점검 스크립트 |  |

## 10. 완료 기준

```text
1.
2.
3.
```

## 11. Git Checkpoint 기준

| 항목 | 기준 |
|---|---|
| Commit 권장 여부 | 예 / 아니오 |
| Push 권장 여부 | 예 / 아니오 |
| Commit 메시지 초안 |  |

## 12. Claude Code 요청 문장

아래 문장을 Claude Code에 전달한다.

```text
OpenManager 하네스 기준으로 위 Spec을 먼저 검토해 주세요.
바로 구현하지 말고, 적용 Rule, 관련 Agent, 위험 요소, 검증 계획을 먼저 정리해 주세요.
구현이 필요하다고 판단되면 변경 계획을 제안하고 사용자 승인을 요청해 주세요.
```