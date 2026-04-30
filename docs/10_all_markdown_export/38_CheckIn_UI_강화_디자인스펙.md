---
source_html: 38_CheckIn_UI_강화_디자인스펙.html
exported: 2026-05-01
---

# Check-In UI 강화 디자인 스펙 — 소울나루

Check-In UI 강화 디자인 스펙 — 소울나루 

# Check-In UI 강화 디자인 스펙

**문서번호**: 38

**카테고리**: 아트 / UI 디자인

**담당**: 아티스트 A (UI 디자인)

**작성**: AI PM Alex

**작성일**: 2026-04-15

**원래 마감**: 2026-04-09 13:00 ✅ 4/16 완료 확정 

**관련 문서**: 04_AI감정반응엔진설계서.html, 06_감정데이터분류체계.html, 13_애니메이션설계_UIUX상세.html

## 1. 개요

Check-In UI는 사용자가 매일 자신의 감정 상태를 베니에게 알려주는 핵심 인터랙션 화면입니다. Sprint 1의 기본 체크인 기능을 강화하여 **5가지 감정 × 5가지 강도 = 25개 조합**을 직관적으로 선택할 수 있는 UI로 개편합니다.

**✅ Sprint 2 블로킹 해소 (4/16)**

개발팀 Check-In UI v2 적용(마감 4/17)이 이 Figma 스펙에 의존합니다. **4/15(오늘) 내 완료** 필수.

## 2. 산출물 목록

| 산출물 | 형식 | 수량 | 요구 해상도 | 상태 |
| --- | --- | --- | --- | --- |
| Figma 파일 — 5감정×5강도 선택 UI | .fig (공유 링크) | 1개 | 390×844px (iPhone 14) | ✅ 완료 |
| PNG 시안 — 감정 선택 Step 1 | PNG | 1장 | 390×844px + @2x | ✅ 완료 |
| PNG 시안 — 강도 선택 Step 2 (감정별 5종) | PNG | 5장 | 390×844px + @2x | ✅ 완료 |
| PNG 시안 — 확인 Step 3 | PNG | 1장 | 390×844px + @2x | ✅ 완료 |
| PNG 시안 — 완료/응답 화면 | PNG | 1장 | 390×844px + @2x | ✅ 완료 |

✅ **v1.3 이미지 업데이트 (2026-04-16)** — CX-01·07 반영 개선 시안  | 
피곤 감정 제거 (5감정 체계) · 이모지+텍스트 동시 표시 · 강도 크기 차등 표현 · 접근성 강화

![Step1](assets/ui/CheckIn_step1_emotion.png)

Step 1 — 감정 선택 5감정 카드 CX-01✅ 

![joy](assets/ui/CheckIn_step2_joy.png)

Step 2 — 기쁨 😊 강도 1~5 

![sad](assets/ui/CheckIn_step2_sad.png)

Step 2 — 슬픔 😢 강도 1~5 

![angry](assets/ui/CheckIn_step2_angry.png)

Step 2 — 화남 😠 강도 1~5 

![anxious](assets/ui/CheckIn_step2_anxious.png)

Step 2 — 불안 😰 강도 1~5 

![calm](assets/ui/CheckIn_step2_calm.png)

Step 2 — 평온 😌 강도 1~5 

![step3](assets/ui/CheckIn_step3_confirm.png)

Step 3 — 확인 베니 응답 

![complete](assets/ui/CheckIn_complete.png)

완료 화면 🎉 +15포인트 

## 3. 감정 분류 체계 (5×5 매트릭스)

06번 문서(감정데이터분류체계)에 정의된 체계를 UI에 구현합니다.

### 3-1. 5가지 감정 카테고리

| 감정 ID | 한국어 레이블 | 이모지 | 색상 코드 | 베니 스프라이트 카테고리 |
| --- | --- | --- | --- | --- |
| JOY | 기쁨 | 😊 | #FCD34D | joy_01 ~ joy_05 |
| SAD | 슬픔 | 😢 | #93C5FD | sad_01 ~ sad_05 |
| ANGRY | 화남 | 😠 | #FCA5A5 | angry_01 ~ angry_05 |
| ANXIOUS | 불안 | 😰 | #D8B4FE | anxious_01 ~ anxious_05 |
| CALM | 평온 | 😌 | #6EE7B7 | calm_01 ~ calm_05 |

### 3-2. 5가지 강도 레벨

