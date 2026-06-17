# OpenManager Harness Release Checklist 템플릿

## 1. Release 개요

| 항목 | 내용 |
|---|---|
| Release ID |  |
| Release 일자 |  |
| 작성자 |  |
| 대상 브랜치 | `feature/om-harness-bootstrap` |
| Release 유형 | 신규 적용 / 변경 적용 / 보완 적용 / 긴급 수정 |
| Release 상태 | 준비 / 검토 / 승인 / 적용 완료 / 보류 |

## 2. Release 대상 요약

```text
이번 Release 또는 운영 적용의 목적을 요약한다.
예: 15단계 운영 적용 기준과 유지관리 체계를 하네스에 반영한다.
```

## 3. Release 대상 파일

### 생성 파일

| 파일 | 설명 |
|---|---|
|  |  |

### 수정 파일

| 파일 | 설명 |
|---|---|
|  |  |

### 삭제 파일

| 파일 | 설명 |
|---|---|
|  |  |

### 변경 제외 파일

| 파일 | 제외 사유 |
|---|---|
|  |  |

## 4. 하네스 구성 요소 영향 확인

| 구성 요소 | 영향 여부 | 확인 내용 |
|---|---:|---|
| Steering / `CLAUDE.md` |  | 프로젝트 기준 변경 여부 |
| Rule |  | `.claude/rules/om/` 기준 변경 여부 |
| Skill |  | `.claude/skills/` 신규 또는 변경 여부 |
| Agent |  | `.claude/agents/om/` 신규 또는 변경 여부 |
| Hook |  | `.claude/hooks/om/` 변경 여부 |
| MCP |  | `.mcp.json`, MCP 정책 변경 여부 |
| Workflow |  | `docs/harness/workflows/` 변경 여부 |
| Template |  | `docs/harness/templates/` 변경 여부 |
| Scenario |  | `docs/harness/scenarios/` 변경 여부 |
| Inventory |  | `docs/harness/*INVENTORY.md` 변경 여부 |
| Script |  | `docs/harness/scripts/` 변경 여부 |

## 5. 운영 적용 전 필수 확인

| 확인 항목 | 결과 | 비고 |
|---|---|---|
| 요청 목적이 명확한가 | PASS / WARN / FAIL |  |
| 변경 범위가 현재 Release 대상에 한정되는가 | PASS / WARN / FAIL |  |
| 기존 구현 또는 기존 하네스 구조를 확인했는가 | PASS / WARN / FAIL |  |
| Search-First 분석이 필요한 경우 수행했는가 | PASS / WARN / FAIL / N/A |  |
| Change Plan이 필요한 경우 작성했는가 | PASS / WARN / FAIL / N/A |  |
| 사용자 승인 필요 항목을 식별했는가 | PASS / WARN / FAIL |  |
| 운영 영향이 있는 명령을 실행하지 않았는가 | PASS / WARN / FAIL |  |
| 실제 배포 명령이 포함되지 않았는가 | PASS / WARN / FAIL |  |

## 6. Rule 점검

| 항목 | 결과 | 비고 |
|---|---|---|
| 공통 Rule 적용 기준이 유지되는가 | PASS / WARN / FAIL |  |
| 경로별 Rule이 변경 요청 유형과 맞는가 | PASS / WARN / FAIL |  |
| 기존 Rule과 충돌하지 않는가 | PASS / WARN / FAIL |  |
| Security Policy 기준이 약화되지 않았는가 | PASS / WARN / FAIL |  |
| Quality Gate 기준이 유지되는가 | PASS / WARN / FAIL |  |

## 7. Skill 점검

| 항목 | 결과 | 비고 |
|---|---|---|
| Skill 목적이 명확한가 | PASS / WARN / FAIL |  |
| Skill frontmatter가 정상인가 | PASS / WARN / FAIL |  |
| `name`이 명시되어 있는가 | PASS / WARN / FAIL |  |
| `description`이 명시되어 있는가 | PASS / WARN / FAIL |  |
| `allowed-tools`가 과도하지 않은가 | PASS / WARN / FAIL |  |
| 불필요한 `Write`, `Edit`, 운영 명령 권한이 없는가 | PASS / WARN / FAIL |  |
| 관련 Workflow / Template과 연결되는가 | PASS / WARN / FAIL |  |

## 8. Agent 점검

| 항목 | 결과 | 비고 |
|---|---|---|
| Agent 역할이 명확한가 | PASS / WARN / FAIL / N/A |  |
| 기존 Agent와 역할이 과도하게 중복되지 않는가 | PASS / WARN / FAIL / N/A |  |
| OpenManager 전문 Agent 경계가 유지되는가 | PASS / WARN / FAIL |  |
| 기존 SigNoz Playwright Agent가 수정되지 않았는가 | PASS / WARN / FAIL |  |
| upstream 경계 기준이 유지되는가 | PASS / WARN / FAIL |  |

## 9. Hook / Guardrail 점검

