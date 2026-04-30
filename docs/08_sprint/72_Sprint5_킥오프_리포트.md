---
doc_number: 72
version: v1.0
updated: 2026-04-29
---

72번 — Sprint 5 킥오프 리포트 (5/1) · 소울나루 

 
 

 

# 🚀 Sprint 5 킥오프 리포트

 
 **문서번호:** 72 | 
 **버전:** v1.0 | 
 **Sprint 기간:** 2026-05-01 ~ 2026-05-07 (7일) | 
 **작성:** PM Alex | 
 **킥오프:** 5/1 오전 10:00
 

 
 🟢 **Sprint 5 킥오프 완료** — 결제 연동 + Settings/Onboarding/Paywall 씬 4개. Alpha 빌드까지 D-13.
 

 
 7일 Sprint 기간 
 4 P0 목표 
 D-13 Alpha 빌드 
 D-30 스토어 제출 
 

## 1. Sprint 5 목표 (P0~P2)

 
 | 우선순위 | 목표 | 성공 기준 | 담당 |

 | P0 | RevenueCat IAP 연동 | iOS/Android Sandbox E2E QA PASS 3케이스 | 개발 A |

 | P0 | Paywall.unity 씬 | 구독 플랜 UI + 결제 + 복원 동작 QA PASS | 개발 A+B |

 | P0 | Settings.unity 씬 | 알림·계정·로그아웃·개인정보 전 기능 QA PASS | 개발 C |

 | P0 | Onboarding.unity 씬 | 3단계 온보딩 + 권한 요청 QA PASS | 개발 B |

 | P1 | Album 뒤로가기 버그 수정 | 연속 3회 뒤로가기 후 Garden 정상 복귀 | 개발 C |

 | P1 | Galaxy A32 성능 테스트 | 30fps 유지, 메모리 ≤400MB | QA |

 | P1 | 소셜 공유 기본 구현 | 감정 카드 SNS 이미지 생성 기능 | 개발 A |

 | P2 | FCM 알림 개인화 | 히스토리 기반 팔로업 메시지 3종 | AI심리팀 |

 | P2 | FB-16 인텐셔널 침묵 | 베니 2.5초 응답 지연 | 개발+AI |

 | P2 | FB-17 VARCO 금기어 강화 | 임베딩 기반 필터 검토 | AI심리팀 |

 

## 2. 7일 타임라인

 
 
 
 5/1 (금) — Day 1 · 오늘 
 결제 연동 착수 + Settings 씬 착수 + 에셋 착수 
 
 개발 A: RevenueCat SDK 설치 + Configure() 호출 + iOS Sandbox 연결 
 개발 C: Settings.unity 씬 생성 + UI 레이아웃 
 개발 A+B: Paywall.unity 씬 골격 + 에셋 연결 준비 
 아트 D: Paywall 배경·버튼 에셋 작업 시작 
 아트 E: Onboarding 일러스트 3장 착수 
 QA: Galaxy A32 성능 테스트 시작
 
 
 
 
 5/2 (토) — Day 2 
 RevenueCat Offerings 로드 + Settings 기능 구현 
 
 개발 A: GetOfferingsAsync() 구현 + 상품 목록 표시 
 개발 C: Settings 알림 설정·계정 관리 구현 
 개발 B: Paywall UI 완성 
 QA: Galaxy A32 30fps 테스트 완료 (D-2)
 
 
 
 
 5/3 (일) — Day 3 
 Settings 씬 완성 + Onboarding 착수 + Paywall 결제 구현 
 
 개발 C: Settings 씬 전 기능 완성 (로그아웃·개인정보·버전) 
 개발 B: Onboarding.unity 씬 착수 (3단계 흐름) 
 개발 A: PurchasePackageAsync() 결제 플로우 구현 
 AI심리팀: FB-16 인텐셔널 침묵 DialogueController 착수
 
 
 
 
 5/4 (월) — Day 4 
 IAP E2E QA 착수 + Onboarding 2단계 완성 
 
 QA: IAP-01~03 Sandbox 결제 테스트 시작 
 개발 B: Onboarding 2단계 감정 체크인 소개 완성 
 개발 A: 소셜 공유 기본 구현 착수 
 아트 E: Onboarding 일러스트 2장 완성
 
 
 
 
 5/5 (화) — Day 5 
 Onboarding 씬 완성 + IAP QA 완료 
 
 개발 B: Onboarding 씬 전체 완성 (3단계 + 권한 요청) 
 QA: IAP-04~06 복원·실패 케이스 완료 
 개발 A: 소셜 공유 완성 
 FB-16: 인텐셔널 침묵 구현 완료
 
 
 
 
 5/6 (수) — Day 6 
 Debug Build v0.4.0 생성 + 전체 리그레션 시작 
 
 개발 전체: Debug Build v0.4.0 (Android·iOS) 생성 
 QA 전체: Onboarding·Settings 통합 테스트 
 아트 D: App Store 스크린샷 5장 착수 
 AI심리팀: FB-17 VARCO 금기어 검토 완료
 
 
 
 
 🎯 5/7 (목) — Day 7 · Sprint 5 마감 
 전체 리그레션 완료 + Sprint 5 DoD 달성 확인 
 
 QA 전체: Debug v0.4.0 전체 씬 리그레션 Critical FAIL 0건 목표 
 PM: Sprint 5 DoD 심사 → 완료 선언 
 Sprint 6 킥오프 준비 (5/8 시작)
 
 
 

