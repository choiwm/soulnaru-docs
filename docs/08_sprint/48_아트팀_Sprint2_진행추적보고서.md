---
doc_number: 48
version: v1.0
updated: 2026-04-14
portal: https://lrndxihi.gensparkclaw.com/benny/48_아트팀_Sprint2_진행추적보고서.html
---

48번 — 아트팀 Sprint 2 진행 추적 보고서 · 소울나루


  🎨 아트팀 Sprint 2 진행 추적 보고서
  문서번호: 48  |  버전: v1.0  |  Sprint 기간: 2026-04-14~20  |  작성: 아트팀 리드
  담당: 아티스트 A(UI) · B(3D모델) · C(스프라이트) · D(Prefab) · E(파티클)


  114에셋 v2 완료
  3FBX 진행중
  5Prefab 예정
  4파티클 미착수


## 1. Sprint 2 아트 작업 현황


  | 에셋 | 담당 | 마감 | 상태 | 비고 |

  | 베니 3단계 FBX 실체 모델 | 아티스트 B | 4/20 | 진행중 | 스펙: 39번 v1.3 (≤1,000폴리) |

  | 베니 4단계 FBX 실체 모델 | 아티스트 B | 4/20 | 진행중 | 스펙: 40번 v1.3 |

  | 베니 5단계 FBX 실체 모델 (기본+계절4종) | 아티스트 B | 4/20 | 진행중 | 스펙: 41번 v1.3 · 계절 변형 포함 |

  | BreathingGuide Figma 핸드오프 | 아티스트 A | 완료 | ✅ PNG 스펙 완료 | 37번 v1.3 (PNG 대체) |

  | CheckIn UI Figma 핸드오프 | 아티스트 A | 완료 | ✅ PNG 스펙 완료 | 38번 v1.3 |

  | 감정 스프라이트 75종 (v2) | 아티스트 C | 완료 | ✅ v2 배포됨 | 45번 보고서 |

  | 텍스처 13종 (v2) | 아티스트 C | 완료 | ✅ v2 배포됨 | 45번 보고서 |

  | Unity Prefab — 3단계 Bloom | 아티스트 D | 4/17 | FBX 대기 | 아티스트 B FBX 수령 후 착수 |

  | Unity Prefab — 4단계 Fruit | 아티스트 D | 4/18 | FBX 대기 |  |

  | Unity Prefab — 5단계 Tree | 아티스트 D | 4/18 | FBX 대기 | BennySeasonManager 연결 포함 |

  | 파티클 — PS_CherryBlossom (봄) | 아티스트 E | 4/20 | 미착수 | BennySeasonManager.OnSeasonChange 연동 |

  | 파티클 — PS_Firefly (여름) | 아티스트 E | 4/20 | 미착수 |  |

  | 파티클 — PS_FallenLeaf (가을) | 아티스트 E | 4/20 | 미착수 |  |

  | 파티클 — PS_Snow (겨울) | 아티스트 E | 4/20 | 미착수 |  |


## 2. 완료된 에셋 갤러리


### 📱 UI 시안 — BreathingGuide v2 (5종)


  대기
  들숨
  멈춤 #5B21B6
  날숨
  완료 🎉


### 📱 UI 시안 — Check-In v2 (8종)


  Step1 감정선택
  기쁨 강도
  슬픔 강도
  화남 강도
  불안 강도
  평온 강도
  Step3 확인
  완료


### 🐰 스프라이트 대표 샘플 — Stage 3/4/5 (각 5종)

전체 75종. 감정별 강도 5단계. 단계별 액센트 컬러 장식 적용.

  S3 기쁨 Lv5
  S3 슬픔 Lv3
  S4 기쁨 Lv5
  S4 화남 Lv5
  S5 평온 Lv5


### 🎨 텍스처 샘플 (Albedo × 3단계 + 계절 4종)


  S3 Albedo
  S4 Albedo
  S5 Albedo
  🌸 봄
  🌿 여름
  🍂 가을
  ❄️ 겨울
  S5 Emission


## 3. FBX 납품 스펙 요약 (아티스트 B 참조)


  | 단계 | 파일명 | 폴리 제한 (LOD0) | 리그 | UV 채널 | 마감 |

  | 3단계 개화 | `Benny_Stage3_Bloom.fbx` | ≤1,000 | Simple (머리·몸) | UV0 (Albedo), UV1 (Lightmap) | 4/20 |

  | 4단계 열매 | `Benny_Stage4_Fruit.fbx` | ≤1,000 | Simple + 열매 흔들림 | UV0, UV1 | 4/20 |

  | 5단계 나무 | `Benny_Stage5_Tree.fbx` (×4 계절) | ≤1,000 | Simple + 가지 흔들림 | UV0, UV1 | 4/20 |


LOD1: 500폴리, LOD2: 200폴리 별도 납품. CX-02 수정 기준 적용.


## 4. 파티클 작업 지침 (아티스트 E 참조)


  | 파티클 시스템 | 계절 | 최대 파티클 수 | 텍스처 기반 | BennySeasonManager 트리거 |

  | PS_CherryBlossom | 봄 | 50개 | Tree_Spring_Albedo.png | OnSeasonChange → Spring |

  | PS_Firefly | 여름 | 30개 | 별도 발광 텍스처 | OnSeasonChange → Summer |

  | PS_FallenLeaf | 가을 | 40개 | Tree_Autumn_Albedo.png | OnSeasonChange → Autumn |

  | PS_Snow | 겨울 | 80개 | 흰색 스프라이트 | OnSeasonChange → Winter |


  ⚠️ 주의: FBX 마감 4/20 미준수 시 영향
  Prefab 조립(아티스트 D), Unity 임포트(개발팀) 일정이 연쇄 지연됩니다. Alpha 빌드(5/14) 리스크 상승.
  4/18까지 1단계 FBX 우선 납품 요청.


  📋 관련 문서
  [39번](39_베니3단계_개화_아트에셋스펙.html) · [40번](40_베니4단계_열매_아트에셋스펙.html) · [41번](41_베니5단계_나무_아트에셋스펙.html) · [45번 v2 보고서](45_아트에셋_v2_이미지개선보고서.html) · [47번 개발팀 명세](47_개발팀_Sprint2_구현명세서.html)