| 항목 | 결과 | 비고 |
|---|---|---|
| 위험 명령 차단 Hook이 유지되는가 | PASS / WARN / FAIL |  |
| 민감 파일 보호 Hook이 유지되는가 | PASS / WARN / FAIL |  |
| Tool 사용 로그 Hook이 유지되는가 | PASS / WARN / FAIL |  |
| 기존 Hook 파일이 임의 수정되지 않았는가 | PASS / WARN / FAIL |  |
| Hook 변경이 필요한 경우 승인 항목으로 분리했는가 | PASS / WARN / FAIL / N/A |  |

## 10. 보안 및 민감 정보 점검

아래 파일 또는 정보가 Release 대상에 포함되지 않아야 한다.

```text
.env
.pem
.key
.p12
.pfx
id_rsa
id_ed25519
.kube
.aws
.ssh
settings.local.json
claude.json
```

| 항목 | 결과 | 비고 |
|---|---|---|
| `.env` 파일 미포함 | PASS / WARN / FAIL |  |
| 인증서 또는 key 파일 미포함 | PASS / WARN / FAIL |  |
| SSH key 미포함 | PASS / WARN / FAIL |  |
| kubeconfig 미포함 | PASS / WARN / FAIL |  |
| AWS credential 미포함 | PASS / WARN / FAIL |  |
| `settings.local.json` 미추적 | PASS / WARN / FAIL |  |
| Secret 원문 미기록 | PASS / WARN / FAIL |  |
| password, token, api key 원문 미포함 | PASS / WARN / FAIL |  |

## 11. Workflow / Template 점검

| 항목 | 결과 | 비고 |
|---|---|---|
| Workflow 절차가 실제 작업 흐름과 맞는가 | PASS / WARN / FAIL |  |
| Template 기록 항목이 충분한가 | PASS / WARN / FAIL |  |
| PASS / WARN / FAIL 기준이 명확한가 | PASS / WARN / FAIL |  |
| 승인 필요 항목이 기록되는가 | PASS / WARN / FAIL |  |
| Change History와 Tool Usage Audit에 연결되는가 | PASS / WARN / FAIL |  |

## 12. Inventory 점검

| Inventory | 결과 | 비고 |
|---|---|---|
| MCP Inventory | PASS / WARN / FAIL / N/A |  |
| Quality Gates Inventory | PASS / WARN / FAIL / N/A |  |
| Audit Trail Inventory | PASS / WARN / FAIL / N/A |  |
| Scenario Validation Inventory | PASS / WARN / FAIL / N/A |  |
| Harness Operation Inventory | PASS / WARN / FAIL / N/A |  |

## 13. 점검 스크립트 확인

| 항목 | 결과 | 비고 |
|---|---|---|
| 현재 단계 전용 점검 스크립트가 있는가 | PASS / WARN / FAIL |  |
| 통합 점검 스크립트를 작성하지 않았는가 | PASS / WARN / FAIL |  |
| Shell 문법이 정상인가 | PASS / WARN / FAIL |  |
| 실행 권한이 있는가 | PASS / WARN / FAIL |  |
| `FAIL=0` 기준을 만족하는가 | PASS / WARN / FAIL |  |

## 14. Git 점검

| 항목 | 결과 | 비고 |
|---|---|---|
| 대상 브랜치가 맞는가 | PASS / WARN / FAIL |  |
| Stage 파일이 Release 범위에 한정되는가 | PASS / WARN / FAIL |  |
| 민감 파일이 Stage에 포함되지 않았는가 | PASS / WARN / FAIL |  |
| Commit 메시지에 단계와 목적이 포함되는가 | PASS / WARN / FAIL |  |
| Push 전 사용자 승인이 있는가 | PASS / WARN / FAIL / N/A |  |

## 15. 사용자 승인 필요 항목

| 승인 항목 | 필요 여부 | 사유 | 승인 상태 |
|---|---:|---|---|
| 운영 명령 실행 |  |  | 승인 / 미승인 / N/A |
| Git Push |  |  | 승인 / 미승인 / N/A |
| 기존 Hook 변경 |  |  | 승인 / 미승인 / N/A |
| 기존 Agent 변경 |  |  | 승인 / 미승인 / N/A |
| Tool 권한 확대 |  |  | 승인 / 미승인 / N/A |
| Secret 또는 인증 설정 변경 |  |  | 승인 / 미승인 / N/A |
| 대량 파일 변경 |  |  | 승인 / 미승인 / N/A |

## 16. Release 최종 판단

| 항목 | 결과 |
|---|---|
| Release 가능 여부 | 가능 / 보류 / 불가 |
| 보류 사유 |  |
| 추가 조치 |  |
| 승인자 |  |
| 승인 일자 |  |

## 17. 최종 요약

```text
Release 또는 운영 적용 전 확인 결과를 요약한다.
Secret 원문, 인증 정보, 개인 설정 파일 내용은 기록하지 않는다.
WARN 또는 FAIL 항목이 있으면 Release 전에 보완한다.
```