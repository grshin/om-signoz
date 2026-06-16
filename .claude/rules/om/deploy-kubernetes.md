---
paths:
  - "deploy/**/*.yaml"
  - "deploy/**/*.yml"
  - "deploy/**/*.tpl"
  - "deploy/**/*.sh"
  - "**/Chart.yaml"
  - "**/values*.yaml"
  - "**/values*.yml"
  - "**/*helm*/**/*"
  - "**/*k8s*/**/*.yaml"
  - "**/*k8s*/**/*.yml"
  - "**/*kubernetes*/**/*.yaml"
  - "**/*kubernetes*/**/*.yml"
---

# OpenManager Kubernetes 배포 규칙

## 적용 범위

이 Rule은 Kubernetes Manifest, Helm Chart, Values 파일, 배포 Script를 작업할 때 적용합니다.

## 환경 구분

배포 관련 작업을 수행하기 전에 대상 환경을 명확하게 구분합니다.

```text
Local
개발자 PC와 로컬 검증 환경

Development
개발 및 통합 테스트 환경

Staging
운영 반영 전 검증 환경

Production
운영환경
```

환경이 불명확하면 운영환경으로 간주하고 변경을 수행하지 않습니다.

## 위험 작업 제한

사용자의 명시적인 승인 없이 다음 명령을 실행하지 않습니다.

```bash
kubectl apply
kubectl delete
kubectl patch
kubectl edit
kubectl scale
helm install
helm upgrade
helm uninstall
```

## 변경 원칙

- 기존 Namespace, Label, Annotation, Selector를 먼저 확인합니다.
- Secret 값을 Manifest와 Values 파일에 직접 기록하지 않습니다.
- 운영환경 Values 파일을 임의로 수정하지 않습니다.
- Resource Request와 Limit 변경 시 영향 범위를 보고합니다.
- Probe 변경 시 장애 감지와 복구 영향 범위를 보고합니다.
- PersistentVolume과 데이터 저장 경로 변경 시 데이터 유실 가능성을 검토합니다.
- Helm Chart 변경 시 Template과 Values의 연결 관계를 확인합니다.

## 검증 원칙

운영 반영 없이 가능한 정적 검증을 우선합니다.

```bash
helm lint <chart-path>
helm template <release-name> <chart-path>
kubectl apply --dry-run=client -f <manifest>
```

실제 명령은 저장소 구조와 설치 도구를 확인한 뒤 실행합니다.

운영환경 반영은 사용자의 명시적인 승인 후 진행합니다.

## 결과 보고

배포 관련 변경이 있으면 다음 항목을 포함하여 보고합니다.

- 대상 환경
- 변경 파일
- 변경 리소스
- 영향 범위
- 정적 검증 결과
- 롤백 방법
- 운영 반영 승인 필요 여부