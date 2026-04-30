---
doc_number: 47
version: v1.0
updated: 2026-04-14
portal: https://lrndxihi.gensparkclaw.com/benny/47_개발팀_Sprint2_구현명세서.html
---

47번 — 개발팀 Sprint 2 구현 상세 명세서 · 소울나루


**


  💻 개발팀 Sprint 2 구현 상세 명세서
  문서번호: 47  |  버전: v1.0  |  Sprint 기간: 2026-04-14~20  |  작성: 개발팀 리드
  참조: 09번(스크립트명세) · 37번(BreathingGuide 스펙) · 38번(CheckIn 스펙) · 43번(CX 이슈)


## 1. Sprint 2 구현 목표


  | 우선순위 | 기능 | 마감 | 의존사항 | 상태 |

  | 🔴 P0 | BreathingGuide.unity 씬 전체 UI 구현 | 4/17 | 37번 스펙 v1.3 | 진행중 |

  | 🔴 P0 | Check-In UI v2 (5감정×5강도) | 4/17 | 38번 스펙 v1.3 | 진행중 |

  | 🔴 P0 | QA-F01 수정: 백그라운드 복귀 시 Step 유지 | 4/17 | 46번 QA 보고서 | 진행중 |

  | 🔴 P0 | BennySeasonManager.cs 구현 | 4/20 | 09번 스펙 v2, 41번 | 진행중 |

  | 🟡 P1 | QA-F03 수정: 네트워크 재연결 후 VARCO 재시도 | 4/19 | 46번 QA 보고서 | 예정 |

  | 🟡 P1 | Addressables 스프라이트 프리로드 | 4/19 | 에셋 v2 (45번) | 예정 |

  | 🟢 P2 | BennyDialogue Firestore 컬렉션 연동 | 4/20 | 09번 스펙 v2 | 예정 |


## 2. BreathingGuide 씬 구현 명세 (P0)


### 2-1. 씬 계층 구조


```
BreathingGuide.unity
├── [UI] Canvas (Screen Space - Overlay)
│   ├── NavBar
│   │   ├── BackButton
│   │   └── TitleText ("베니와 함께")
│   ├── ProgressBar          ← 세로 진행 바 (CX-07 접근성)
│   ├── CycleStepIndicator   ← 5단계 점 표시
│   ├── BreathingCircle      ← 중앙 호흡 원
│   │   ├── OuterRing1~3     ← 파동 링 (DOTween)
│   │   ├── MainCircle
│   │   └── BennySprite      ← SpriteRenderer
│   ├── TimerText            ← 72pt, Dynamic Type 연동
│   ├── StateText            ← 들숨/멈춤/날숨
│   ├── SubText
│   ├── StatusBadge
│   ├── CycleCountText
│   └── CTAButton
└── [Logic] BreathingManager
```


### 2-2. BreathingManager.cs 핵심 로직


```
public class BreathingManager : MonoBehaviour
{
    // 4-4-4-4 박스 호흡
    private static readonly float[] PHASE_DURATIONS = {4f, 4f, 4f, 4f};
    private static readonly BreathPhase[] PHASES = {
        BreathPhase.Inhale, BreathPhase.HoldIn,
        BreathPhase.Exhale, BreathPhase.HoldOut
    };

    [SerializeField] private BreathingUIController _ui;
    [SerializeField] private int totalCycles = 3;

    private int _currentCycle;
    private int _currentPhaseIdx;
    private float _timer;
    private bool _isPaused;

    void Update() {
        if (_isPaused) return;
        _timer -= Time.deltaTime;
        _ui.UpdateTimer(Mathf.CeilToInt(_timer));
        if (_timer = totalCycles) { CompleteSession(); return; }
        }
        _timer = PHASE_DURATIONS[_currentPhaseIdx];
        _ui.TransitionTo(PHASES[_currentPhaseIdx]);
    }
}
```


