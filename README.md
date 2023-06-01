# MC2 - Snooze
Group2 Team5 - 여사님과 하네스

## 🐤 About Snooze
저희 팀은 반려동물이 더 행복하게 시간을 보낼 수 있는 서비스를 만들자는 취지를 가지고 모인 팀입니다.<br>
저희는 반려동물의 시간과 사람의 시간은 다르다는 것을 알게되었고, 이를 많은 사람들이 인지하지 못하다는 사실을 알게되었습니다.<br>
그래서 만들어진 Snooze는 `반려동물이 집에서 홀로 기다리고 있는 순간을 주인이 익숙해지지 않도록 각인시켜주는 앱` 입니다.<br>

## 🐶 About 여사님과 하네스
| [Azhy](https://github.com/ungchun) | Sonia | [Green](https://github.com/JJemyeong) | [Poodle](https://github.com/poodlepoodle) | [Wonni](https://github.com/wonniiii) | Sia |
|:-----------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------------:|
| <img src="https://github.com/DeveloperAcademy-POSTECH/MC2-Team5-Snooze/assets/81157265/5dfa0cf8-fc19-40d5-ae3e-336af000df5c" width="100"/> | <img src="https://github.com/DeveloperAcademy-POSTECH/MC2-Team5-Snooze/assets/81157265/21c43592-6922-4cf1-a4ed-4ad4e112a78a" width ="100"/> |<img src="https://github.com/DeveloperAcademy-POSTECH/MC2-Team5-Snooze/assets/81157265/3c642818-1537-4479-8ba9-2ead096ea845" width="100" height="100" /> | <img src="https://github.com/DeveloperAcademy-POSTECH/MC2-Team5-Snooze/assets/81157265/f1b312ed-f76c-4ea4-85d0-57d2ab435a3c" width ="100"/> | <img src="https://github.com/DeveloperAcademy-POSTECH/MC2-Team5-Snooze/assets/81157265/b86a2e18-12c4-4192-91ac-e20284ff98f7" width="100"> | <img src="https://github.com/DeveloperAcademy-POSTECH/MC2-Team5-Snooze/assets/81157265/8acf4263-6121-44af-8905-f0328fe3d2de" width ="100"/> |
| Tech | Design | Design | Tech | Tech | Design                                                                                                                              
<br>

## 🐰 Development Environment
<img width="70" src="https://img.shields.io/badge/IOS-15%2B-silver">  <img width="85" src="https://img.shields.io/badge/Xcode-14.3-blue">

<br>

## 🐱 Skills
* UIKit
* RxSwift
* Inner Pacakge
* MVVM 
* CleanArchitecture
* WidgetKit
* Realm
<br>

## 🐹 Convention
<details>
<summary>Code Convention</summary><br>
<a href="https://github.com/StyleShare/swift-style-guide"> StyleShare/swift-style-guide</a> 에 맞춰서 작성했습니다.
</details>

<details>
<summary>Commit Convention</summary><br>
  
 * `Udacity Git Commit Message Style Guide`를 참고
 * `Gitmoji` 사용  <br>
  
| Gitmoji | Header | 설명 |
| --- | --- | --- |
| :sparkles: | feat: | 새로운 기능에 대한 커밋 |
| :bug: | fix: | 버그 수정에 대한 커밋 |
| :memo: | docs: | 문서 수정에 대한 커밋 |
| :lipstick: | style: | UI 스타일에 관한 커밋 |
| :recycle: | refactor: | 코드 리팩토링에 대한 커밋 |
| :white_check_mark: | test: | 테스트 코드 수정에 대한 커밋 |
| :tada: | init: | 프로젝트 시작에 대한 커밋 |
| :heavy_plus_sign: | plus: | 의존성 추가에 대한 커밋 |
| :heavy_minus_sign: | minus: | 의존성 제거에 대한 커밋 |
| :hammer: | chore: | 그 외 자잘한 수정에 대한 커밋 (기타 변경 사항) |
</details>
<br>

## 🐻‍❄️ Folder Architecture
<pre>
<code>
📦 Snooze
 ┣ 📂 Application
 ┣ 📂 Common
 ┣ 📂 Data
 ┃  ┣ 📂 Storage
 ┃  ┃ ┗ 📂 UserDefaults
 ┣ 📂 Domain
 ┃  ┣ 📂 Entities
 ┣ 📂 Presentation
 ┃  ┣ 📂 DrawerScene
 ┃  ┃  ┣ 📂 View
 ┃  ┃  ┗ 📂 ViewController
 ┃  ┣ 📂 LocationTest
 ┃  ┣ 📂 LoginScene
 ┃  ┃  ┗ 📂 ViewController
 ┃  ┣ 📂 MainScene
 ┃  ┃  ┣ 📂 View
 ┃  ┃  ┣ 📂 ViewController
 ┃  ┃  ┗ 📂 ViewModel
 ┃  ┣ 📂 NotificationScene
 ┃  ┃  ┣ 📂 View
 ┃  ┃  ┣ 📂 ViewController
 ┃  ┃  ┗ 📂 ViewModel
 ┃  ┣ 📂 OnboardingScene
 ┃  ┃  ┣ 📂 View
 ┃  ┃  ┣ 📂 ViewController
 ┃  ┃  ┗ 📂 ViewModel
 ┃  ┣ 📂 RegistrationScene
 ┃  ┃  ┣ 📂 View
 ┃  ┃  ┣ 📂 ViewController
 ┃  ┃  ┗ 📂 ViewModel
 ┃  ┣ 📂 SettingScene
 ┃  ┃  ┣ 📂 View
 ┃  ┃  ┣ 📂 ViewController
 ┃  ┃  ┗ 📂 ViewModel
 ┣ 📂 Resource
    ┗ Assets.xcassets
</code>
</pre>



