---
doc_number: 71
version: v1.0
updated: 2026-04-29
---

71번 — FB 중간 완료 & Sprint 5 준비 체크리스트 (4/30) · 소울나루 

 
 

 

# 🟡 FB 중간 항목 완료 & Sprint 5 준비 체크리스트 (4/30)

 
 **문서번호:** 71 | 
 **버전:** v1.0 | 
 **기준일:** 2026-04-30 | 
 **작성:** PM Alex | 
 **Sprint 5 시작(5/1) 전 최종 준비**
 

 
 🟡 **4/30 처리 목표** — FB 중간 6개 코드 반영 완료 + Sprint 5 준비 10개 항목 완료. 
 모든 항목 4/30 23:59까지 완료 시 5/1 Sprint 5 킥오프 정상 진행.
 

 

## PART 1 — FB 중간 항목 처리 (6개)

 
 
 FB-02 
 위기 분기 타이밍 — VARCO 호출 전 Level 3 처리 코드 반영 
 4/30 
 
 
 **반영 내용:** `CheckInFlowController.OnEmotionSubmit()`에서 CrisisEvaluator.Evaluate() 먼저 호출 → Level 3 시 VARCO 호출 없이 위기 UI 직행 (61번 기준) 
 **담당:** 개발 A + 기획팀 (분기 조건 최종 확인) 
 **검증:** CIS-01·02·03 케이스 재테스트로 VARCO 미호출 확인 
 
 

 
 
 FB-03 
 StreakRewardManager 구현 착수 — 스트릭 보상 분리 
 4/30 
 
 
 **반영 내용:** StreakRewardManager.cs 신규 생성. STREAK_OBJECT_MAP (3→1번, 7→2번, 14→3번, 30→6번) 상수 정의. GardenManager 통합 (63번 기준) 
 **담당:** 개발 B 
 **검증:** 스트릭 3·7·14·30일 시뮬레이션 → 오브젝트 부여 확인 (QA 팀) 
 
 

 
 
 FB-07 
 씬 전환 블랙 플래시 → 배경색 #F5F0FF 처리 
 4/30 
 
 
 **반영 내용:** `SceneTransitionManager.TransitionTo()`에서 Camera.main.backgroundColor = `new Color(0.961, 0.941, 1f)` 적용. allowSceneActivation 타이밍 조정 (61번 기준) 
 **담당:** 개발 C 
 **검증:** Garden↔Album, Garden↔CheckIn, Garden↔BreathingGuide 전환 시 블랙 플래시 없음 
 
 

 
 
 FB-10 
 BennyTree.prefab 계절 Prefab active=false 초기화 
 4/30 
 
 
 **반영 내용:** BennySeasonManager.Start()에서 현재 계절 제외 `SetActive(false)` 처리. Inspector에서 4개 Sub-Prefab 모두 active=false로 변경 (61번 기준) 
 **담당:** 개발 A 
 **검증:** 드로우콜 -3, 메모리 ~15MB 절감 확인 (Profiler) 
 
 

 
 
 FB-11 
 Benny_S5 Highlight Intensity HDR 1.0 → 0.3 적용 
 4/30 
 
 
 **반영 내용:** Benny_S5.mat → Inspector → Highlight Intensity 슬라이더 0.3으로 조정. 스크린샷 QA팀 공유 (64번 기준) 
 **담당:** 아트팀 
 **검증:** Galaxy S21 Ultra 실기에서 과도하지 않은 라벤더 발광 확인 
 
 

 
 
 FB-14 
 Day 13 MissionTimer 컴포넌트 설계 완료 
 4/30 
 
 
 **반영 내용:** MissionTimer.cs 신규 컴포넌트 설계 완료 (61번 기준). durationSeconds=180f (3분), MM:SS 텍스트, Progress Slider, onTimerComplete 이벤트. Sprint 5에서 구현 착수 (5/3~4 예정) 
 **담당:** 기획+개발 C 
 **검증:** Sprint 5 Day 13 씬 연동 후 3분 타이머 정확도 확인 
 
 

 

