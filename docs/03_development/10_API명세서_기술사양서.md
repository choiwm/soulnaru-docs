# API 명세서 + 기술 사양서 — 베니와 함께
> 소울나루(SOUL NARU) | 버전 1.1 | 작성일: 2026-04-02 | 수정일: 2026-04-02

---

## 1. 기술 사양

| 항목 | 내용 |
|------|------|
| Unity 버전 | 2022.3 LTS |
| 렌더 파이프라인 | URP 14.x |
| 백엔드 | Firebase (Firestore + Auth + Functions) |
| AI API | NC AI VARCO 3D / Sound |
| 결제 | Unity IAP (Google Play + App Store) |
| 분석 | Firebase Analytics |
| 푸시 알림 | Firebase Cloud Messaging (FCM) |
| 최소 Android | API 26 (Android 8.0) |
| 최소 iOS | iOS 14.0 |
| FPS 목표 | 60FPS (저사양 30FPS) |
| 메모리 목표 | 런타임 200MB 이하 |
| 로딩 목표 | 씬 전환 3초 이내 |

---

## 2. 서버 API 명세

### 베이스 URL
```
Production: https://api.soulnaru.com/v1
Staging:    https://api-staging.soulnaru.com/v1
```

### 공통 헤더
```
Authorization: Bearer {firebase_id_token}
Content-Type: application/json
X-App-Version: 1.0.0
X-Platform: android | ios
```

---

### 2.1 유저 인증

**POST /auth/register**
```json
// Request
{ "email": "user@example.com", "display_name": "지수" }

// Response 200
{
  "user_id": "uuid",
  "token": "firebase_custom_token",
  "is_new_user": true
}
```

**GET /auth/profile**
```json
// Response 200
{
  "user_id": "uuid",
  "display_name": "지수",
  "streak": { "current": 14, "max": 21 },
  "subscription": { "type": "premium", "expires_at": "2026-05-01" },
  "benny_stage": 3
}
```

---

### 2.2 감정 로그

**POST /emotions/checkin**
```json
// Request
{
  "emotion": "tired",
  "intensity": 4,
  "memo": "월요일이라 너무 힘들다",
  "session_number": 1,
  "client_timestamp": "2026-04-02T09:30:00+09:00"
}

// Response 200
{
  "checkin_id": "uuid",
  "benny_response": {
    "text": "많이 지쳤구나. 오늘은 쉬어도 정말 괜찮아",
    "animation": "ANIM_Benny_Comfort",
    "weather_change": "cloudy"
  },
  "mission_suggestions": [
    { "id": "mission_001", "name": "물 한 잔 마시기", "seeds": 15 }
  ],
  "experience_gained": 10
}
```

**GET /emotions/summary?period=weekly**
```json
// Response 200
{
  "period": "2026-03-26 ~ 2026-04-01",
  "dominant_emotion": "tired",
  "counts": { "joy": 2, "calm": 4, "tired": 8, "sad": 1, "anxious": 3 },
  "avg_intensity": 2.8,
  "total_checkins": 18,
  "ai_insight": "이번 주는 피곤한 날이 많았어요. 3단계 루틴 미션을 완료한 날은 감정이 안정적이었어요."
}
```

---

### 2.3 베니 상태

**GET /benny/status**
```json
// Response 200
{
  "stage": 3,
  "experience": 450,
  "experience_to_next": 600,
  "current_emotion": "calm",
  "last_interaction": "2026-04-02T08:30:00+09:00"
}
```

**POST /benny/grow**
```json
// Request
{ "new_stage": 4 }

// Response 200
{
  "stage": 4,
  "growth_message": "축하해! 베니가 열매 단계로 성장했어!",
  "unlocked_features": ["weekly_ai_report", "special_garden_theme"],
  "reward": { "seeds": 500, "special_object": "PFB_Garden_BennyFruitTree" }
}
```

---

### 2.4 미션 완료

**POST /missions/{mission_id}/complete**
```json
// Response 200
{
  "mission_id": "mission_001",
  "reward": { "seeds": 15, "object_unlocked": null },
  "benny_response": "잘했어! 물 한 잔, 그게 시작이야",
  "daily_progress": { "completed": 2, "total": 3 },
  "streak_updated": false
}
```

---

### 2.5 정원 상태

**GET /garden**
```json
// Response 200
{
  "grid_size": { "width": 3, "height": 4 },
  "placed_objects": [
    { "object_id": "obj_001", "type": "PFB_Garden_FlowerRose", "position": { "x": 0, "y": 0 } }
  ],
  "current_weather": "sunny",
  "inventory_count": 5
}
```

**POST /garden/place**
```json
// Request
{ "object_id": "obj_001", "position": { "x": 1, "y": 2 } }
// Response 200
{ "success": true, "garden_state": { ... } }
```

---

## 3. VARCO AI API 연동 명세