### 2-3. 상태별 색상 매핑 (CX-06 Hold-in 반영)


  | 상태 | 링 색상 | 배경 그라디언트 | 타이머 텍스트 |

  | Idle | `#7C3AED` | #F5F3FF → #EDE9FE | `#7C3AED` |

  | Inhale | `#7C3AED` | #F5F3FF → #DDD6FE | `#7C3AED` |

  | Hold-in** | `**#5B21B6**` | #EDE9FE → #DDD6FE | `**#5B21B6**` ← CX-06 ✅ |

  | Exhale | `#059669` | #F0FDF4 → #D1FAE5 | `#059669` |

  | HoldOut | `#059669` | #F0FDF4 → #D1FAE5 | `#059669` |

  | Done | `#059669` | #F0FDF4 → #D1FAE5 | — |


## 3. Check-In UI v2 구현 명세 (P0)


### 3-1. CheckInFlowController.cs


```
public class CheckInFlowController : MonoBehaviour
{
    private enum Step { Idle, Emotion, Intensity, Confirm, Complete }

    // QA-F01 수정: 백그라운드 복귀 시 Step 유지
    private Step _currentStep = Step.Idle;
    private EmotionType _selectedEmotion;
    private int _selectedIntensity;

    // ApplicationPause 시 상태 보존
    void OnApplicationPause(bool pauseStatus) {
        if (!pauseStatus) {
            // 재진입 시 현재 Step으로 복원
            RestoreStep(_currentStep);
        }
    }

    private void RestoreStep(Step step) {
        emotionPanel.SetActive(step == Step.Emotion);
        intensityPanel.SetActive(step == Step.Intensity);
        confirmPanel.SetActive(step == Step.Confirm);
    }
}
```


### 3-2. 5감정 × 5강도 UI 매핑 (CX-01 피곤 제거)


  | 감정 | enum | 컬러 | VARCO 프롬프트 키 | 강도4+ 특수처리 |

  | 😊 기쁨 | Joy | #D97706 | checkin_joy_{lv} | ANIM_Dance 재생 |

  | 😢 슬픔 | Sad | #1D4ED8 | checkin_sad_{lv} | ANIM_Comfort + 위로 모드 |

  | 😠 화남 | Angry | #BE123C | checkin_angry_{lv} | Sad4+ 동일 처리 |

  | 😰 불안 | Anxious | #6D28D9 | checkin_anxious_{lv} | 위기 감지 → 1393 버튼 |

  | 😌 평온 | Calm | #059669 | checkin_calm_{lv} | 없음 |


* 피곤(Tired)은 Sad 강도 4+ 내부 태그로 재분류 (CX-01). UI에 표시하지 않음.


## 4. BennySeasonManager.cs 구현 명세 (CX-04)


### 4-1. 전체 구현 코드


