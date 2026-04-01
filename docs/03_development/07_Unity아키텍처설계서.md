# Unity 프로젝트 아키텍처 설계서 — 베니와 함께
> 소울나루(SOUL NARU) | 버전 1.0 | 작성일: 2026-04-02

---

## 1. 프로젝트 개요

| 항목 | 내용 |
|------|------|
| **Unity 버전** | Unity 2022.3 LTS |
| **타겟 플랫폼** | Android (API 26+) / iOS (14.0+) |
| **렌더 파이프라인** | URP (Universal Render Pipeline) |
| **최소 RAM** | 2GB |
| **권장 RAM** | 4GB+ |
| **저장 공간** | 설치 200MB 이하 |
| **FPS 목표** | 60FPS (저사양 기기 30FPS 유지) |
| **해상도** | 1080×1920 기준, 다양한 비율 대응 |

### Android 최소 사양
| 항목 | 최소 | 권장 |
|------|------|------|
| OS | Android 8.0 (API 26) | Android 11+ |
| CPU | Quad-core 1.8GHz | Octa-core 2.4GHz+ |
| RAM | 2GB | 4GB |
| GPU | OpenGL ES 3.0 | Vulkan 지원 |

### iOS 최소 사양
| 항목 | 최소 | 권장 |
|------|------|------|
| OS | iOS 14.0 | iOS 16+ |
| 기기 | iPhone 8 | iPhone 12+ |
| RAM | 2GB | 4GB |

---

## 2. 폴더 구조

```
Assets/
├── _Project/                    # 프로젝트 전용 (팀 공유)
│   ├── Scripts/
│   │   ├── Core/                # 핵심 매니저 클래스
│   │   │   ├── GameManager.cs
│   │   │   ├── SceneManager.cs
│   │   │   └── EventBus.cs
│   │   ├── Emotion/             # 감정 시스템
│   │   │   ├── EmotionManager.cs
│   │   │   ├── EmotionData.cs
│   │   │   └── EmotionAnalyzer.cs
│   │   ├── Benny/               # 베니 캐릭터
│   │   │   ├── BennyController.cs
│   │   │   ├── BennyAnimator.cs
│   │   │   └── BennyDialogue.cs
│   │   ├── Garden/              # 정원 시스템
│   │   │   ├── GardenManager.cs
│   │   │   ├── WeatherSystem.cs
│   │   │   └── ObjectPlacer.cs
│   │   ├── Mission/             # 미션 시스템
│   │   │   ├── MissionManager.cs
│   │   │   ├── MissionData.cs
│   │   │   └── MissionReward.cs
│   │   ├── Album/               # 성장 앨범
│   │   │   ├── AlbumManager.cs
│   │   │   └── AlbumEntry.cs
│   │   ├── Network/             # 서버 통신
│   │   │   ├── APIClient.cs
│   │   │   ├── VARCOClient.cs
│   │   │   └── DataSyncManager.cs
│   │   ├── UI/                  # UI 스크립트
│   │   │   ├── UIManager.cs
│   │   │   ├── PopupManager.cs
│   │   │   └── Panels/
│   │   └── Utils/               # 유틸리티
│   │       ├── LocalStorage.cs
│   │       └── Logger.cs
│   ├── Prefabs/
│   │   ├── Benny/
│   │   ├── Garden/
│   │   ├── UI/
│   │   └── Effects/
│   ├── Scenes/
│   │   ├── Boot.unity
│   │   ├── MainHome.unity
│   │   ├── Garden.unity
│   │   ├── CheckIn.unity
│   │   ├── Album.unity
│   │   └── Onboarding.unity
│   ├── ScriptableObjects/       # 데이터 에셋
│   │   ├── Emotions/
│   │   ├── Missions/
│   │   └── BennyStages/
│   ├── Sprites/
│   ├── Models/
│   ├── Animations/
│   ├── Audio/
│   │   ├── BGM/
│   │   └── SFX/
│   └── Materials/
├── Plugins/                     # 외부 플러그인
│   ├── Firebase/
│   ├── Purchasing/
│   └── Analytics/
└── StreamingAssets/             # 런타임 로드 파일
```

---

## 3. 네이밍 컨벤션

### 3.1 클래스/인터페이스
| 종류 | 규칙 | 예시 |
|------|------|------|
| 클래스 | PascalCase | `EmotionManager` |
| 인터페이스 | I + PascalCase | `IEmotionHandler` |
| 추상 클래스 | Base + PascalCase | `BaseManager` |
| ScriptableObject | PascalCase + SO | `MissionDataSO` |

