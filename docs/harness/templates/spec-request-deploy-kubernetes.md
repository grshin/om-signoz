# OpenManager Deploy Kubernetes Spec 요청 템플릿

## 1. 요청 개요

| 항목 | 내용 |
|---|---|
| 요청 제목 |  |
| 변경 유형 | Docker / Compose / Kubernetes / Helm / Values / Ingress / Service / ConfigMap / Secret / PVC |
| 대상 환경 | Local / Dev / Stage / Prod |
| 운영 영향 | 없음 / 있음 |
| Rollback 필요 | 없음 / 있음 |
| 사용자 승인 필요 | 없음 / 있음 |

## 2. 적용 Rule 및 Agent

| 구분 | 대상 |
|---|---|
| 공통 Rule | architecture, upstream-boundary, security-policy, quality-gate |
| 경로 Rule | deploy-kubernetes |
| 관련 Skill | om-project-context, om-rule-router, om-validation-plan |
| 관련 Agent | om-deploy-kubernetes-reviewer, om-security-quality-reviewer |

## 3. 배포 요구사항

### 대상 리소스

```text
- Namespace:
- Deployment:
- Service:
- Ingress:
- ConfigMap:
- Secret:
- PVC:
- Helm chart:
```

### 변경 내용

```text
- 변경 전:
- 변경 후:
- 변경 이유:
- 영향 범위:
```

### Rollback 기준

```text
- 원복 대상:
- 원복 방법:
- 원복 확인:
```

## 4. 운영 영향 검토

| 항목 | 검토 내용 |
|---|---|
| 서비스 중단 가능성 |  |
| 설정 오류 영향 |  |
| Secret 영향 |  |
| Storage 영향 |  |
| Network 영향 |  |
| Rollback 가능성 |  |

## 5. 금지 또는 승인 필요 작업

아래 작업은 사용자 승인 전 실행하지 않는다.

```text
kubectl apply
kubectl delete
helm upgrade
helm uninstall
docker system prune
운영 Secret 조회
운영 Namespace 변경
```

## 6. 검증 계획

| 검증 항목 | 명령 또는 방법 |
|---|---|
| 변경 파일 확인 | git diff --name-only |
| YAML 문법 확인 |  |
| Helm template |  |
| Dry-run |  |
| Rollback 계획 확인 |  |
| 단계 전용 점검 | 해당 단계 점검 스크립트 |

## 7. Claude Code 요청 문장

```text
om-deploy-kubernetes-reviewer를 사용해서 이 Deploy Kubernetes Spec을 검토해 주세요.
바로 적용하지 말고 Kubernetes/Helm 영향, 운영 위험, Secret 영향, Rollback 기준, 검증 계획을 먼저 정리해 주세요.
```