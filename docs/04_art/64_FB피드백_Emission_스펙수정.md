---
doc_number: 64
version: v1.0
updated: 2026-04-28
portal: https://lrndxihi.gensparkclaw.com/benny/64_FB피드백_41번_아트에셋_업데이트.html
---

# ✨ FB-11: 베니 5단계 Emission Intensity 0.3으로 조정 (41번 업데이트)

 
 **문서번호:** 64 | 
 **버전:** v1.0 | 
 **피드백 ID:** FB-11 | 
 **참조:** 41번 베니5단계 아트에셋 스펙 | 
 **작성:** 아트팀 & 기획팀 | 
 **작성일:** 2026-04-28
 

 
 ✅ **FB-11 완료** — Benny_S5_Emission.png 발광 강도 HDR 1.0 → 0.3으로 감소. 과도한 밝기 제거, 자연스러운 발광 표현.
 

 
## 1. 문제 분석

 **테스트 결과:** 베니 5단계 나무 에셋의 Emission 텍스처가 일반 실내 조명에서 과도하게 밝게 표현됨. 플레이어 경험상 불편하고, 게임의 시각적 톤과 맞지 않음. 
 **원인:** Emission Intensity가 HDR 스케일 1.0 설정 → 현재 라이팅 환경에서 과다 노출 

 
## 2. 수정 내용 (41번 업데이트)

 
 
 5단계 베니 나무 (Tree_Benny_S5.fbx) 
 
 수정 필요 
 확정됨 
 
 

 
### 텍스처 Emission 스펙 변경

 
 | 항목 | 기존 값 | 신규 값 | 변경사항 |

 | Emission Map | Benny_S5_Emission.png | Benny_S5_Emission.png | 변경 없음 |

 | Emission Intensity (HDR) | 1.0 | 0.3 | ✅ 감소 |

 | Emission Color | #DDD6FE (라벤더 흰색) | #DDD6FE | 변경 없음 |

 | Material Shader | Standard (Specular setup) | Standard (Specular setup) | 변경 없음 |

 
 

 
## 3. 시각적 비교

 
 
 기존 (HDR 1.0) 
 과도한 발광 
 라벤더 색상이 너무 밝아서 시각적 부담스러움. 게임 톤과 불일치. 
 
 
 신규 (HDR 0.3) 
 자연스러운 발광 
 부드러운 라벤더 발광. 1~4단계 나무와 시각적으로 일관성 유지. 
 
 

 
## 4. Unity 적용 방법

 **Step 1: 마테리얼 수정** 
 // Benny_S5.mat (또는 해당 Material)
Material Properties:
 - Shader: Standard (Specular setup)
 - Albedo: [Benny_S5_Albedo]
 - Normal Map: [Benny_S5_Normal]
 - Emission: [Benny_S5_Emission]
 
// 수정 항목
 - Emission Intensity: 1.0 → 0.3 ✅
 - Emission Color: #DDD6FE (유지) 

 **Step 2: Inspector 설정 (Unity Editor)** 
 1. Project → Assets → Benny_S5.mat 선택
2. Inspector → Emission (드롭다운)
3. Intensity 슬라이더: 1.0 → 0.3 조정
4. Scene 탭에서 실시간 변화 확인
5. 저장 

 **Step 3: 테스트 환경** 
 
 - 기기: Galaxy S21 Ultra (기존 테스트 기기)
 - 라이팅 조건: 실내 표준 조명 + 오버캐스트 환경
 - 카메라: Garden.unity 카메라 기본 설정
 - 예상 결과: 라벤더 발광이 너무 밝지 않으면서도 5단계 특별함 표현
 

 
## 5. QA 검증 기준 (4/30)

 
 | 검증 항목 | 기준 | 상태 |

 | Emission 감소 확인 | HDR 0.3 적용 후 시각적 밝기 30% 이상 감소 | 확인 필요 |

 | 시각적 톤 일관성 | 1~4단계 나무와 비교했을 때 과도하지 않은 수준 | 확인 필요 |

 | 라벤더 색감 유지 | Emission Color는 #DDD6FE로 유지 — 색상 손실 없음 확인 필요 |

 | 성능 영향 | 드로우콜, 메모리 변화 없음 (마테리얼 속성만 변경) | 없음 |

 

 
## 6. 적용 타임라인

 
 - **4/28 오후 4시:** 아트팀 64번 문서 검토 및 마테리얼 수정 시작
 - **4/29 오전 9시:** QA팀 수정 내용 검증
 - **4/30 정오:** 최종 확인 후 41번 공식 업데이트 (v1.1)
 

 
## 7. 문서 업데이트 (41번 스펙서)

 41번 "베니5단계_나무_아트에셋스펙.html"의 아래 섹션 업데이트: 
 ## 3. 텍스처 색상 스펙 — 5단계 나무 (기존)
Emission: #DDD6FE + 계절별 추가 발광

→ 수정됨 (v1.1):

## 3. 텍스처 색상 스펙 — 5단계 나무 ✅
Emission: #DDD6FE + Intensity HDR 0.3 (과도한 밝기 제거)
- 기존: HDR 1.0 (과도한 발광)
- 신규: HDR 0.3 (자연스러운 부드러운 발광)
- 변경사유: FB-11 (일반 조명에서 과도하게 밝음 → 해소) 

 
 
 📋 관련 문서:
 41번 아트에셋 스펙 ·
 39번 3단계 스펙 ·
 40번 4단계 스펙 ·
 59번 액션 추적