## PART 2 — Sprint 5 준비 사항 (4/30 완료)

### 💳 구독 정책 최종 확정

 
 
 🆓 Free 
 ₩0 
 무료 체험 
 
 
- 일일 체크인 3회
 
- 베니 1~2단계
 
- ACT Day 1~7
 
- 정원 기본 5종
 
- Album 최근 7일
 
- 위기 연결 항상 제공
 
 
 
 ⭐ Monthly 
 ₩6,900 
 / 월 · 7일 무료 체험 
 
 
- 체크인 무제한
 
- 베니 1~5단계
 
- ACT Day 1~30
 
- 정원 전체 15종
 
- Album 전체 기간
 
- BreathingGuide 무제한
 
 
 
 🏆 Annual 
 ₩59,000 
 / 년 · 29% 할인 · 7일 체험 
 
 
- Monthly 전체 포함
 
- 월 ₩4,917 환산
 
- 연간 29% 절약
 
- 우선 지원 배지
 
 
 

### 📲 Onboarding 3단계 카피라이팅

 
 1 
 
 베니 소개 (탈융합 원칙) 
 "안녕하세요! 저는 베니예요. 🐰 여러분의 감정을 함께 바라볼 작은 친구가 되고 싶어요. 매일 조금씩, 마음의 여유를 찾아가는 여정을 시작해봐요." 
 일러스트: 베니 2단계 + 환영 배경. 건너뛰기 버튼 제공. 
 
 
 
 2 
 
 감정 체크인 소개 
 "오늘 어떤 감정을 느끼셨나요? 🌿 기쁨, 슬픔, 불안, 화남… 어떤 감정이든 괜찮아요. 베니에게 솔직하게 말해주면 함께 살펴볼게요." 
 일러스트: 감정 아이콘 원형 배치. 체크인 화면 미리보기. 
 
 
 
 3 
 
 호흡 가이드 소개 + 권한 요청 
 "긴장될 때, 호흡을 함께 해봐요. 🌬️ 4초 들이쉬고, 4초 멈추고, 4초 내쉬는 것만으로 마음이 조금 더 편안해질 거예요." 
 호흡 애니메이션 미리보기. 완료 후 알림 권한 요청 (iOS). 
 
 

### ⚙️ Settings 씬 구성 최종 확정

 
 | 항목 | 세부 기능 | 비고 |

 | 알림 설정 | 전체 on/off + 일일 체크인 알림 시간 설정 | 시간 선택 피커 (HH:MM) |

 | 계정 관리 | 이름 변경 + 프로필 사진 | Supabase 연동 |

 | 구독 관리 | 현재 플랜 표시 + Paywall 이동 버튼 | RevenueCat CustomerInfo |

 | 로그아웃 | 확인 다이얼로그 후 로그아웃 | 세션 초기화 |

 | 개인정보처리방침 | 외부 링크 열기 | URL 기획팀 확정 필요 |

 | 이용약관 | 외부 링크 열기 | URL 기획팀 확정 필요 |

 | 버전 정보 | v0.4.0 표시 | 자동 주입 |

 | UI 위치 | 우측 상단 ⚙️ 아이콘 | Garden·Album·CheckIn 공통 |

 

### 🔧 기술 준비 사항 (개발팀)

 
 💻 개발팀 체크리스트 
 
 
- RevenueCat Unity SDK 4.x 패키지 설치
 
- RevenueCat 프로젝트 생성 + API Key 발급
 
- App Store Connect Sandbox 테스터 3명 등록
 
- Google Play 내부 테스트 트랙 생성 + 구독 상품 등록
 
- Paywall.unity 씬 기본 레이아웃 생성 (빈 씬)
 
- Settings.unity 씬 기본 레이아웃 생성 (빈 씬)
 
