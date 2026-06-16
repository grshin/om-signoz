# OpenManager Change Plan 템플릿

## 1. 요청 요약

```text
사용자의 요청을 한 문장으로 요약한다.
```

## 2. 변경 목표

```text
이번 변경으로 달성하려는 목표를 작성한다.
```

## 3. 변경 범위

### 변경 대상

| 구분 | 파일 또는 경로 | 변경 방식 | 비고 |
|---|---|---|---|
| 생성 |  |  |  |
| 수정 |  |  |  |
| 삭제 |  |  |  |
| 이동 |  |  |  |

### 변경 제외 대상

| 파일 또는 경로 | 제외 사유 |
|---|---|
|  |  |

## 4. 적용 Rule

### 공통 Rule

| Rule | 적용 여부 | 적용 내용 |
|---|---:|---|
| `.claude/rules/om/architecture.md` |  |  |
| `.claude/rules/om/upstream-boundary.md` |  |  |
| `.claude/rules/om/security-policy.md` |  |  |
| `.claude/rules/om/quality-gate.md` |  |  |

### 경로별 Rule

| Rule | 적용 여부 | 적용 내용 |
|---|---:|---|
| `.claude/rules/om/backend-go.md` |  |  |
| `.claude/rules/om/frontend-react.md` |  |  |
| `.claude/rules/om/otel-pipeline.md` |  |  |
| `.claude/rules/om/deploy-kubernetes.md` |  |  |

## 5. 관련 Skill 및 Agent

### 관련 Skill

| Skill | 사용 목적 |
|---|---|
| `om-project-context` | 프로젝트 기준 확인 |
| `om-rule-router` | 적용 Rule 선택 |
| `om-spec-request` | Spec 기반 요청 정리 |
| `om-search-first-analysis` | 기존 구현 검색과 분석 |
| `om-change-plan` | 변경 계획 작성 |
| `om-validation-plan` | 검증 계획 수립 |
| `om-change-risk-review` | 변경 위험 검토 |

### 관련 Agent

| Agent | 사용 목적 |
|---|---|
| `om-architecture-reviewer` | 아키텍처와 upstream 경계 검토 |
| `om-backend-go-reviewer` | Backend Go 변경 검토 |
| `om-frontend-react-reviewer` | Frontend React 변경 검토 |
| `om-otel-pipeline-reviewer` | OTel Pipeline 변경 검토 |
| `om-deploy-kubernetes-reviewer` | Deploy Kubernetes 변경 검토 |
| `om-security-quality-reviewer` | 보안과 품질 검토 |

## 6. 파일별 변경 계획

| 파일 | 변경 방식 | 변경 내용 | 위험도 |
|---|---|---|---|
|  | 생성 / 수정 / 삭제 / 제외 |  | 낮음 / 보통 / 높음 |

## 7. 구현 순서

| 순서 | 작업 | 설명 |
|---:|---|---|
| 1 |  |  |
| 2 |  |  |
| 3 |  |  |
| 4 |  |  |
| 5 |  |  |

## 8. 위험도 평가

| 위험 항목 | 위험도 | 내용 | 대응 |
|---|---|---|---|
| upstream 충돌 | 낮음 / 보통 / 높음 |  |  |
| 보안 위험 | 낮음 / 보통 / 높음 |  |  |
| 운영 영향 | 낮음 / 보통 / 높음 |  |  |
| 품질 검증 부족 | 낮음 / 보통 / 높음 |  |  |
| Rollback 어려움 | 낮음 / 보통 / 높음 |  |  |
| 대량 변경 | 낮음 / 보통 / 높음 |  |  |

## 9. 사용자 승인 필요 항목

| 항목 | 승인 필요 여부 | 사유 |
|---|---:|---|
| 운영 환경 영향 |  |  |
| Kubernetes / Helm 적용 |  |  |
| Secret 또는 인증 설정 변경 |  |  |
| DB schema 또는 ClickHouse table 변경 |  |  |
| 데이터 삭제 또는 migration |  |  |
| upstream 구조 변경 |  |  |
| 대량 파일 수정 |  |  |
| Git Commit / Push |  |  |

## 10. 검증 계획

| 검증 구분 | 검증 방법 | 실행 시점 |
|---|---|---|
| 문법 확인 |  | 구현 후 |
| 단위 테스트 |  | 구현 후 |
| 빌드 |  | 구현 후 |
| 통합 확인 |  | 구현 후 |
| 수동 확인 |  | 구현 후 |
| 단계 전용 점검 스크립트 |  | 구현 후 |
| 민감 파일 포함 여부 확인 |  | Commit 전 |
| Stage 파일 확인 |  | Commit 전 |

## 11. Rollback 계획

| 항목 | 내용 |
|---|---|
| 원복 대상 |  |
| 원복 방법 |  |
| 원복 확인 방법 |  |
| Rollback 어려움 여부 | 낮음 / 보통 / 높음 |

## 12. Git Checkpoint 제안

| 항목 | 내용 |
|---|---|
| Commit 권장 여부 | 예 / 아니오 |
| Push 권장 여부 | 예 / 아니오 |
| Commit 메시지 초안 |  |

## 13. 구현 전 확인 문장

아래 문장으로 사용자 승인을 요청한다.

```text
위 변경 계획 기준으로 구현을 진행해도 될까요?
운영 영향, 보안 위험, 변경 제외 대상, 검증 계획을 확인해 주세요.
```