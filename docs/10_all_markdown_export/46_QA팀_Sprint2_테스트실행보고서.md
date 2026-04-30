---
source_html: 46_QA팀_Sprint2_테스트실행보고서.html
exported: 2026-05-01
---

# 46번 — QA팀 Sprint 2 테스트 실행 보고서 · 소울나루

46번 — QA팀 Sprint 2 테스트 실행 보고서 · 소울나루 

🧪 QA팀 Sprint 2 테스트 실행 보고서

문서번호: 46  |  버전: v1.0  |  Sprint 기간: 2026-04-14 ~ 2026-04-20  |  작성: QA팀 리드

테스트 환경: Galaxy S21 Ultra (Android 14) + iPhone 13 Pro (iOS 17.4)  |  기준일: 2026-04-16

18
PASS

4
FAIL

7
진행중

5
미착수

⚠️ Sprint 2 QA 현황 (4/16 기준)

전체 34개 테스트 케이스 중 18개 PASS. FCM 알림 실제 발송 테스트(FCM-01~03) 및 1393 버튼 실제 전화연결(FCM-05)이 **미완료**입니다. 4/20 마감 전 완료 필요.

## 1. 테스트 환경

| 항목 | Android | iOS |
| --- | --- | --- |
| 기기 | Samsung Galaxy S21 Ultra | Apple iPhone 13 Pro |
| OS 버전 | Android 14 (One UI 6.1) | iOS 17.4.1 |
| Unity 빌드 | Debug Build v0.2.1 | Debug Build v0.2.1 |
| 백엔드 | Firebase Staging (us-central1) | Firebase Staging (us-central1) |
| VARCO API | Staging Endpoint | Staging Endpoint |
| 테스트 계정 | qa_android@soulnaru.test | qa_ios@soulnaru.test |

## 2. Sprint 2 테스트 케이스 — 감정 체크인

| ID | 테스트 시나리오 | 기대 결과 | Android | iOS | 비고 |
| --- | --- | --- | --- | --- | --- |
| CI-01 | 감정 선택 Step 1 진입 | 5감정 카드 표시, 각 카드 탭 가능 | PASS | PASS | 38번 UI v1.3 기준 |
| CI-02 | 기쁨 선택 → 강도 1 탭 | EmotionLog {joy, 1} Firestore 저장 | PASS | PASS | Firestore 실시간 확인 |
| CI-03 | 슬픔 강도 5 선택 | 베니 위로 모드 진입, 말풍선 표시 | PASS | PASS | ANIM_Comfort 재생 |
| CI-04 | 불안 강도 4 → 위기 감지 분기 | 1393 버튼 노출 여부 | PASS | PASS | 위기 임계값 3+ 확인 |
| CI-05 | 체크인 완료 → 성장 포인트 +15 | GardenManager 포인트 반영 | PASS | PASS | |
| CI-06 | Step 3 확인 → "다시 선택" 탭 | Step 2로 돌아감 | PASS | PASS | |
| CI-07 | 체크인 도중 앱 백그라운드 → 재진입 | 마지막 Step 상태 유지 | FAIL | FAIL | Step 1로 리셋됨 — 이슈 QA-F01 |
| CI-08 | 하루 2회 이상 체크인 시도 | 두 번째 체크인 정상 허용 | PASS | PASS | 제한 없음 확인 |

## 3. BreathingGuide 씬 테스트

| ID | 테스트 시나리오 | 기대 결과 | Android | iOS | 비고 |
| --- | --- | --- | --- | --- | --- |
| BG-01 | BreathingGuide 씬 진입 | UI 렌더링 정상 | 진행중 | 진행중 | 개발팀 구현 4/17 마감 대기 |
| BG-02 | 4-4-4-4 타이머 정확도 | ±0.1초 이내 | 진행중 | 진행중 | 씬 구현 후 즉시 테스트 |
| BG-03 | Hold-in 상태 색상 확인 | #5B21B6 다크퍼플 표시 | 진행중 | 진행중 | CX-06 검증 |
| BG-04 | 3사이클 완료 후 결과 저장 | BreathingSession Firestore 저장 | 진행중 | 진행중 | |
| BG-05 | 중간 일시정지 → 재시작 | 현재 카운트에서 재개 | 진행중 | 진행중 | |
| BG-06 | VoiceOver 레이블 확인 (iOS) | accessibilityLabel 정확 읽기 | N/A | 진행중 | CX-07 검증 |

## 4. FCM 알림 테스트 (CX-12 신규 등록)

| ID | 테스트 시나리오 | 기대 결과 | Android | iOS | 상태 |
| --- | --- | --- | --- | --- | --- |
| FCM-01 | 위기 감지 후 24시간 팔로업 알림 | 24h 후 FCM 실제 수신 | 미착수 | 미착수 | 테스트 계정으로 4/17 시작 예정 |
| FCM-02 | VARCO 5회 초과 → 제한 메시지 | "내일 다시 대화해요" UI 노출 | PASS | PASS | |
| FCM-03 | 백그라운드 알림 탭 → 씬 이동 | Garden.unity 직접 이동 | 미착수 | 미착수 | FCM-01 완료 후 연계 |
| FCM-04 | 오프라인 → 감정 기록 → 복구 동기화 | 오프라인 큐 → Firestore 동기화 | PASS | PASS | DataSyncManager 정상 동작 |
| FCM-05 | 1393 버튼 탭 → 전화 연결 | 전화 앱 실행 + 1393 다이얼 | 미착수 | 미착수 | Apple 심사 필수 — 4/17 테스트 |

