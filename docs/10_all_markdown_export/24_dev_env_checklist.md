---
source_html: 24_dev_env_checklist.html
exported: 2026-05-01
---

# 개발 환경 세팅 체크리스트 — 베니와 함께 — 베니와 함께

개발 환경 세팅 체크리스트 — 베니와 함께 — 베니와 함께 

# 개발 환경 세팅 체크리스트 — 베니와 함께

소울나루(SOUL NARU) | 버전 1.0 | 작성일: 2026-04-04 
**근거**: 3차 리뷰 항목 8 — Critical 블로커 1위 "개발 환경 표준 세팅 문서 부재" 

## 개요

이 문서는 "베니와 함께" Unity 프로젝트 개발에 참여하는 **모든 팀원**이 개발 환경을 동일하게 구성하기 위한 표준 체크리스트입니다.

킥오프(2026-04-07) 전까지 본 체크리스트를 완료한 후 팀 Slack `#dev-setup` 채널에 "환경 세팅 완료" 메시지를 남겨주세요.

## 1. Unity 2022.3 LTS 설치 및 URP 패키지 버전 확인

### 1.1 Unity 버전 설치

| 항목 | 필수 버전 |
| --- | --- |
| Unity Editor | 2022.3.x LTS (최신 패치 권장: 2022.3.62f1 이상) |
| Unity Hub | 3.x 이상 |
| Build Support (Android) | Android Build Support + OpenJDK + Android SDK & NDK Tools |
| Build Support (iOS) | iOS Build Support (macOS만 해당) |

**설치 절차**:

- [Unity Hub](https://unity.com/download) 다운로드 및 설치

- Unity Hub → Installs → Install Editor → 2022.3.x LTS 선택

- Modules 체크: Android Build Support ✅ + iOS Build Support ✅ (macOS) + WebGL Build Support (선택)

- 설치 완료 후 버전 확인: Help → About Unity → Version: 2022.3.x

### 1.2 URP 패키지 버전 확인

`Unity Editor → Window → Package Manager → Universal RP` 

| 패키지 | 버전 |
| --- | --- |
| Universal RP | 14.0.x (Unity 2022.3 LTS 대응 버전) |
| Shader Graph | 14.0.x (URP 버전과 일치) |
| Core RP Library | 14.0.x |

⚠️ URP 버전이 Unity 버전과 불일치하면 쉐이더 컴파일 오류 발생. Package Manager에서 동일 메이저 버전(14.x) 유지 필수. 
**설치 확인 체크리스트**:

- [ ] Unity 2022.3.x LTS 설치 완료

- [ ] Android Build Support 모듈 설치 완료

- [ ] iOS Build Support 모듈 설치 완료 (macOS 팀원)

- [ ] URP 14.0.x 패키지 확인 완료

- [ ] Project Settings → Graphics → Scriptable Render Pipeline Asset이 UniversalRenderPipelineAsset 으로 설정됨

## 2. Firebase SDK 설치 및 구성 파일 세팅

### 2.1 Firebase SDK 설치

| SDK | 버전 | 다운로드 |
| --- | --- | --- |
| Firebase Unity SDK | 12.x (2022.3 LTS 호환) | [Firebase Console](https://console.firebase.google.com/) → 프로젝트 설정 → SDK 다운로드 |

**설치 절차**:

- Firebase Console → "베니와 함께" 프로젝트 접속 (접근 권한 필요 → 섹션 6 참조)

- FirebaseSDK.unitypackage 다운로드

- Unity Editor → Assets → Import Package → Custom Package → 패키지 선택

- 필수 컴포넌트만 임포트:

- Firebase Analytics ✅

- Firebase Authentication ✅

- Firebase Firestore ✅

- Firebase Messaging (FCM) ✅

- Firebase Remote Config ✅ (선택)

### 2.2 플랫폼별 구성 파일 세팅

⚠️ **보안 주의**: 아래 파일들은 **절대 Git에 커밋하지 마세요.** `.gitignore`에 등록되어 있으나 재확인 필수. 

#### Android — google-services.json

- Firebase Console → 프로젝트 설정 → "Android 앱 추가" (앱 ID: com.soulnaru.benny )

- google-services.json 다운로드

- Unity 프로젝트 → Assets/ 루트에 배치 (Firebase Plugin이 자동 인식)

`Assets/
└── google-services.json ← 여기에 배치` 

#### iOS — GoogleService-Info.plist

- Firebase Console → 프로젝트 설정 → "iOS 앱 추가" (Bundle ID: com.soulnaru.benny )

- GoogleService-Info.plist 다운로드

- Unity 프로젝트 → Assets/ 루트에 배치

`Assets/
└── GoogleService-Info.plist ← 여기에 배치` 
**확인 체크리스트**:

- [ ] Firebase SDK 임포트 완료 (콘솔 오류 없음)

- [ ] google-services.json Assets/ 루트 배치 완료

- [ ] GoogleService-Info.plist Assets/ 루트 배치 완료 (macOS)

- [ ] .gitignore 에 두 파일 모두 등록 확인 ( git status 로 Untracked 상태 확인)

- [ ] Unity Console에 Firebase 초기화 오류 없음

## 3. VARCO API 키 환경 변수 설정

### 3.1 API 키 관리 원칙

⚠️ **VARCO API 키는 클라이언트(Unity 빌드) 내에 하드코딩 절대 금지** 
키는 반드시 서버사이드(Firebase Cloud Functions)에서만 사용하며, 클라이언트는 서버를 경유하여 VARCO API를 호출한다. 

### 3.2 로컬 개발 환경 — .env 파일 방식

Firebase Functions 로컬 에뮬레이터 실행 시 사용:

`# /functions/.env (Git 제외 — .gitignore에 등록)
VARCO_API_KEY=your_varco_api_key_here
VARCO_API_ENDPOINT=https://api.varco.ai/v1
VARCO_MODEL_ID=varco-llm-13b-instruct-v1
FIREBASE_PROJECT_ID=benny-soulnaru` 
**설정 절차**:

- /functions/ 디렉토리에 .env 파일 생성

- Slack DM 또는 1Password(팀 공유 Vault)에서 API 키 수령

- Firebase 에뮬레이터 실행 시 자동 로드됨:

`firebase emulators:start --only functions` 

### 3.3 배포 환경 — Firebase Secret Manager 방식

`# Firebase CLI로 Secret 등록 (최초 1회 — 권한 있는 팀원만 실행)
firebase functions:secrets:set VARCO_API_KEY

# Cloud Function 코드에서 참조
import { defineSecret } from "firebase-functions/params";
const varcoApiKey = defineSecret("VARCO_API_KEY");` 

### 3.4 Unity Cloud Build 변수 방식

Unity Cloud Build(CI/CD)에서 빌드 시 환경 변수를 주입하는 경우:

- Unity Dashboard → Cloud Build → 대상 빌드 타겟 → Config → Environment Variables

- VARCO_API_KEY , FIREBASE_CONFIG 등 추가

- Unity C# 코드에서 읽기:

`// Editor 전용 — Runtime 사용 절대 금지
string varcoKey = System.Environment.GetEnvironmentVariable("VARCO_API_KEY");` 
**확인 체크리스트**:

- [ ] /functions/.env 파일 생성 및 API 키 등록 완료

- [ ] .gitignore 에 /functions/.env 등록 확인

- [ ] Firebase 에뮬레이터 실행 → Cloud Function VARCO 호출 테스트 성공

- [ ] VARCO API 키가 Unity 클라이언트 코드에 하드코딩되어 있지 않음 확인

## 4. Git 저장소 클론 및 브랜치 전략

### 4.1 저장소 클론

`# HTTPS (기본)
git clone https://github.com/soulnaru/benny-with-me.git

# SSH (권장 — SSH 키 등록 후)
git clone git@github.com:soulnaru/benny-with-me.git

cd benny-with-me` 
⚠️ Git 저장소 접근 권한은 GitHub 조직 `soulnaru`의 멤버 초대로 부여 (섹션 6 참조) 

### 4.2 브랜치 전략 (Git Flow 기반)

`main ← 릴리스 브랜치 (배포 가능 상태만 머지)
└── develop ← 통합 개발 브랜치 (기능 PR 머지 대상)
├── feature/emotion-checkin ← 기능 개발 브랜치
├── feature/benny-animation
├── feature/garden-system
├── fix/bug-123-checkin-crash ← 버그 수정
└── hotfix/v1.0.1-login-fix ← 긴급 패치 (main에서 분기)` 
**브랜치 규칙**:

| 브랜치 | 보호 규칙 | 머지 방식 |
| --- | --- | --- |
| main | PR 필수 + 리뷰어 2인 승인 + CI 통과 | Squash Merge |
| develop | PR 필수 + 리뷰어 1인 승인 + CI 통과 | Squash Merge |
| feature/* | 자유롭게 푸시 가능 | — |
| fix/* | 자유롭게 푸시 가능 | — |
| hotfix/* | main에서 분기, main·develop 동시 머지 | — |

**브랜치 생성 규칙**:

`# 새 기능 작업 시 develop에서 분기
git checkout develop && git pull origin develop
git checkout -b feature/breathing-guide-ui

# 작업 완료 후 PR 생성 → develop 대상
git push origin feature/breathing-guide-ui
# GitHub에서 PR 생성` 
**확인 체크리스트**:

- [ ] git clone 완료 및 프로젝트 폴더 확인

- [ ] git checkout develop && git pull 정상 작동

- [ ] 본인 이름의 테스트 feature 브랜치 생성·삭제 테스트 완료

- [ ] Git 사용자 설정 확인: git config user.name / git config user.email

## 5. 빌드 타입(Debug/Alpha/Release) 전환 방법

### 5.1 빌드 타입 정의

| 빌드 타입 | 목적 | Firebase 프로젝트 | 로그 레벨 |
| --- | --- | --- | --- |
| Debug | 로컬 개발, 에뮬레이터 | benny-dev | Verbose |
| Alpha | 내부 테스트 (Firebase App Distribution) | benny-staging | Info |
| Release | 앱스토어 배포 | benny-prod | Error only |

### 5.2 Unity에서 빌드 타입 전환

**방법 1 — Scripting Define Symbols 활용**

`Unity → Project Settings → Player → Other Settings → Scripting Define Symbols` 

| 빌드 타입 | Scripting Define Symbols |
| --- | --- |
| Debug | BUILD_DEBUG;ENABLE_LOGS |
| Alpha | BUILD_ALPHA |
| Release | BUILD_RELEASE |

**C# 코드에서 조건부 처리**:

`#if BUILD_DEBUG
Debug.Log("[DEBUG] EmotionManager: CheckIn submitted");
// 개발용 테스트 데이터 로드
#elif BUILD_ALPHA
// 알파 전용 Firebase Analytics 이벤트
#else
// 릴리스 — 로그 없음
#endif` 
**방법 2 — Build Profile(Unity 2022.3+) 활용**:

- File → Build Profiles 에서 Debug/Alpha/Release 각각 Profile 생성

- 각 Profile에 Scripting Define Symbols 및 Firebase 구성 파일 경로 지정

- 빌드 시 해당 Profile 선택 후 Build

### 5.3 Firebase 환경 전환

`# Firebase 프로젝트 전환
firebase use benny-dev # Debug
firebase use benny-staging # Alpha
firebase use benny-prod # Release (권한 제한)` 
⚠️ `benny-prod` 환경은 PM Alex 및 CTO만 접근 가능. 개발팀은 `benny-dev` / `benny-staging`만 사용. 
**확인 체크리스트**:

- [ ] Debug 빌드로 Android/iOS 기기 배포 성공

- [ ] BUILD_DEBUG Define Symbol 활성화 시 콘솔 로그 출력 확인

- [ ] Firebase Console에서 benny-dev 프로젝트 연결 확인

## 6. 팀원별 역할 및 접근 권한

### 6.1 팀 구성 및 역할

| 역할 | 담당자 | 주요 책임 |
| --- | --- | --- |
| PM / 기획 | Alex (AI PM) | GDD·스프린트 계획·문서 관리 |
| 프로젝트 총괄 | wonman님 | 최종 의사결정, 방향성 |
| 리드 개발자 | TBD | Unity 아키텍처, CI/CD |
| Unity 클라이언트 | TBD (2~3명) | UI, 베니 시스템, 정원 |
| 백엔드 / Firebase | TBD | Cloud Functions, DB 설계 |
| 아트 | TBD | 베니 모델, 정원 오브젝트, 2D 이미지 제작 |
| QA | TBD | 테스트 계획 실행, 버그 리포트 |

### 6.2 시스템 접근 권한

| 시스템 | 역할별 권한 | 신청 방법 |
| --- | --- | --- |
| GitHub soulnaru/benny-with-me | 전 팀원: Write, PM·리드 개발: Admin | wonman님에게 GitHub ID 제출 → 초대 |
| Firebase Console benny-dev | 전 팀원: Editor | Firebase Console → 프로젝트 설정 → 구성원 추가 |
| Firebase Console benny-staging | 리드 개발·QA: Editor, 기타: Viewer | 리드 개발자에게 요청 |
| Firebase Console benny-prod | PM Alex·CTO·wonman님만 | wonman님 승인 필요 |
| Unity Cloud Build | 리드 개발·PM: Admin, 기타: View | Unity 대시보드 초대 |
| 앱스토어 Connect (iOS) | PM Alex·wonman님 | App Store Connect 멤버 초대 |
| Google Play Console | PM Alex·wonman님 | Google Play Console 초대 |
| VARCO API Console | 백엔드 담당: 접근 가능 | wonman님에게 요청 |
| 1Password 팀 Vault | 전 팀원 | wonman님에게 이메일 제출 → 초대 |

⚠️ API 키, 구성 파일, 비밀번호는 **반드시 1Password 팀 Vault**를 통해 공유. 슬랙/이메일 직접 공유 금지. 
**접근 권한 신청 체크리스트**:

- [ ] GitHub 저장소 초대 수락 완료

- [ ] Firebase benny-dev 프로젝트 접근 확인

- [ ] 1Password 팀 Vault 접근 확인

- [ ] Slack #dev-soulnaru 채널 가입 완료

## 7. 첫 빌드 테스트 체크리스트

### 7.1 Android 첫 빌드

**사전 조건**:

- Android Studio 설치 (최신 버전)

- Android 기기(테스트용) 또는 에뮬레이터 준비

- Unity Android Build Support 모듈 설치 완료

**절차**:

`1. Unity → File → Build Settings → Android 선택
2. Switch Platform (첫 전환 시 수분 소요)
3. Player Settings 확인:
- Company Name: SoulNaru
- Product Name: 베니와 함께
- Package Name: com.soulnaru.benny
- Minimum API Level: Android 8.0 (API 26)
- Target API Level: Automatic (Highest Installed)
4. Build Settings → Run Device: 연결된 Android 기기 선택
5. "Build And Run" 클릭` 
**첫 빌드 체크리스트 (Android)**:

- [ ] Build Settings → Android 플랫폼 전환 완료 (오류 없음)

- [ ] 패키지 이름 com.soulnaru.benny 확인

- [ ] APK 빌드 성공 (Console에 오류 없음)

- [ ] 기기/에뮬레이터 설치 및 앱 실행 확인

- [ ] Firebase Analytics에 app_open 이벤트 수신 확인 (Firebase Console → DebugView)

- [ ] Boot.unity → MainHome.unity 씬 전환 정상 확인

### 7.2 iOS 첫 빌드 (macOS 팀원)

**사전 조건**:

- macOS Ventura 이상

- Xcode 15 이상 설치

- Apple Developer 계정 (wonman님에게 팀 초대 요청)

- iOS 기기(테스트용) — 에뮬레이터도 가능

**절차**:

`1. Unity → File → Build Settings → iOS 선택
2. Switch Platform
3. Player Settings 확인:
- Bundle Identifier: com.soulnaru.benny
- Minimum iOS Version: 14.0
- Signing Team: [Team ID 입력 — 1Password Vault에서 확인]
4. "Build" 클릭 → Xcode 프로젝트 생성 (폴더 선택)
5. 생성된 Xcode 프로젝트 열기 → Product → Run` 
**첫 빌드 체크리스트 (iOS)**:

- [ ] iOS 플랫폼 전환 완료 (오류 없음)

- [ ] Bundle Identifier com.soulnaru.benny 확인

- [ ] Xcode 프로젝트 생성 성공

- [ ] Signing 설정 완료 (Automatically Manage Signing)

- [ ] 기기 빌드·실행 성공

- [ ] Firebase Analytics app_open 이벤트 수신 확인

- [ ] GoogleService-Info.plist 포함 확인 (Xcode → Copy Bundle Resources)

## 8. 개발 환경 이슈 FAQ (흔한 오류 Top 5)

### ❌ 오류 1: "gradle build failed" (Android 빌드)

**증상**: Android 빌드 시 Gradle 오류 발생

**원인 및 해결**:

`원인 1: JDK 버전 불일치
→ Unity → Preferences → External Tools → JDK를 "Unity에 내장된 JDK 사용"으로 설정

원인 2: Android SDK API 레벨 미설치
→ Android Studio → SDK Manager → API 26 이상 설치

원인 3: google-services.json 미배치
→ Assets/ 루트에 google-services.json 파일 존재 여부 확인` 

### ❌ 오류 2: Firebase 초기화 실패 ( FirebaseApp.CheckAndFixDependenciesAsync )

**증상**: 앱 실행 시 Firebase 초기화 오류, `DependencyStatus.UnavailableDisabled` 반환

**원인 및 해결**:

`원인 1: 구성 파일 누락 (google-services.json / GoogleService-Info.plist)
→ Assets/ 루트에 파일 배치 여부 확인

원인 2: Firebase SDK 버전 불일치
→ Package Manager에서 Firebase SDK 12.x 버전 확인

원인 3: 패키지 이름 불일치
→ Firebase Console 앱 설정의 패키지 이름 vs Unity Player Settings 패키지 이름 일치 확인` 

### ❌ 오류 3: URP 쉐이더 핑크/마젠타 표시

**증상**: 정원 오브젝트, 베니 모델이 분홍색으로 표시됨

**원인 및 해결**:

`원인: Standard 쉐이더(Built-in RP) 사용 에셋을 URP 프로젝트에서 사용

해결:
1. Edit → Rendering → Render Pipeline → Upgrade Project Materials to URP
2. 특정 오브젝트만: 오브젝트 선택 → Material → Shader를 Universal Render Pipeline/Lit으로 변경
3. 2D 이미지 제작 임포트 에셋은 임포트 후 위 방법으로 일괄 변환` 

### ❌ 오류 4: iOS 빌드 코드서명 오류 ( No matching provisioning profiles found )

**증상**: Xcode 빌드 시 Provisioning Profile 오류

**원인 및 해결**:

`원인 1: Apple Developer 팀 미참가
→ wonman님에게 Apple Developer 팀 초대 요청 → Xcode → Preferences → Accounts에서 팀 확인

원인 2: Bundle ID 불일치
→ Xcode → Signing & Capabilities → Bundle Identifier: com.soulnaru.benny 일치 확인

원인 3: Provisioning Profile 만료
→ Xcode → Automatically Manage Signing 체크 → 자동 갱신

빠른 해결: Xcode → Product → Clean Build Folder → 재빌드` 

### ❌ 오류 5: NullReferenceException — 씬 전환 후 매니저 참조 실패

**증상**: 씬 전환 시 `GameManager.Instance` 또는 `EmotionManager.Instance`가 null 반환

**원인 및 해결**:

`// 원인: DontDestroyOnLoad 매니저가 Boot.unity에서만 초기화됨
// → 개발 중 특정 씬에서 직접 Play하면 매니저가 생성되지 않음

// 해결 1: 개발 시 항상 Boot.unity에서 Play 시작
// (File → Build Settings → 씬 순서 확인: Boot.unity가 0번)

// 해결 2: 매니저 초기화 안전 코드 추가
public static GameManager Instance;

private void Awake()
{
if (Instance != null && Instance != this)
{
Destroy(gameObject);
return;
}
Instance = this;
DontDestroyOnLoad(gameObject);
}

// 해결 3: [개발용] AutoStart.cs — 에디터에서 현재 씬 직접 실행 시 Boot 씬 먼저 로드
#if UNITY_EDITOR
[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
static void EnsureBootSceneLoaded()
{
if (GameManager.Instance == null)
{
UnityEngine.SceneManagement.SceneManager.LoadScene("Boot");
}
}
#endif` 

## 부록: 팀 공용 도구 링크

| 도구 | 링크 | 용도 |
| --- | --- | --- |
| GitHub 저장소 | https://github.com/soulnaru/benny-with-me | 코드 관리 |
| Firebase Console (dev) | https://console.firebase.google.com/project/benny-dev | 개발 DB |
| Firebase Console (staging) | https://console.firebase.google.com/project/benny-staging | 알파 테스트 |
| Unity Dashboard | https://cloud.unity.com | Cloud Build |
| Slack | #dev-soulnaru / #dev-setup / #bugs | 팀 커뮤니케이션 |
| Notion (문서) | PM Alex에게 요청 | 스프린트 보드 |
| 1Password Vault | benny-with-me-team | API 키·비밀번호 |

문서 버전: v1.0 | 작성일: 2026-04-04 | 작성: AI PM Alex | 검토: CTO·리드 개발 

(v1.0 초판 생성 — 3차 리뷰 항목8 "개발환경 표준 세팅 문서 부재" Critical 블로커 해소) 

소울나루 · 베니와 함께 | 2026-04-04  ·  [← 문서 허브](/benny/)
