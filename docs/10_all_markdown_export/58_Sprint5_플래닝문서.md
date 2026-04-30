---
source_html: 58_Sprint5_플래닝문서.html
exported: 2026-05-01
---

# 58번 — Sprint 5 플래닝 문서 · 소울나루

58번 — Sprint 5 플래닝 문서 · 소울나루 

# 📐 Sprint 5 플래닝 문서

**문서번호:** 58  | 
**버전:** v1.0  | 
**Sprint 기간:** 2026-05-01 ~ 2026-05-07 (7일)  | 
**작성:** PM Alex  | 
**작성일:** 2026-04-30

🚀 **Sprint 5 목표: 결제 연동 + Settings/Onboarding 씬 + 에셋 마무리 → Alpha 빌드 D-7 진입**

Sprint 5 완료 후 Sprint 6(CI/CD + 최종QA)에 진입, 5/14 Alpha 빌드 배포 목표.

## 1. Sprint 5 목표 분류

| 우선순위 | 목표 | 성공 기준 |
| --- | --- | --- |
| P0 | 인앱 결제 연동 (IAP) | iOS RevenueCat + Android 결제 플로우 E2E 동작, QA PASS |
| P0 | Settings.unity 씬 구현 | 알림 설정, 계정 관리, 로그아웃, 개인정보 링크 전부 동작 |
| P0 | Onboarding.unity 씬 구현 | 첫 실행 온보딩 3단계 + 권한 요청 (알림/추적) 완료 |
| P0 | Paywall.unity 씬 구현 | 구독 플랜 UI + 결제 버튼 + 복원 버튼 동작 |
| P1 | Album 버그 수정 (이월) | 연속 뒤로가기 3회 시 Garden 복귀 정상 동작 |
| P1 | 성능 테스트 1차 (Galaxy A32, 이월) | 30fps 유지, 메모리 ≤400MB |
| P1 | 소셜 기능 1차 (CX-16) | 감정 카드 공유 (SNS 이미지 생성) 기본 구현 |
| P2 | FCM 알림 개인화 | 감정 히스토리 기반 팔로업 메시지 다양화 (3종 이상) |

## 2. 팀별 Sprint 5 태스크 배분

### 💻 개발팀 (7일)

| 우선순위 | 태스크 | 담당 | 기간 |
| --- | --- | --- | --- |
| P0 | RevenueCat SDK 연동 + IAP 상품 등록 (월간·연간 구독) | 개발 A | 5/1~3 |
| P0 | Paywall.unity 씬 — UI + 결제 플로우 E2E | 개발 A+B | 5/1~4 |
| P0 | Settings.unity 씬 구현 (알림·계정·로그아웃) | 개발 C | 5/1~3 |
| P0 | Onboarding.unity 씬 (3단계 + 권한 요청) | 개발 B | 5/3~5 |
| P1 | Album 뒤로가기 버그 수정 | 개발 C | 5/1 |
| P1 | 소셜 공유 (SNS 이미지 생성) 기본 구현 | 개발 A | 5/5~6 |

### 🎨 아트팀 (7일)

| 우선순위 | 태스크 | 담당 | 기간 |
| --- | --- | --- | --- |
| P0 | Paywall 씬 UI 에셋 (배경, 아이콘, 버튼 디자인) | 아티스트 D | 5/1~2 |
| P0 | Onboarding 씬 일러스트 3장 (베니 소개·감정체크인·호흡) | 아티스트 E | 5/1~3 |
| P1 | Settings 씬 아이콘 세트 | 아티스트 D | 5/3 |
| P1 | 감정 공유 카드 템플릿 5종 (SNS 공유용) | 아티스트 E | 5/4~5 |
| P2 | App Store 스크린샷 5장 + Feature Graphic | 아티스트 D | 5/6~7 |

### 📋 기획/AI심리팀 (7일)