```
namespace SoulNaru.Art
{
    public class BennySeasonManager : MonoBehaviour
    {
        public static BennySeasonManager Instance { get; private set; }

        [Header("Season Textures")]
        [SerializeField] private Texture2D springBaseColor;   // Tree_Spring_BaseColor
        [SerializeField] private Texture2D summerBaseColor;   // Tree_Summer_BaseColor
        [SerializeField] private Texture2D autumnBaseColor;   // Tree_Autumn_BaseColor
        [SerializeField] private Texture2D winterBaseColor;   // Tree_Winter_BaseColor

        [Header("Tree Accessory GameObjects")]
        [SerializeField] private GameObject springDecor;
        [SerializeField] private GameObject summerDecor;
        [SerializeField] private GameObject autumnDecor;
        [SerializeField] private GameObject winterDecor;

        [Header("Events")]
        public UnityEvent OnSeasonChange;

        private Season _currentSeason;
        private MeshRenderer _treeRenderer;

        public enum Season { Spring, Summer, Autumn, Winter }

        void Awake() {
            if (Instance != null) { Destroy(gameObject); return; }
            Instance = this;
            DontDestroyOnLoad(gameObject);
            _treeRenderer = GetComponentInChildren<MeshRenderer>();
        }

        void Start() => ApplySeason(GetCurrentSeason());

        public Season GetCurrentSeason() {
            int month = DateTime.Now.Month;
            return month switch {
                3 or 4 or 5 => Season.Spring,
                6 or 7 or 8 => Season.Summer,
                9 or 10 or 11 => Season.Autumn,
                _ => Season.Winter
            };
        }

        public void ApplySeason(Season season) {
            var prev = _currentSeason;
            _currentSeason = season;

            // 이미지 레이어 교체
            var tex = season switch {
                Season.Spring => springBaseColor,
                Season.Summer => summerBaseColor,
                Season.Autumn => autumnBaseColor,
                Season.Winter => winterBaseColor,
                _ => springBaseColor
            };
            if (_treeRenderer != null)
                _treeRenderer.material.SetTexture("_MainTex", tex);

            // 장식 오브젝트 교체
            springDecor?.SetActive(season == Season.Spring);
            summerDecor?.SetActive(season == Season.Summer);
            autumnDecor?.SetActive(season == Season.Autumn);
            winterDecor?.SetActive(season == Season.Winter);

            if (prev != season) OnSeasonChange?.Invoke(prev, season);
        }
    }
}
```


## 5. BennyDialogue Firestore 연동 (CX-05)


```
public async Task SaveDialogue(DialogueType type, EmotionData emotion, string varcoResponse)
{
    var doc = new Dictionary<string, object> {
        ["userId"]        = AuthManager.Instance.UserId,
        ["timestamp"]     = FieldValue.ServerTimestamp,
        ["dialogueType"]  = type.ToString(),
        ["emotionId"]     = emotion.Type.ToString().ToLower(),
        ["intensity"]     = emotion.Intensity,
        ["varcoResponse"] = varcoResponse,
        ["bennyStage"]    = GardenManager.Instance.CurrentStage
    };
    await FirebaseFirestore.DefaultInstance
        .Collection("bennyDialogues").AddAsync(doc);
}
```


## 6. Addressables 스프라이트 프리로드 (QA-F04)


```
// Garden.unity 씬 로딩 시 스프라이트 번들 선제 로드
public class SpritePreloader : MonoBehaviour
{
    [SerializeField] private AssetLabelReference spriteLabel; // "benny_sprites"
    private AsyncOperationHandle _preloadHandle;

    async void Start() {
        _preloadHandle = Addressables.DownloadDependenciesAsync(spriteLabel);
        await _preloadHandle.Task;
        Debug.Log("[SpritePreloader] 스프라이트 번들 프리로드 완료");
    }

    void OnDestroy() {
        if (_preloadHandle.IsValid())
            Addressables.Release(_preloadHandle);
    }
}
```


## 7. Sprint 2 남은 작업 체크리스트


  | 항목 | 담당 | 마감 | 상태 |

  | BreathingManager.cs 완성 + Hold-in 색상 적용 | 개발 A | 4/17 | 진행중 |

  | CheckInFlowController QA-F01 수정 | 개발 B | 4/17 | 진행중 |

  | BennySeasonManager.cs 구현 + Inspector 연결 | 개발 A | 4/20 | 진행중 |

  | BennyDialogue Firestore 연동 | 개발 B | 4/20 | 예정 |

  | DataSyncManager QA-F03 수정 | 개발 B | 4/19 | 예정 |

  | SpritePreloader Addressables 적용 | 개발 A | 4/19 | 예정 |

  | VoiceOver accessibilityLabel 적용 (iOS) | 개발 C | 4/18 | 예정 |


  📋 관련 문서
  [09번](09_스크립트명세서_DB스키마.html) · [37번 BreathingGuide](37_BreathingGuide_UI_디자인스펙.html) · [38번 CheckIn](38_CheckIn_UI_강화_디자인스펙.html) · [46번 QA 보고서](46_QA팀_Sprint2_테스트실행보고서.html)