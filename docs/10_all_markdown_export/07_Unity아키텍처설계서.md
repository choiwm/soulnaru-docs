---
source_html: 07_Unity아키텍처설계서.html
exported: 2026-05-01
---

# 07_Unity아키텍처설계서 — 소울나루

07_Unity아키텍처설계서 — 소울나루 

# Unity 프로젝트 아키텍처 설계서 — 베니와 함께

소울나루(SOUL NARU) | 버전 1.0 | 작성일: 2026-04-02

## 1. 프로젝트 개요

| 항목 | 내용 |
| --- | --- |
| Unity 버전 | Unity 2022.3 LTS |
| 타겟 플랫폼 | Android (API 26+) / iOS (14.0+) |
| 렌더 파이프라인 | URP (Universal Render Pipeline) |
| 최소 RAM | 2GB |
| 권장 RAM | 4GB+ |
| 저장 공간 | 설치 200MB 이하 |
| FPS 목표 | 60FPS (저사양 기기 30FPS 유지) |
| 해상도 | 1080×1920 기준, 다양한 비율 대응 |

### Android 최소 사양

| 항목 | 최소 | 권장 |
| --- | --- | --- |
| OS | Android 8.0 (API 26) | Android 11+ |
| CPU | Quad-core 1.8GHz | Octa-core 2.4GHz+ |
| RAM | 2GB | 4GB |
| GPU | OpenGL ES 3.0 | Vulkan 지원 |

### iOS 최소 사양

| 항목 | 최소 | 권장 |
| --- | --- | --- |
| OS | iOS 14.0 | iOS 16+ |
| 기기 | iPhone 8 | iPhone 12+ |
| RAM | 2GB | 4GB |

## 2. 폴더 구조

`Assets/
├── _Project/ # 프로젝트 전용 (팀 공유)
│ ├── Scripts/
│ │ ├── Core/ # 핵심 매니저 클래스
│ │ │ ├── GameManager.cs
│ │ │ ├── SceneManager.cs
│ │ │ └── EventBus.cs
│ │ ├── Emotion/ # 감정 시스템
│ │ │ ├── EmotionManager.cs
│ │ │ ├── EmotionData.cs
│ │ │ └── EmotionAnalyzer.cs
│ │ ├── Benny/ # 베니 캐릭터
│ │ │ ├── BennyController.cs
│ │ │ ├── BennyAnimator.cs
│ │ │ └── BennyDialogue.cs
│ │ ├── Garden/ # 정원 시스템
│ │ │ ├── GardenManager.cs
│ │ │ ├── WeatherSystem.cs
│ │ │ └── ObjectPlacer.cs
│ │ ├── Mission/ # 미션 시스템
│ │ │ ├── MissionManager.cs
│ │ │ ├── MissionData.cs
│ │ │ └── MissionReward.cs
│ │ ├── Album/ # 성장 앨범
│ │ │ ├── AlbumManager.cs
│ │ │ └── AlbumEntry.cs
│ │ ├── Network/ # 서버 통신
│ │ │ ├── APIClient.cs
│ │ │ ├── VARCOClient.cs
│ │ │ └── DataSyncManager.cs
│ │ ├── UI/ # UI 스크립트
│ │ │ ├── UIManager.cs
│ │ │ ├── PopupManager.cs
│ │ │ └── Panels/
│ │ └── Utils/ # 유틸리티
│ │ ├── LocalStorage.cs
│ │ └── Logger.cs
│ ├── UI UI 프리팹s/
│ │ ├── Benny/
│ │ ├── Garden/
│ │ ├── UI/
│ │ └── Effects/
│ ├── Scenes/
│ │ ├── Boot.unity
│ │ ├── MainHome.unity
│ │ ├── Garden.unity
│ │ ├── CheckIn.unity
│ │ ├── Album.unity
│ │ ├── BreathingGuide.unity
│ │ └── Onboarding.unity
│ ├── ScriptableObjects/ # 데이터 에셋
│ │ ├── Emotions/
│ │ ├── Missions/
│ │ └── BennyStages/
│ ├── Sprites/
│ ├── Models/
│ ├── Animations/
│ ├── Audio/
│ │ ├── BGM/
│ │ └── SFX/
│ └── Materials/
├── Plugins/ # 외부 플러그인
│ ├── Firebase/
│ ├── Purchasing/
│ └── Analytics/
└── StreamingAssets/ # 런타임 로드 파일` 