## 3. 팀별 Day 1 (5/1) 작업 목록

 
 | 팀 | 담당자 | Day 1 작업 | 완료 기준 |

 | 개발 A | — | RevenueCat SDK 설치 + Configure() + iOS Sandbox 연결 | Sandbox 연결 성공 로그 |

 | 개발 B | — | Paywall.unity 씬 골격 + 아트 에셋 placeholder 배치 | 씬 로드 성공 |

 | 개발 C | — | Settings.unity 씬 생성 + 알림 on/off UI 구현 | 토글 동작 확인 |

 | 아트 D | — | Paywall 배경 이미지 + 버튼 에셋 v1 (1920×1080) | Unity import 가능 PNG |

 | 아트 E | — | Onboarding 1단계 일러스트 (베니 소개) | PNG 1080×1920 |

 | QA | — | Galaxy A32 성능 테스트 (Debug v0.3.0 기준) | fps·메모리 수치 기록 |

 | 기획팀 | — | 킥오프 미팅 진행 + 구독 정책 팀 공유 | 팀 질의 응답 완료 |

 

## 4. Sprint 5 DoD (완료 기준)

 
 | 항목 | 완료 기준 | 담당 |

 | IAP 결제 | iOS/Android Sandbox 결제 E2E QA PASS 3케이스 이상 | 개발 A |

 | Paywall 씬 | 구독 플랜 UI + 결제 버튼 + 복원 버튼 모두 동작 QA PASS | 개발 A+B |

 | Settings 씬 | 알림·계정·로그아웃·개인정보 전 기능 QA PASS | 개발 C |

 | Onboarding 씬 | 3단계 온보딩 + 권한 요청 플로우 QA PASS | 개발 B |

 | 성능 테스트 | Galaxy A32 30fps, 메모리 ≤400MB 확인 | QA |

 | 전체 리그레션 | Debug Build v0.4.0 Critical FAIL 0건 | QA |

 

## 5. 리스크 관리

 
 **🔴 R1: RevenueCat Sandbox 승인 지연** 
 
 확률: 중간 | 영향: IAP Sprint 5 내 완료 불가 
 대응: 5/1 즉시 Apple·Google 테스터 등록. 지연 시 결제 UI만 완성 후 IAP는 Sprint 6 이월 허용.
 
 
 
 **🟡 R2: Onboarding 카피 확정 지연** 
 
 확률: 낮음 | 영향: 씬 구현 착수 지연 
 대응: 71번 카피 초안 사용. 기획팀 4/30 확정 완료.
 
 
 
 **🟡 R3: Galaxy A32 30fps 미달** 
 
 확률: 낮음 | 영향: 최적화 Sprint 6 추가 
 대응: 이미지 레이어 압축 + 파티클 수 감소 fallback 준비.
 
 

## 6. 킥오프 미팅 결과

 
 | 항목 | 확정 내용 |

 | 킥오프 시간 | 5/1 오전 10:00 (30분) |

 | 일일 스탠드업 | 매일 오전 09:30 (15분) |

 | 리포트 담당 | PM Alex — 매일 오후 18:00 진행 상황 정리 |

 | Sprint 5 브랜치 | `feature/sprint5-payment` |

 | 빌드 배포 채널 | Slack #benny-qa 채널 업로드 |

 | 긴급 이슈 채널 | Slack #benny-alert (blocker 즉시 공유) |

 

 
 관련 문서:
 71번 ·
 70번 IAP ·
 73번 결제 기술명세 ·
 74번 Settings·Onboarding ·
 58번 플래닝