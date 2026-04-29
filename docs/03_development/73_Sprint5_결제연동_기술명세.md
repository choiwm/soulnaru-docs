---
doc_number: 73
version: v1.0
updated: 2026-04-29
---

73번 — Sprint 5 결제 연동 기술 명세서 · 소울나루 

 
 

 

# 💳 Sprint 5 결제 연동 기술 명세서 (RevenueCat IAP)

 
 **문서번호:** 73 | 
 **버전:** v1.0 | 
 **Sprint:** 5 (5/1~5/7) | 
 **담당:** 개발 A | 
 **기간:** 5/1~5/5
 

 
 📐 **RevenueCat SDK 기반 IAP 연동 전체 명세.** 70번(IAP 상품 명세) + 이 문서로 개발 A가 독립적으로 구현 가능.
 

## 1. 아키텍처 개요

 
 결제 흐름 레이어 
 
```

[사용자] → Paywall.unity 씬
 ↓
[PaywallManager.cs] ← RevenueCat Unity SDK
 ↓
[RevenueCat 서버] → App Store / Google Play 검증
 ↓
[CustomerInfo.Entitlements["premium"].IsActive]
 ↓
[UserManager.SetPremium(true)] → Firestore 기록
 ↓
[기능 잠금 해제: FreeGatekeeper.cs]
```

 

## 2. RevenueCat 초기화

```
// AppInitializer.cs (앱 시작 시 1회 호출)
using Purchases;
using UnityEngine;

public class AppInitializer : MonoBehaviour {
 [SerializeField] private string revenueCatApiKey_iOS = "appl_xxx";
 [SerializeField] private string revenueCatApiKey_Android = "goog_xxx";

 void Awake() {
 string apiKey;
#if UNITY_IOS
 apiKey = revenueCatApiKey_iOS;
#elif UNITY_ANDROID
 apiKey = revenueCatApiKey_Android;
#endif
 // FirebaseAuth UID를 앱 유저 ID로 사용
 string appUserId = AuthManager.CurrentUserId;
 Purchases.Configure(apiKey, appUserId);
 Purchases.SetLogLevel(LogLevel.Debug); // 개발 중
 }
}
```

## 3. Paywall 화면 — 상품 로드 & 표시

```
// PaywallManager.cs
public class PaywallManager : MonoBehaviour {
 [SerializeField] private TextMeshProUGUI monthlyPriceText;
 [SerializeField] private TextMeshProUGUI annualPriceText;
 [SerializeField] private TextMeshProUGUI annualSavingText;

 private Package _monthly;
 private Package _annual;

 async void Start() {
 await LoadOfferings();
 await CheckCurrentSubscription();
 }

 async Task LoadOfferings() {
 var offerings = await Purchases.GetOfferingsAsync();
 var current = offerings.Current;
 if (current == null) { ShowError("상품 로드 실패"); return; }

 _monthly = current.Monthly;
 _annual = current.Annual;

 // 가격 표시 (플랫폼 현지화 자동)
 monthlyPriceText.text = _monthly?.StoreProduct.PriceString ?? "₩6,900";
 annualPriceText.text = _annual?.StoreProduct.PriceString ?? "₩59,000";
 annualSavingText.text = "월간 대비 29% 절약";
 }

 // 구독 상태 확인
 async Task CheckCurrentSubscription() {
 var info = await Purchases.GetCustomerInfoAsync();
 bool isPremium = info.Entitlements["premium"]?.IsActive == true;
 UserManager.SetPremium(isPremium);
 if (isPremium) ShowCurrentPlanUI(info);
 }
}
```

## 4. 결제 처리 (구독)