| 강도 ID | 숫자 | 레이블 | 시각적 표현 | 베니 스프라이트 인덱스 |
| --- | --- | --- | --- | --- |
| LVL_1 | 1 | 아주 조금 | 원형 크기 최소 (36px) | _01 (가장 약한 표현) |
| LVL_2 | 2 | 조금 | 원형 크기 소 (44px) | _02 |
| LVL_3 | 3 | 보통 | 원형 크기 중 (52px) | _03 |
| LVL_4 | 4 | 많이 | 원형 크기 대 (60px) | _04 |
| LVL_5 | 5 | 아주 많이 | 원형 크기 최대 (72px) | _05 (가장 강한 표현) |

## 4. UI 플로우 (3단계)

### Step 1 — 감정 카테고리 선택

| 영역 | 위치 | 크기 | 설명 |
| --- | --- | --- | --- |
| 베니 인사 영역 | Top 80px, 중앙 | 180×180px | 베니 캐릭터 + 말풍선 "오늘 기분이 어때요?" |
| 감정 카드 그리드 | Top 320px | 340×280px | 5개 감정 카드 배치 (3+2 또는 가로 스크롤 5개) |
| 감정 카드 (개별) | 그리드 내 | 100×100px | 이모지(40px) + 레이블(14px) + 감정 색상 배경 |
| 건너뛰기 링크 | 하단 140px | 전체 너비 | 텍스트 링크 "오늘은 건너뛸게요" |

### Step 2 — 강도 선택

| 영역 | 위치 | 크기 | 설명 |
| --- | --- | --- | --- |
| 선택된 감정 표시 배지 | Top 80px | 120×40px | 선택된 감정 이모지 + 레이블 pill 형태 |
| 베니 감정 표현 | Top 140px, 중앙 | 180×180px | 선택된 감정에 맞는 베니 스프라이트 (강도 3 기준으로 미리 표시) |
| 강도 슬라이더/선택 UI | Top 360px | 340×80px | 5개 원형 버튼 가로 배열 (크기 차등: 36→44→52→60→72px) |
| 강도 레이블 | 슬라이더 아래 8px | 340×20px | "아주 조금" ——————————— "아주 많이" |
| 베니 반응 업데이트 | 베니 영역 (실시간) | - | 강도 버튼 선택 시 베니 스프라이트 실시간 전환 |
| 다음 버튼 | 하단 88px | 340×52px | 강도 선택 후 활성화 |

### Step 3 — 확인 및 완료

| 영역 | 위치 | 크기 | 설명 |
| --- | --- | --- | --- |
| 감정+강도 요약 카드 | Top 100px | 320×120px | 선택된 감정/강도 조합 시각적 요약 |
| 베니 응답 | Top 260px | 180×180px | 최종 감정 상태 베니 스프라이트 |
| 베니 코멘트 | 베니 아래 16px | 300×60px | 말풍선: AI 감정 응답 한 줄 (예: "기쁜 날이네요! 오늘도 함께해요 🌸") |
| 기록 완료 버튼 | 하단 88px | 340×52px | "체크인 완료" → 홈 이동 |
| 메모 추가 링크 | 완료 버튼 위 12px | 전체 너비 | 텍스트 링크 "오늘 있었던 일 남기기 (선택)" |

## 5. 감정별 색상 & 배경

| 감정 | 카드 배경 | 선택 시 배경 그라디언트 (화면 전체) | 버튼 강조색 |
| --- | --- | --- | --- |
| 기쁨 (JOY) | #FEF9C3 | #FEF9C3 → #FDE68A | #FCD34D |
| 슬픔 (SAD) | #EFF6FF | #EFF6FF → #DBEAFE | #93C5FD |
| 화남 (ANGRY) | #FFF1F2 | #FFF1F2 → #FFE4E6 | #FCA5A5 |
| 불안 (ANXIOUS) | #FAF5FF | #FAF5FF → #F3E8FF | #D8B4FE |
| 평온 (CALM) | #ECFDF5 | #ECFDF5 → #D1FAE5 | #6EE7B7 |

## 7. 접근성 (Accessibility) 스펙 ✅ CX-07 반영

### 7-1. 감정 표현 대체 텍스트

색약 사용자를 위해 감정 카드는 **이모지 + 텍스트 레이블을 항상 동시 표시**합니다.

| 감정 | 이모지 | 텍스트 레이블 | accessibilityLabel |
| --- | --- | --- | --- |
| 기쁨 | 😊 | 기쁨 | "기쁨 감정 선택" |
| 슬픔 | 😢 | 슬픔 | "슬픔 감정 선택" |
| 화남 | 😠 | 화남 | "화남 감정 선택" |
| 불안 | 😰 | 불안 | "불안 감정 선택" |
| 평온 | 😌 | 평온 | "평온 감정 선택" |

### 7-2. 강도 버튼 접근성

