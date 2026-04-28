---
doc_number: 60
version: v1.0
updated: 2026-04-28
portal: https://lrndxihi.gensparkclaw.com/benny/60_FB피드백_49번_업데이트.html
---

# ☁️ FB-01: Day 10 "생각을 구름처럼" 시각화 UI 컴포넌트 명세

 
 **문서번호:** 60 | 
 **버전:** v1.0 | 
 **피드백 ID:** FB-01 | 
 **참조:** 49번 v1.0 업데이트 | 
 **작성:** 기획팀 + PM Alex | 
 **작성일:** 2026-04-28
 

 
 ✅ **FB-01 긴급 반영 완료** — Day 10 "생각을 구름처럼" Unity UI 컴포넌트 명세 확정. 개발팀 즉시 구현 가능.
 

 
## 1. Day 10 미션 개요

 
 | 항목 | 내용 |

 | 미션명 | 생각을 구름처럼 바라보기 (탈융합 — ACT Day 10) |

 | ACT 프로세스 | 탈융합 (Cognitive Defusion) — 생각을 사실이 아닌 관찰 대상으로 바라보기 |

 | 핵심 활동 | 호흡 5분 + 떠오른 생각을 구름에 올려 흘려보내는 시각화 |

 | 씬 연결 | BreathingGuide.unity 씬 → CloudVisualization 오버레이 UI |

 | 소요 시간 | 약 5~7분 (호흡 유도 3분 + 시각화 2~4분) |

 | 베니 리워드 | 평온 Lv4 스프라이트 + 성장 포인트 +20 |

 

 
## 2. Unity UI 컴포넌트 명세

 
### 2-1. CloudVisualizationManager (신규 컴포넌트)

 
 CloudVisualizationManager.cs 
 MonoBehaviour — BreathingGuide.unity에 추가 
 
 | 프로퍼티 | 타입 | 값 | 설명 |

 | cloudPrefab | GameObject | Cloud_UI.prefab | 구름 UI 프리팹 (아래 명세) |

 | cloudSpawnArea | RectTransform | 전체 화면 하단 1/3 | 구름 생성 영역 |

 | maxClouds | int | 5 | 동시 표시 최대 구름 수 |

 | cloudDriftSpeed | float | 40f (px/s) | 구름 우→좌 이동 속도 |

 | inputFieldPrefab | GameObject | ThoughtInput_UI.prefab | 생각 입력 팝업 프리팹 |

 | fadeOutDuration | float | 1.5f | 구름 화면 밖 퇴장 페이드 시간 |

 | onAllCloudsDone | UnityEvent | — | 모든 구름 흘려보낸 후 콜백 |

 
 **주요 메서드:** 
 public void StartVisualization() // 시각화 세션 시작
public void SpawnThoughtCloud(string text) // 생각 텍스트 → 구름 생성
public void OnTapToRelease(Cloud cloud) // 구름 탭 → 흘려보내기
private IEnumerator DriftCloud(Cloud c) // 구름 이동 코루틴
public void EndVisualization() // 세션 종료 → 리워드 지급 
 

 
### 2-2. Cloud_UI.prefab 구조

 
 Cloud_UI.prefab 
 Canvas UI Prefab 
 
 | 구성 요소 | 컴포넌트 | 스펙 |

 | CloudImage | Image | Sprite: cloud_soft.png | 크기: 220×100px | 색상: #E8E4FF (라벤더 연한) |

 | ThoughtText | TextMeshProUGUI | 폰트: NotoSansKR Regular | 크기: 14pt | 색상: #4C1D95 | 최대 2줄 |

 | ReleaseButton | Button (투명) | CloudImage 전체 영역 터치 가능 |

 | CanvasGroup | CanvasGroup | alpha: 0→1 (fade in 0.5s) |

 
 
 **애니메이션:** 화면 오른쪽 하단에서 spawn → 천천히 좌측 상단으로 drift (40px/s) → 탭 시 alpha 1→0 + scale 1→1.15 (1.5s) → 화면 밖 파괴
 
 

 
### 2-3. ThoughtInput_UI.prefab (생각 입력 팝업)

 
 ThoughtInput_UI.prefab 
 Modal Popup Prefab 
 
 | 구성 요소 | 설명 |

 | 배경 패널 | 반투명 #000000 40% | Blur 효과 |

 | InputField | TMP_InputField | Placeholder: "지금 떠오른 생각을 적어보세요" | 최대 40자 |

 | 확인 버튼 | "구름에 올리기" | 색상: #6C63FF → SpawnThoughtCloud() 호출 |

 | 건너뛰기 버튼 | "생각 없이 바라보기" | SpawnThoughtCloud("") 호출 (빈 구름) |

 
 

 
## 3. 씬 흐름 (Day 10 전용)

 
 
 1 
 
 BreathingGuide 씬 진입 (기존 4-4-4-4 호흡) 
 Day 10 미션 트리거 시 BreathingGuide.unity 로드 → MissionContext = "Day10_CloudViz" 설정 
 
 
 
 2 
 
 호흡 3라운드 완료 후 시각화 모드 전환 
 BreathingController.OnBreathingComplete(3) → CloudVisualizationManager.StartVisualization() 호출 
 
 
 
 3 
 
 베니 안내 말풍선 표시 
 베니: "이제 마음에 떠오른 생각이 있으면, 구름에 올려보내 봐요. 생각이 없어도 괜찮아요." ThoughtInput_UI 팝업 → 사용자 입력 또는 건너뛰기 
 
 
 
 4 
 
 구름 시각화 루프 (최대 5개) 
 SpawnThoughtCloud(text) → Cloud drift 시작 → 사용자 탭 → 흘려보내기 → 다음 생각 입력 가능 또는 2분 경과 시 자동으로 EndVisualization() 
 
 
 
 5 
 
 미션 완료 → 리워드 지급 
 EndVisualization() → MissionManager.CompleteMission("Day10") → 성장 포인트 +20 → 베니 평온 Lv4 스프라이트 전환 → Garden 복귀 
 
 
 

 
## 4. 아트 요청 사항

 
 | 에셋 | 규격 | 비고 |

 | cloud_soft.png | 512×256px, 투명 배경 PNG | 부드럽고 둥근 구름 형태, 라벤더 톤 |

 | cloud_soft_glow.png | 512×256px, 투명 배경 PNG | 탭 시 발광 효과용 (Emission 사용 가능) |

 | 베니 표정: 평온 + 미소 | 기존 스프라이트 시트 활용 | 시각화 진행 중 표시 |

 

 
## 5. Firestore 저장 스키마

 // BennyDialogue 컬렉션 Day 10 레코드
{
 userId: "uid_xxx",
 day: 10,
 missionType: "cloud_visualization",
 thoughts: [
 { text: "오늘 발표가 걱정돼", releasedAt: Timestamp },
 { text: "", releasedAt: Timestamp } // 빈 구름
 ],
 completedAt: Timestamp,
 growthPoints: 20,
 bennyStage: "평온_Lv4"
} 

 
 
 📋 관련 문서:
 49번 콘텐츠 명세 ·
 03번 ACT 설계서 ·
 37번 BreathingGuide UI ·
 59번 액션 추적