```
// PaywallManager.cs — 결제 버튼 핸들러
public async void OnMonthlyButtonClick() => await Purchase(_monthly);
public async void OnAnnualButtonClick() => await Purchase(_annual);

async Task Purchase(Package package) {
 if (package == null) return;
 ShowLoadingOverlay(true);
 try {
 var result = await Purchases.PurchasePackageAsync(package);
 if (result.CustomerInfo.Entitlements["premium"].IsActive) {
 // ✅ 결제 성공
 UserManager.SetPremium(true);
 await FirestoreManager.LogPurchase(new PurchaseLog {
 userId = AuthManager.CurrentUserId,
 planType = package.PackageType.ToString(), // MONTHLY / ANNUAL
 pricePaid = package.StoreProduct.Price,
 currency = package.StoreProduct.CurrencyCode,
 purchasedAt = DateTime.UtcNow
 });
 SceneManager.LoadScene("Garden"); // Paywall 닫고 정원으로
 }
 } catch (PurchasesErrorException e) {
 if (!e.PurchasesError.UserCancelled)
 ShowError($"결제 중 오류가 발생했어요: {e.PurchasesError.Message}");
 } finally {
 ShowLoadingOverlay(false);
 }
}
```

## 5. 구매 복원

```
// PaywallManager.cs — 복원 버튼
public async void OnRestoreButtonClick() {
 ShowLoadingOverlay(true);
 try {
 var info = await Purchases.RestorePurchasesAsync();
 bool isPremium = info.Entitlements["premium"]?.IsActive == true;
 UserManager.SetPremium(isPremium);
 if (isPremium) {
 ShowMessage("구독이 복원되었어요! 🎉");
 SceneManager.LoadScene("Garden");
 } else {
 ShowMessage("복원할 구독 내역이 없어요.");
 }
 } catch (PurchasesErrorException e) {
 ShowError($"복원 오류: {e.PurchasesError.Message}");
 } finally {
 ShowLoadingOverlay(false);
 }
}
```

## 6. FreeGatekeeper — 기능 잠금 처리

```
// FreeGatekeeper.cs — 씬 전체에서 사용
public static class FreeGatekeeper {
 public static bool CanAccess(FeatureType feature) {
 bool isPremium = UserManager.IsPremium;
 return feature switch {
 FeatureType.DailyCheckin => isPremium || DailyCheckinCount isPremium,
 FeatureType.ACTDay8Plus => isPremium,
 FeatureType.GardenPremiumObj => isPremium,
 FeatureType.CrisisConnect => true, // 항상 허용
 _ => isPremium
 };
 }

 // 잠금 시 Paywall 유도
 public static void OnAccessDenied(FeatureType feature) {
 string msg = feature switch {
 FeatureType.AlbumFullHistory => "전체 감정 기록은 프리미엄에서 볼 수 있어요.",
 FeatureType.ACTDay8Plus => "Day 8부터의 미션은 프리미엄 전용이에요.",
 _ => "이 기능은 프리미엄 전용이에요."
 };
 PaywallPrompt.Show(msg); // 안내 팝업 + Paywall 이동 버튼
 }
}
```

## 7. Firestore 결제 기록 스키마

```
// Firestore: Purchases 컬렉션
{
 userId: "uid_xxx",
 planType: "MONTHLY" | "ANNUAL",
 pricePaid: 6900, // 숫자 (원화 기준)
 currency: "KRW",
 platform: "iOS" | "Android",
 transactionId: "xxx", // RevenueCat Transaction ID
 purchasedAt: Timestamp,
 expiresAt: Timestamp, // 구독 만료일
 isActive: true
}
```

## 8. 검증 체크리스트

 
 | 케이스 | 환경 | 기준 |

 | IAP-01 월간 결제 성공 | iOS Sandbox | CustomerInfo premium.IsActive == true |

 | IAP-02 연간 결제 성공 | iOS Sandbox + Android Test | 동일 |

 | IAP-03 무료 체험 적용 | 신규 Sandbox 계정 | 7일 무료 체험 표시 |

 | IAP-04 복원 | 기기 재설치 시나리오 | 복원 후 Premium 활성화 |

 | IAP-05 결제 실패 | Sandbox 오류 주입 | 에러 메시지 노출, 크래시 없음 |

 | IAP-06 기능 잠금 해제 | iOS + Android | Album 전체·ACT Day 8+ 접근 가능 |

 

 
 관련 문서:
 70번 IAP 상품 ·
 72번 킥오프 ·
 74번 씬 명세