| 강도 레벨 | accessibilityLabel | accessibilityValue |
| --- | --- | --- |
| 1 | "강도 1, 아주 조금" | "5단계 중 1단계" |
| 3 | "강도 3, 보통" | "5단계 중 3단계" |
| 5 | "강도 5, 아주 많이" | "5단계 중 5단계" |

### 7-3. Dynamic Type 지원

- 감정 레이블: 최소 16pt ~ 최대 24pt

- Step 안내 텍스트: 최소 14pt ~ 최대 20pt

- 강도 버튼 크기는 Dynamic Type에 따라 36px ~ 72px 유동

## 6. Figma 컴포넌트 설계

| 컴포넌트 이름 | 프롭(Props) | 변형(Variants) |
| --- | --- | --- |
| EmotionCard | emotion: JOY|SAD|ANGRY|ANXIOUS|CALM, isSelected: bool | Default / Selected / Hover |
| IntensityButton | level: 1~5, emotion: enum, isSelected: bool | Default / Selected / Hover |
| BennyExpression | emotion: enum, intensity: 1~5 | 25개 조합 (자동 매핑) |
| EmotionSummaryCard | emotion: enum, intensity: 1~5 | 5종 감정 × 5종 강도 |
| BennyBubble | text: string, size: small|medium | Default / Emotion 반응형 |
| CheckInProgressBar | step: 1~3 | Step1 / Step2 / Step3 |

## 7. 인터랙션 스펙

| 트리거 | 동작 | 애니메이션 | 시간 |
| --- | --- | --- | --- |
| 감정 카드 탭 | Step1 → Step2, 배경색 전환 | Smart Animate / Ease Out | 0.5s |
| 강도 원형 탭 | 베니 스프라이트 실시간 교체 | Cross Dissolve | 0.25s |
| "다음" 버튼 탭 | Step2 → Step3 | Push / Left | 0.4s |
| "체크인 완료" 탭 | Step3 → 홈, 완료 이펙트 | Modal Dismiss + 파티클 | 0.6s |
| "뒤로가기" 탭 | 현재 Step → 이전 Step | Push / Right | 0.4s |
| 감정 카드 선택 취소 없음 | 다시 Step1로만 가능 (뒤로) | - | - |

## 8. 베니 스프라이트 연동 (25개 조합)

| 강도 | 기쁨 (JOY) | 슬픔 (SAD) | 화남 (ANGRY) | 불안 (ANXIOUS) | 평온 (CALM) |
| --- | --- | --- | --- | --- | --- |
| 1 (아주 조금) | joy_01 | sad_01 | angry_01 | anxious_01 | calm_01 |
| 2 (조금) | joy_02 | sad_02 | angry_02 | anxious_02 | calm_02 |
| 3 (보통) | joy_03 | sad_03 | angry_03 | anxious_03 | calm_03 |
| 4 (많이) | joy_04 | sad_04 | angry_04 | anxious_04 | calm_04 |
| 5 (아주 많이) | joy_05 | sad_05 | angry_05 | anxious_05 | calm_05 |

스프라이트 해상도: 256×256px PNG, 투명 배경. 베니 성장 단계별로 동일 감정/강도 스프라이트 25개 × 5단계 = 총 125개 에셋 (각 단계 스펙 문서 참조) 

## 9. 데이터 연동 스펙

**Firestore 저장 형식 (개발팀 참고):**

`{
"userId": "uid_xxx",
"timestamp": "2026-04-15T09:00:00+09:00",
"emotion": "JOY", // 감정 ID
"intensity": 3, // 강도 1~5
"bennyStage": 3, // 베니 현재 단계
"aiResponse": "...", // VARCO 생성 응답 텍스트
"memo": "" // 선택적 메모
}` 

## 10. 납품 체크리스트

| 항목 | 확인 |
| --- | --- |
| Figma 파일 — 3개 Step 프레임 전체 완성 | ☑ |
| 감정 카드 컴포넌트 5종 (Selected 상태 포함) | ☑ |
| 강도 버튼 컴포넌트 5종 × 5강도 (크기 차등) | ☑ |
| BennyExpression 컴포넌트 25개 조합 연결 | ☑ |
| 인터랙티브 프로토타입 — Step1 → Step2 → Step3 전체 흐름 | ☑ |
| PNG 시안 8장 (Step1 × 1, Step2 × 5, Step3 × 1, 완료 × 1) 1x + 2x | ☑ |
| 색상 팔레트 Figma Styles에 등록 (5감정 × 3단계 = 15색) | ☑ |
| 개발팀 핸드오프 노트 (컴포넌트별 치수, 간격, 반경) | ☑ |
| Figma 공유 링크 PM에게 전달 | ☑ |