## 5. VARCO API 연동 테스트

| ID | 시나리오 | 기대 결과 | 결과 | 비고 |
| --- | --- | --- | --- | --- |
| API-01 | 정상 감정 체크인 → VARCO 응답 | 2초 이내 응답, 말풍선 표시 | PASS | 평균 응답 1.3초 |
| API-02 | VARCO 응답 없음 (5s 타임아웃) | 폴백 메시지 표시 | PASS | 폴백: "베니가 생각 중이에요..." |
| API-03 | 위기 감지 프롬프트 응답 품질 | 공감 메시지 (비지시적) | FAIL | 일부 응답에 지시적 문구 포함 — 이슈 QA-F02 |
| API-04 | 무료 5회 제한 후 응답 | 제한 UI + 구독 유도 | PASS | |
| API-05 | 네트워크 재연결 시 VARCO 재시도 | 자동 재시도 1회 후 표시 | FAIL | 재연결 후 스피너 무한 — 이슈 QA-F03 |

## 6. 베니 스프라이트 렌더링 테스트

| ID | 시나리오 | 기대 결과 | 결과 | 비고 |
| --- | --- | --- | --- | --- |
| SP-01 | 3단계 기쁨 Lv5 스프라이트 표시 | #FCA5A5 뺨 렌더링 정상 | PASS | CX-11 확인 |
| SP-02 | 4단계 슬픔 Lv3 → 위로 반응 | 슬픔 표정 + 위로 말풍선 | PASS | |
| SP-03 | 5단계 평온 Lv1 표시 | #4ADE80 나뭇잎 장식 표시 | PASS | |
| SP-04 | 스프라이트 로딩 → 표시 지연 | 0.1초 이내 전환 | FAIL | 첫 로딩 0.4초 지연 — QA-F04 (어드레서블 캐싱 필요) |
| SP-05 | 감정 강도 1→5 연속 탭 | 스프라이트 순차 교체 | PASS | |

## 7. FAIL 이슈 상세

🔴 QA-F01 — 체크인 백그라운드 복귀 시 Step 리셋

**재현 조건**: Step 2 강도 선택 화면에서 홈버튼 → 앱 재진입

**현상**: CheckInManager 상태가 Initial로 리셋, Step 1부터 다시 시작

**담당**: 개발팀  |  **우선순위**: 🔴 긴급  |  **마감**: 4/17

**수정 방향**: CheckInManager.OnApplicationPause()에서 currentStep 직렬화 유지

🔴 QA-F02 — VARCO 위기 응답 품질 미흡

**현상**: "그렇게 느끼면 안 돼요", "빨리 나아질 거예요" 등 지시적·축소적 문구 포함

**담당**: AI심리팀  |  **우선순위**: 🔴 긴급 (05번 금기어 목록 추가 필요)

**수정 방향**: 05번 금기어 목록 업데이트, VARCO 프롬프트 강화

🟡 QA-F03 — 네트워크 재연결 후 VARCO 스피너 무한

**현상**: 오프라인 → 온라인 전환 후 VARCO 요청이 무한 로딩 상태

**담당**: 개발팀  |  **우선순위**: 🟡 중간  |  **마감**: 4/19

**수정 방향**: DataSyncManager.OnNetworkRestore()에서 pending VARCO 요청 재시도 로직 추가

🟡 QA-F04 — 스프라이트 첫 로딩 지연 0.4초

**현상**: 첫 실행 시 스프라이트 번들 로딩으로 0.4초 화면 공백

**담당**: 개발팀  |  **우선순위**: 🟡 중간

**수정 방향**: Addressables 프리로드를 Garden.unity 씬 진입 시 선제 로딩

## 8. Sprint 2 QA 일정

| 날짜 | QA 작업 | 담당 | 상태 |
| --- | --- | --- | --- |
| 4/14~15 | CheckIn + VARCO + 스프라이트 기본 케이스 | QA 리드 | 완료 |
| 4/16 | FAIL 이슈 리포트, FCM 테스트 준비 | QA 리드 | 완료 (본 문서) |
| 4/17 | BreathingGuide 씬 테스트, FCM-01·03·05 착수 | QA 팀원 A+B | 예정 |
| 4/18 | QA-F01·F03 수정 검증, 리그레션 | QA 리드 | 미착수 |
| 4/19~20 | 전체 통합 테스트, Sprint 2 최종 리포트 | QA 전체 | 미착수 |

📋 관련 문서

[14번 — 테스트 계획서 & QA 체크리스트](14_테스트계획서_QA체크리스트.html)  | 
[15번 — 성능 테스트 문서](15_성능테스트문서.html)  | 
[44번 — 크로스체크 개선 보고서](44_크로스체크_개선적용보고서.html)