- Onboarding.unity 씬 기본 레이아웃 생성 (빈 씬)
 
- Sprint 5 브랜치 생성: `feature/sprint5-payment`
 
 

 
 🎨 아트팀 체크리스트 
 
 
- Paywall 씬 배경 디자인 초안 (5/1 착수용 레퍼런스)
 
- Onboarding 일러스트 3장 초안 (5/1~3 완성 목표)
 
- Settings 아이콘 6종 목록 정리
 
- cloud_soft.png 제작 착수 (60번 명세 기준)
 
- FB-11 Benny_S5 Highlight 0.3 적용
 
 

 
 📋 기획팀 체크리스트 
 
 
- 구독 정책 최종 확정 (위 플랜 카드 기준)
 
- Onboarding 3단계 카피라이팅 초안
 
- 개인정보처리방침 URL 확정
 
- 이용약관 URL 확정
 
- App Store 설명문 초안 (한국어·영어)
 
- Sprint 5 킥오프 미팅 일정 (5/1 오전 10시 확정?)
 
 

 
 🧪 QA팀 체크리스트 
 
 
- CIS-01~03 위기 케이스 실행 완료
 
- Galaxy A32 성능 테스트 준비 (기기·빌드·스크립트)
 
- Sandbox 테스터 계정 준비 (Apple ID, Google 계정)
 
- IAP-01~06 QA 케이스 작성 (5/4 실행용)
 
 

 

## PART 3 — 전체 FB 처리 현황 요약

 
 | FB ID | 내용 | 마감 | 상태 | 코드 반영 |

 | FB-01 | Day 10 시각화 UI 명세 | 4/29 | 완료 | Sprint 5 5/5~7 |

 | FB-05 | Album Firestore 프리로드 | 4/29 | 완료 | 4/29 코드 반영 |

 | FB-06 | 파티클 Stop 보장 | 4/29 | 완료 | 4/29 코드 반영 |

 | FB-13 | QA 위기 케이스 | 4/29 | 완료 | 4/29 오후 실행 |

 | FB-19 | 성능 테스트 Sprint 5 이월 | 4/28 | 완료 | 58번 반영 |

 | FB-20 | IAP 상품 등록 착수 | 4/29 | 진행 중 | 4/30 완료 |

 | FB-02 | 위기 분기 타이밍 | 4/30 | 오늘 | 4/30 코드 반영 |

 | FB-03 | 스트릭 보상 구분 | 4/30 | 오늘 | 4/30 구현 착수 |

 | FB-07 | 씬 전환 블랙 플래시 | 4/30 | 오늘 | 4/30 코드 반영 |

 | FB-10 | BennyTree Prefab 초기화 | 4/30 | 오늘 | 4/30 코드 반영 |

 | FB-11 | Highlight 0.3 | 4/30 | 오늘 | 4/30 아트 적용 |

 | FB-14 | Day 13 타이머 설계 | 4/30 | 오늘 | Sprint 5 5/3~4 |

 | FB-16 | 인텐셔널 침묵 구현 | Sprint 5 | 예정 | 5/4~5 |

 | FB-17 | VARCO 금기어 강화 | Sprint 5 | 예정 | 5/5~6 |

 

## 4. 5/1 Sprint 5 킥오프 아젠다 (초안)

 
 
- **Sprint 4 최종 확인** (5분) — FB 반영 현황 전체 체크
 
- **Sprint 5 목표 재확인** (5분) — P0 4개 씬, P1 버그·성능
 
- **팀별 Day 1 작업 배분** (10분) — 개발 A/B/C, 아트 D/E, QA
 
- **RevenueCat / IAP 착수 확인** (5분)
 
- **구독 정책 최종 공유** (5분)
 
- **일일 스탠드업 시간 확정** (5분) — 매일 오전 09:30 (30분)
 

 
 관련 문서:
 69번 ·
 70번 ·
 58번 Sprint5 플래닝 ·
 66번 협의 ·
 72번 킥오프