## 3. 네이밍 컨벤션

### 3.1 클래스/인터페이스

| 종류 | 규칙 | 예시 |
| --- | --- | --- |
| 클래스 | PascalCase | EmotionManager |
| 인터페이스 | I + PascalCase | IEmotionHandler |
| 추상 클래스 | Base + PascalCase | BaseManager |
| ScriptableObject | PascalCase + SO | MissionDataSO |

### 3.2 메서드/변수

| 종류 | 규칙 | 예시 |
| --- | --- | --- |
| public 메서드 | PascalCase | GetCurrentEmotion() |
| private 메서드 | camelCase | calculateIntensity() |
| public 변수 | PascalCase | CurrentEmotion |
| private 변수 | _camelCase | _currentIntensity |
| 상수 | UPPER_SNAKE | MAX_EMOTION_INTENSITY |
| 이벤트 | On + PascalCase | OnEmotionChanged |

### 3.3 파일/에셋

| 종류 | 규칙 | 예시 |
| --- | --- | --- |
| 스크립트 | PascalCase.cs | BennyController.cs |
| 씬 | PascalCase.unity | MainHome.unity |
| UI 프리팹 | PFB_PascalCase | PFB_BennySprout |
| 스프라이트 | SPR_Name_State | SPR_Benny_Happy |
| 애니메이션 | ANIM_Name_Action | ANIM_Benny_Dance |
| BGM | BGM_Scene | BGM_MainHome |
| SFX | SFX_Action | SFX_CheckIn_Complete |

## 4. 코드 스타일 가이드

`// ✅ 올바른 예시
public class EmotionManager : MonoBehaviour
{
// 상수
private const int MAX_INTENSITY = 5;

// private 필드 (언더스코어 prefix)
private EmotionType _currentEmotion;
private int _currentIntensity;

// 이벤트
public event Action OnEmotionChanged;

// public 프로퍼티
public EmotionType CurrentEmotion => _currentEmotion;

// 메서드: 동사로 시작
public void SetEmotion(EmotionType emotion, int intensity)
{
if (intensity MAX_INTENSITY)
{
Debug.LogWarning($"Invalid intensity: {intensity}");
return;
}

_currentEmotion = emotion;
_currentIntensity = intensity;
OnEmotionChanged?.Invoke(emotion, intensity);
}
}` 
**규칙 요약**:

- 중괄호 { 는 새 줄에

- 들여쓰기: 4 spaces (탭 금지)

- 한 줄 최대 120자

- var 타입 추론 최소화 (명시적 타입 선호)

- null 체크는 ?. 또는 ?? 활용

## 5. 아키텍처 패턴

**선택 패턴**: **MVP (Model-View-Presenter) + Event Bus**

**선택 이유**:

- Unity UI와 게임 로직 분리 → 테스트 용이

- Event Bus로 컴포넌트 간 의존성 최소화

- 소규모 팀(4~6명)에 적합한 복잡도

`[Model] [Presenter] [View]
EmotionData ←→ EmotionPresenter ←→ CheckInPanel
MissionData ←→ MissionPresenter ←→ MissionCard
BennyState ←→ BennyPresenter ←→ BennyView
↕
[EventBus]
OnEmotionSet
OnMissionComplete
OnBennyGrow` 

## 6. 주요 매니저 클래스 목록

| 클래스명 | 역할 | 씬 범위 |
| --- | --- | --- |
| GameManager | 전체 게임 상태 관리, 씬 전환 조율 | 영구 (DontDestroyOnLoad) |
| EmotionManager | 감정 체크인 처리, 감정 데이터 관리 | 영구 |
| DataSyncManager | 서버 동기화, 로컬 캐시 관리 | 영구 |
| BennyController | 베니 상태, 애니메이션, 대화 제어 | MainHome, CheckIn |
| GardenManager | 정원 오브젝트 배치, 날씨 제어 | Garden |
| MissionManager | 미션 목록 관리, 완료 처리 | 영구 |
| AlbumManager | 성장 앨범 데이터 관리 | Album |
| UIManager | UI 레이어 관리, 팝업 제어 | 영구 |
| AudioManager | BGM/SFX 재생 제어 | 영구 |
| NotificationManager | 로컬 푸시 알림 관리 | 영구 |

## 7. 씬 전환 흐름

`[Boot.unity]
→ 초기화, 로그인 체크
↓
[Onboarding.unity] ← 첫 실행만
→ 튜토리얼 5단계
↓
[MainHome.unity] ← 메인 허브
├── CheckIn.unity (팝업 오버레이)
├── Garden.unity (씬 전환)
├── Album.unity (씬 전환)
├── BreathingGuide.unity (호흡 가이드 씬 전환)
├── Store.unity (씬 전환)
└── Settings.unity (씬 전환)` 

## 8. Firebase Firestore 보안 규칙

### 8.1 기본 원칙

- 자신의 데이터만 읽기/쓰기 허용 — 타 유저 데이터 접근 불가

- 인증된 유저만 접근 허용 — 비인증 요청 전면 차단

- 감정 데이터 외부 노출 금지 — 민감정보 보호 최우선

### 8.2 Firestore 보안 규칙 전문

`rules_version = '2';
service cloud.firestore {
match /databases/{database}/documents {

// ─────────────────────────────────────────
// 유저 데이터: 본인만 접근 가능
// ─────────────────────────────────────────
match /users/{userId}/{document=**} {
allow read, write: if request.auth != null
&& request.auth.uid == userId;
}

// ─────────────────────────────────────────
// 감정 체크인 기록: 본인만 읽기/쓰기
// ─────────────────────────────────────────
match /emotions/{userId}/records/{recordId} {
allow read, write: if request.auth != null
&& request.auth.uid == userId;
}

// ─────────────────────────────────────────
// 미션 데이터: 본인만 읽기/쓰기
// ─────────────────────────────────────────
match /missions/{userId}/completed/{missionId} {
allow read, write: if request.auth != null
&& request.auth.uid == userId;
}

// ─────────────────────────────────────────
// 구독 정보: 본인 읽기 허용, 쓰기는 서버(Admin SDK)만
// ─────────────────────────────────────────
match /subscriptions/{userId} {
allow read: if request.auth != null
&& request.auth.uid == userId;
allow write: if false; // 서버사이드 Admin SDK만 허용
}

// ─────────────────────────────────────────
// 글로벌 미션/오브젝트 카탈로그: 읽기 전용 (모든 인증 유저)
// ─────────────────────────────────────────
match /catalog/{document=**} {
allow read: if request.auth != null;
allow write: if false; // 관리자만 콘솔에서 수정
}

// ─────────────────────────────────────────
// 그 외 모든 경로: 접근 차단
// ─────────────────────────────────────────
match /{document=**} {
allow read, write: if false;
}
}
}` 

### 8.3 규칙 배포 및 테스트

`# Firebase CLI로 규칙 배포
firebase deploy --only firestore:rules

# 규칙 시뮬레이터 테스트 (Firebase 콘솔 > Firestore > 규칙 탭)
# 테스트 케이스:
# 1. 인증된 유저가 자신의 /users/{uid} 읽기 → 허용
# 2. 인증된 유저가 타인의 /users/{otherUid} 읽기 → 거부
# 3. 비인증 요청 → 전면 거부
# 4. /subscriptions/{uid} 클라이언트 쓰기 시도 → 거부` 

### 8.4 데이터 구조 ↔ 보안 규칙 매핑

| Firestore 경로 | 접근 허용 | 접근 차단 |
| --- | --- | --- |
| /users/{uid}/profile | 본인 읽기/쓰기 | 타인, 비인증 |
| /emotions/{uid}/records/* | 본인 읽기/쓰기 | 타인, 비인증 |
| /missions/{uid}/completed/* | 본인 읽기/쓰기 | 타인, 비인증 |
| /subscriptions/{uid} | 본인 읽기 / 서버 쓰기 | 클라이언트 쓰기, 타인 |
| /catalog/* | 모든 인증 유저 읽기 | 클라이언트 쓰기 |

문서 버전: v1.1 | 수정일: 2026-04-02 | 작성: AI PM Alex | 검토: 개발팀 
(v1.1 변경: 섹션 8 Firebase Firestore 보안 규칙 추가)