### 3.2 메서드/변수
| 종류 | 규칙 | 예시 |
|------|------|------|
| public 메서드 | PascalCase | `GetCurrentEmotion()` |
| private 메서드 | camelCase | `calculateIntensity()` |
| public 변수 | PascalCase | `CurrentEmotion` |
| private 변수 | _camelCase | `_currentIntensity` |
| 상수 | UPPER_SNAKE | `MAX_EMOTION_INTENSITY` |
| 이벤트 | On + PascalCase | `OnEmotionChanged` |

### 3.3 파일/에셋
| 종류 | 규칙 | 예시 |
|------|------|------|
| 스크립트 | PascalCase.cs | `BennyController.cs` |
| 씬 | PascalCase.unity | `MainHome.unity` |
| 프리팹 | PFB_PascalCase | `PFB_BennySprout` |
| 스프라이트 | SPR_Name_State | `SPR_Benny_Happy` |
| 애니메이션 | ANIM_Name_Action | `ANIM_Benny_Dance` |
| BGM | BGM_Scene | `BGM_MainHome` |
| SFX | SFX_Action | `SFX_CheckIn_Complete` |

---

## 4. 코드 스타일 가이드

```csharp
// ✅ 올바른 예시
public class EmotionManager : MonoBehaviour
{
    // 상수
    private const int MAX_INTENSITY = 5;
    
    // private 필드 (언더스코어 prefix)
    private EmotionType _currentEmotion;
    private int _currentIntensity;
    
    // 이벤트
    public event Action<EmotionType, int> OnEmotionChanged;
    
    // public 프로퍼티
    public EmotionType CurrentEmotion => _currentEmotion;
    
    // 메서드: 동사로 시작
    public void SetEmotion(EmotionType emotion, int intensity)
    {
        if (intensity < 1 || intensity > MAX_INTENSITY)
        {
            Debug.LogWarning($"Invalid intensity: {intensity}");
            return;
        }
        
        _currentEmotion = emotion;
        _currentIntensity = intensity;
        OnEmotionChanged?.Invoke(emotion, intensity);
    }
}
```

**규칙 요약**:
- 중괄호 `{` 는 새 줄에
- 들여쓰기: 4 spaces (탭 금지)
- 한 줄 최대 120자
- `var` 타입 추론 최소화 (명시적 타입 선호)
- null 체크는 `?.` 또는 `?? ` 활용

---

## 5. 아키텍처 패턴

**선택 패턴**: **MVP (Model-View-Presenter) + Event Bus**

**선택 이유**:
- Unity UI와 게임 로직 분리 → 테스트 용이
- Event Bus로 컴포넌트 간 의존성 최소화
- 소규모 팀(4~6명)에 적합한 복잡도

```
[Model]          [Presenter]        [View]
EmotionData  ←→  EmotionPresenter  ←→  CheckInPanel
MissionData  ←→  MissionPresenter  ←→  MissionCard
BennyState   ←→  BennyPresenter    ←→  BennyView
         ↕
    [EventBus]
    OnEmotionSet
    OnMissionComplete
    OnBennyGrow
```

---

## 6. 주요 매니저 클래스 목록

| 클래스명 | 역할 | 씬 범위 |
|---------|------|--------|
| `GameManager` | 전체 게임 상태 관리, 씬 전환 조율 | 영구 (DontDestroyOnLoad) |
| `EmotionManager` | 감정 체크인 처리, 감정 데이터 관리 | 영구 |
| `DataSyncManager` | 서버 동기화, 로컬 캐시 관리 | 영구 |
| `BennyController` | 베니 상태, 애니메이션, 대화 제어 | MainHome, CheckIn |
| `GardenManager` | 정원 오브젝트 배치, 날씨 제어 | Garden |
| `MissionManager` | 미션 목록 관리, 완료 처리 | 영구 |
| `AlbumManager` | 성장 앨범 데이터 관리 | Album |
| `UIManager` | UI 레이어 관리, 팝업 제어 | 영구 |
| `AudioManager` | BGM/SFX 재생 제어 | 영구 |
| `NotificationManager` | 로컬 푸시 알림 관리 | 영구 |

---

## 7. 씬 전환 흐름

```
[Boot.unity]
  → 초기화, 로그인 체크
  ↓
[Onboarding.unity] ← 첫 실행만
  → 튜토리얼 5단계
  ↓
[MainHome.unity] ← 메인 허브
  ├── CheckIn.unity (팝업 오버레이)
  ├── Garden.unity (씬 전환)
  ├── Album.unity (씬 전환)
  ├── Store.unity (씬 전환)
  └── Settings.unity (씬 전환)
```

---
*문서 버전: v1.0 | 작성: AI PM Alex | 검토: 개발팀*