### 3.1 VARCO 3D (에셋 생성)
```
⚠️ 주의: 아래 엔드포인트는 파트너 계약 후 발급되는 실제 URL로 반드시 교체 필요
참고: https://varco.ai — 파트너십 신청 후 API 키 및 엔드포인트 확인
Endpoint(임시): https://api.ncai.naver.com/varco/3d/generate  ← 4월 2주차 실제 확인 필수
Method: POST
Authorization: Bearer {VARCO_API_KEY}
```
```json
// Request
{
  "prompt": "cute small flower pot with purple petals, pastel color, low-poly mobile game style",
  "format": "glb",
  "poly_limit": 5000,
  "texture_size": 512
}
// Response
{
  "job_id": "varco_job_xxx",
  "status": "processing",
  "estimated_seconds": 30
}
```

### 3.2 VARCO Sound (사운드 생성)
```json
// Request
{
  "type": "sfx",
  "prompt": "soft gentle chime sound for completing a daily mission, cheerful, 2 seconds",
  "duration": 2.0,
  "format": "mp3"
}
// Response
{
  "audio_url": "https://cdn.ncai.naver.com/sound/xxx.mp3",
  "duration": 2.0
}
```

---

## 4. 결제 API (Unity IAP)

### 4.1 구독 상품 ID
| 상품 | Android | iOS |
|------|---------|-----|
| 프리미엄 구독 (월) | `com.soulnaru.premium.monthly` | `com.soulnaru.premium.monthly` |
| 시즌패스 (봄) | `com.soulnaru.season.spring2026` | `com.soulnaru.season.spring2026` |

### 4.2 결제 검증 플로우
```
[클라이언트] Unity IAP 구매 → Receipt 획득
    ↓
[서버] POST /payments/verify
  Body: { "platform": "android", "receipt": "...", "product_id": "..." }
    ↓
[서버] Google/Apple 서버 검증
    ↓
[서버] 구독 활성화 + Response
  Body: { "success": true, "subscription": { "type": "premium", "expires_at": "..." } }
```

### 4.3 구독 취소 웹훅 처리
```
[스토어] 유저가 구독 취소 → Google Play / App Store 웹훅 발송
    ↓
POST /payments/subscription/cancel-webhook
Headers: { "X-Signature": "..." }  ← 스토어별 서명 검증 필수
Body (Google Play):
{
  "subscriptionNotification": {
    "notificationType": 3,  // 3 = SUBSCRIPTION_CANCELED
    "purchaseToken": "...",
    "subscriptionId": "com.soulnaru.premium.monthly"
  }
}
    ↓
[서버] 구독 상태 expired로 업데이트 → 구독 혜택 만료 처리
```

**스토어별 웹훅 설정**:
- Google Play: Cloud Pub/Sub 토픽 구독 설정
- App Store: App Store Server Notifications V2 엔드포인트 등록

---

## 5. 에러 코드 정의

| 코드 | HTTP | 설명 | 클라이언트 처리 |
|------|------|------|--------------|
| `AUTH_001` | 401 | 토큰 만료 | 자동 토큰 갱신 후 재시도 |
| `AUTH_002` | 401 | 유효하지 않은 토큰 | 재로그인 유도 |
| `EMOTION_001` | 400 | 오늘 체크인 횟수 초과 (3회) | 안내 메시지 표시 |
| `EMOTION_002` | 400 | 유효하지 않은 감정 값 | 기본값으로 재시도 |
| `MISSION_001` | 404 | 미션 없음 | 미션 재로딩 |
| `GARDEN_001` | 400 | 그리드 위치 초과 | 배치 취소 |
| `VARCO_001` | 503 | VARCO API 오류 | 캐시 에셋 사용 |
| `SERVER_500` | 500 | 서버 오류 | 재시도 (최대 3회) |
| `NETWORK_001` | - | 네트워크 없음 | 오프라인 모드 전환 |

---

## 6. 버전 관리 전략 (Git)

### 브랜치 전략
```
main          ← 배포 브랜치 (앱스토어 제출용)
  ↑ merge via PR
develop       ← 통합 개발 브랜치
  ↑ merge via PR
feature/xxx   ← 기능 개발 (1인 1브랜치)
fix/xxx       ← 버그 수정
hotfix/xxx    ← 긴급 수정 (main에서 분기)
```

### 빌드 관리
| 빌드 타입 | 브랜치 | 환경 | 배포 |
|---------|--------|------|------|
| Debug | feature/* | Dev 서버 | 개발자 기기 |
| Alpha | develop | Staging 서버 | 내부 테스트 |
| Beta | develop | Staging 서버 | 외부 테스트 (TestFlight/Google Play 내부) |
| Release | main | Production | 앱스토어 |

---
*문서 버전: v1.0 | 작성: AI PM Alex | 검토: 개발팀*