| 우선순위 | 태스크 | 담당 | 기간 |
| --- | --- | --- | --- |
| P0 | 구독 플랜 정책 확정 (월간/연간 가격, Free tier 제한) | 기획팀 | 5/1 |
| P0 | Onboarding 카피라이팅 (3단계 문구) | 기획팀 | 5/1~2 |
| P1 | FCM 알림 개인화 메시지 3종 작성 | AI심리팀 | 5/3~4 |
| P1 | 개인정보처리방침 + 이용약관 최종 확정 | 기획팀 | 5/5 |

### 🧪 QA팀 (7일)

| 우선순위 | 태스크 | 담당 | 기간 |
| --- | --- | --- | --- |
| P0 | IAP E2E 결제 테스트 (Sandbox 환경) | QA 전체 | 5/4~5 |
| P0 | Onboarding·Settings 씬 통합 테스트 | QA 전체 | 5/5~6 |
| P1 | Galaxy A32 성능 테스트 (이월) | QA 1인 | 5/1~2 |
| P1 | 전체 리그레션 테스트 (Debug Build v0.4.0) | QA 전체 | 5/6~7 |

## 3. 7일 타임라인

5/1 (금) — Sprint 5 킥오프

결제 연동 착수 + Settings 씬 착수 + 에셋 착수

구독 플랜 확정(기획팀 오전) → RevenueCat SDK 연동 시작 · Settings.unity 착수 · Paywall·Onboarding 에셋 착수

5/2~3 (토~일)

Paywall + Settings 완성 / Onboarding 착수

Settings 씬 완성(5/3) · Paywall UI 완성 · Album 버그 수정 완료 · Onboarding 착수

5/4~5 (월~화)

IAP E2E 완성 + QA 착수

Onboarding 씬 완성(5/5) · IAP Sandbox 테스트 QA 착수 · Galaxy A32 성능 측정 완료

5/6~7 (수~목)

Debug Build v0.4.0 + 전체 리그레션

Debug Build v0.4.0 생성 → QA 전체 리그레션 → Sprint 5 완료 심사 · Sprint 6 킥오프 준비

5/7 (목) — Sprint 5 마감

Sprint 5 완료 → Sprint 6 바로 시작 (5/8)

Alpha 빌드까지 D-7. Sprint 6: CI/CD + 최종 QA + App Store 제출 준비

## 4. Sprint 5 DoD (완료 기준)

| 항목 | 완료 기준 |
| --- | --- |
| IAP 결제 | iOS/Android Sandbox 결제 E2E QA PASS 3케이스 이상 |
| Settings 씬 | 알림·계정·로그아웃·개인정보 전 기능 동작 QA PASS |
| Onboarding 씬 | 3단계 온보딩 + 권한 요청 플로우 완성 QA PASS |
| Paywall 씬 | 구독 플랜 UI + 결제 버튼 + 복원 버튼 동작 QA PASS |
| 성능 테스트 | Galaxy A32 기준 30fps, 메모리 ≤400MB 확인 |
| 리그레션 | Debug Build v0.4.0 전체 씬 리그레션 Critical FAIL 0건 |

## 5. 리스크

| 리스크 | 영향 | 대응 |
| --- | --- | --- |
| RevenueCat Sandbox 승인 지연 | IAP 테스트 불가 → Sprint 6 이월 | 5/1 즉시 Apple·Google 개발자 계정에서 Sandbox 테스터 등록 |
| Onboarding 카피 확정 지연 | 씬 구현 착수 지연 | 기획팀 5/1 오전 내 확정 (Hard deadline) |
| 7일 Sprint 내 리그레션 부족 | Alpha 빌드 품질 저하 | P2 항목(FCM 개인화) Sprint 6으로 이월 허용 |

📋 관련 문서:
[57번 Sprint 4 완료](/benny/57_Sprint4_완료보고서.html) ·
[53번 전체 현황](/benny/53_전체현황_업데이트보고서.html) ·
[17번 BM 명세서](/benny/17_BM명세서_KPI_예산.html) ·
[26번 정원 오브젝트](/benny/26_정원_오브젝트_15종_목록.html)
