//
//  TapButtonViewController.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/09.
//

import UIKit
import OnJeWaUI
import OnJeWaCore
import OnJeWaNetwork
import Gifu
import WidgetKit

protocol TapButtonViewDelegate: AnyObject {
  func didTapButton(value: String)
  func homeInTap()
}

final class TapButtonViewController: BaseViewController {
	
  let viewModel = MainViewModel()
  
  // 델리게이트는 무조건 weak var
  weak var delegate: TapButtonViewDelegate?
  //타이머
  var timer = Timer()
  var startTime: Date?
  deinit {
    timer.invalidate()
  }
  //현재 시간
  var counter = 0.0
  var animalCounter = 0.0
  private var isAnimating = false
  private var initialAngle: CGFloat = 0.0
  
  //MARK: - UI Components
  
  private let titleLabel: UILabel = {
    let label = UILabel()
//    label.text = "\(RealmManager.shared.readName())의 하루"
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    return label
  }()
  
  private let dateLabel: UILabel = {
    let label = UILabel()
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy년 M월 d일"
    let dateString = dateFormatter.string(from: currentDate)
    label.text = dateString
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()
  
  private let popupButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "question"), for: .normal)
    button.contentMode = .scaleAspectFit
    button.addTarget(self, action: #selector(didTapPopupButton), for: .touchUpInside)
    return button
  }()
  
  @objc func didTapPopupButton() {
    let popupVC = CustomPopupViewController()
    popupVC.modalPresentationStyle = .overFullScreen
    self.present(popupVC, animated: false)
  }
  private let clockImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "clock")
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let animalTimeImageView: UIImageView = {
    let imageView = UIImageView()
    switch UserDefaultsSetting.mainPet {
    case "dog":
      imageView.image = UIImage(named: "dogWatch")
      break
    case "cat":
      imageView.image = UIImage(named: "catWatch")
      break
    case "parrot":
      imageView.image = UIImage(named: "parrotWatch")
      break
    case "rabbit":
      imageView.image = UIImage(named: "rabbitWatch")
      break
    default:
      break
    }
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let humanTimeImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "insideWatch")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  //   애니메이션 시작
  func startAnimation() {
    guard !isAnimating else { return }
    
    isAnimating = true
    animalTimeImageView.transform = CGAffineTransform.identity // 처음 각도로 원위치
    humanTimeImageView.transform = CGAffineTransform.identity // 처음 각도로 원위치
    rotateView(view: animalTimeImageView, angle: 36.0)
    rotateView(view: humanTimeImageView, angle: 12.0)
  }
  
  //애니메이션 중단
  func stopAnimation() {
    isAnimating = false
  }
  
  //   컴포넌트 회전 애니메이션
  func rotateView(view: UIView, angle: Double) {
    UIView.animate(withDuration: 2.0, animations: {
      view.transform = view.transform.rotated(by: angle / 36.0)
      
    }) { (_) in
      self.rotateView(view: view, angle: angle) // 애니메이션 재귀 호출
    }
  }
  
  private let carrotNumber: UILabel = {
    let label = UILabel()
    var labelData = 2
    label.text = "🥕x\(labelData)"
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .black
    return label
  }()
  
  private let inClockAnimalImageView: GIFImageView = {
    let imageView = GIFImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  let inClockTitleLabel: UILabel = {
    let label = UILabel()
//    label.text = UserDefaultsSetting.mainType == "leave" ? "\(RealmManager.shared.readName()) 나와 함께한지" : "\(RealmManager.shared.readName()) 나를 기다린지"
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = .black
    return label
  }()
  
  var inClockAnimalTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "00:00:00"
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 36)
    return label
  }()
  
  func updateLabel(_ text: String) {
    DispatchQueue.main.async {
      self.inClockAnimalTimeLabel.text = text
    }
  }
  
  let inClockHumanTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "00:00:00"
    label.font = UIFont.systemFont(ofSize: 14)
    return label
  }()
  
  lazy var homeOutButton: UIButton = {
    let button = UIButton()
    //        button.setImage(UIImage(named: "homeoutUnClicked"), for: .normal)
    button.contentMode = .scaleAspectFit
    button.addTarget(self, action: #selector(homeOutButtonTapped), for: .touchUpInside)
    return button
  }()
  
  lazy var homeInButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "homeinUnClicked"), for: .normal)
    button.contentMode = .scaleAspectFit
    button.addTarget(self, action: #selector(homeInButtonTapped), for: .touchUpInside)
    return button
  }()
  
  func homeOutButtonTappedDemo() {
//    let localNotificationBuilder = LocalNotificationBuilder(notificationAvatarImage: RealmManager.shared.readProfileImage(), notificationAvatarName: RealmManager.shared.readName())
	  let localNotificationBuilder = LocalNotificationBuilder(notificationAvatarImage: viewModel.userUseCase.readProfileImage(), notificationAvatarName: viewModel.petUseCase.readName())
    localNotificationBuilder.setContent(content: normalNotificationMessages.values.randomElement() ?? "")
    localNotificationBuilder.build(secondAfter: 60)
    
    UserDefaultsSetting.mainType = "work"
    timer.invalidate()
    stopAnimation()
    startAnimation()
    counter = 0.0
    animalCounter = 0.0
    inClockTitleLabel.text = "\(viewModel.petUseCase.readName())가 나를 기다린지"
    
    UserDefaults.standard.setValue(Date(), forKey: "sceneDidEnterBackground")
    UserDefaults.shared.set(0, forKey: "animalHour")
    UserDefaults.shared.set(true, forKey: "homeOutKey")
    WidgetCenter.shared.reloadAllTimelines()
    
    timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    
  }
  
  func homeInButtonTappedDemo() {
    // 알림 멈춤
    UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    
    UserDefaultsSetting.mainType = "leave"
    timer.invalidate()
    stopAnimation()
    startAnimation()
    counter = 0.0
    animalCounter = 0.0
    inClockTitleLabel.text = "\(viewModel.petUseCase.readName())가 나와 함께한지"
    UserDefaults.standard.setValue(Date(), forKey: "sceneDidEnterBackground")
    UserDefaults.shared.set(0, forKey: "animalHour")
    UserDefaults.shared.set(true, forKey: "homeOutKey")
    WidgetCenter.shared.reloadAllTimelines()
    
    timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    
    delegate?.homeInTap()
    
  }
  
  @objc private func homeOutButtonTapped(_ sender: UIButton) {
    if UserDefaultsSetting.mainType != "work" {
      delegate?.didTapButton(value: "out")
      
    } else {
    }
    
  }
  
  @objc func updateTimer() {
    counter += 0.1
    animalCounter += UserDefaultsSetting.mainPet == "rabbit" ? 2.4 : UserDefaultsSetting.mainPet == "parrot" ? 0.6 : 0.4
    let flooredCounter = Int(floor(counter))
    let humanHour = flooredCounter / 3600
    let minute = (flooredCounter % 3600) / 60
    let second = (flooredCounter % 3600) % 60
    let humanTimeString = String(format: "%02d:%02d:%02d", humanHour, minute, second)
    inClockHumanTimeLabel.text = humanTimeString
    
    let animalFlooredCounter = Int(floor(animalCounter))
    let animalHour = animalFlooredCounter / 3600
    let animalMinute = (animalFlooredCounter % 3600) / 60
    let animalSecond = (animalFlooredCounter % 3600) % 60
    let animalTimeString = String(format: "%02d:%02d:%02d", animalHour, animalMinute, animalSecond)
    inClockAnimalTimeLabel.text = animalTimeString
    
    //    UserDefaults.shared.set(minute, forKey: "animalHour")
  }
  
  @objc private func homeInButtonTapped(_ sender: UIButton) {
    if UserDefaultsSetting.mainType != "leave" {
      delegate?.didTapButton(value: "in")
      
    } else {
      
    }
  }
  
  @objc func addbackGroundTime(_ notification: NSNotification) {
    //노티피케이션센터를 통해 값을 받아옴
    let time = notification.userInfo?["time"] as? Double ?? 0.1
    counter = time
    let flooredCounter = Int(floor(counter))
    let humanHour = flooredCounter / 3600
    let minute = (flooredCounter % 3600) / 60
    let second = (flooredCounter % 3600) % 60
    let humanTimeString = String(format: "%02d:%02d:%02d", humanHour, minute, second)
    inClockHumanTimeLabel.text = humanTimeString
    let animalHour = UserDefaultsSetting.mainPet == "rabbit" ? (humanHour + 24) : UserDefaultsSetting.mainPet == "parrot" ? (humanHour + 6) : (humanHour + 4)
    let animalTimeString = String(format: "%02d:%02d:%02d", animalHour, minute, second)
    inClockAnimalTimeLabel.text = animalTimeString
    timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
  }
  
  @objc func stopTimer() {
    timer.invalidate()
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("??? UserDefaultsSetting.mainType \(UserDefaultsSetting.mainType)")
	  
	  inClockTitleLabel.text = UserDefaultsSetting.mainType == "leave" ? "\(viewModel.petUseCase.readName()) 나와 함께한지" : "\(viewModel.petUseCase.readName()) 나를 기다린지"
	  
	  titleLabel.text = "\(viewModel.petUseCase.readName())의 하루"
    
    let dogArray = ["d_1", "d_2", "d_3", "d_4"]
    let catArray = ["c_1", "c_2", "c_3", "c_4"]
    let parrotArray = ["p_1", "p_2", "p_3", "p_4"]
    let rabbitArray = ["r_1", "r_2", "r_3", "r_4"]
    
    switch UserDefaultsSetting.mainPet {
    case "dog":
      DispatchQueue.main.async {
        self.inClockAnimalImageView.animate(withGIFNamed: dogArray.randomElement()!,
                                            animationBlock:  { })
      }
      break
    case "cat":
      DispatchQueue.main.async {
        self.inClockAnimalImageView.animate(withGIFNamed: catArray.randomElement()!,
                                            animationBlock:  { })
      }
      break
    case "parrot":
      print("??? DispatchQueue.main")
      DispatchQueue.main.async {
        self.inClockAnimalImageView.animate(withGIFNamed: parrotArray.randomElement()!,
                                            animationBlock:  { })
      }
      break
    case "rabbit":
      DispatchQueue.main.async {
        self.inClockAnimalImageView.animate(withGIFNamed: rabbitArray.randomElement()!,
                                            animationBlock:  { })
      }
      break
    default:
      break
    }
    
    // 이거 나중에 지워~
    UserDefaults.standard.setValue(Date(), forKey: "sceneDidEnterBackground")
    UserDefaultsSetting.mainType = "none"
    //
    
    NotificationCenter.default.addObserver(self, selector: #selector(addbackGroundTime(_:)), name: NSNotification.Name("sceneWillEnterForeground"), object: nil)
    //포어그라운드에서 백그라운드로 갈때
    NotificationCenter.default.addObserver(self, selector: #selector(stopTimer), name: NSNotification.Name("sceneDidEnterBackground"), object: nil)
    
    if UserDefaultsSetting.mainType == "work" { // 출근상태
      
      //            homeOutButton.setImage(UIImage(named: "homeoutClicked"), for: .normal)
      print("??? UserDefaultsSetting.mainPet \(UserDefaultsSetting.mainPet)")
      switch UserDefaultsSetting.mainPet {
      case "dog":
        homeInButton.setImage(UIImage(named: "homeinClicked"), for: .normal)
        break
      case "cat":
        homeInButton.setImage(UIImage(named: "homein3"), for: .normal)
        break
      case "parrot":
        homeInButton.setImage(UIImage(named: "homein4"), for: .normal)
        break
      case "rabbit":
        homeInButton.setImage(UIImage(named: "homein2"), for: .normal)
        break
      default:
        break
      }
      
      print("??? 11")
      guard let start = UserDefaults.standard.object(forKey: "sceneDidEnterBackground") as? Date else { return }
      print("??? 22")
      let interval = Double(Date().timeIntervalSince(start))
      print("??? 33")
      NotificationCenter.default.post(name: NSNotification.Name("sceneWillEnterForeground"), object: nil, userInfo: ["time" : interval])
      
    } else if UserDefaultsSetting.mainType == "leave" { // 퇴근상태
      
      switch UserDefaultsSetting.mainPet {
      case "dog":
        homeOutButton.setImage(UIImage(named: "homeoutClicked"),
                               for: .normal)
        break
      case "cat":
        homeOutButton.setImage(UIImage(named: "homeout3"),
                               for: .normal)
        break
      case "parrot":
        homeOutButton.setImage(UIImage(named: "homeout4"),
                               for: .normal)
        break
      case "rabbit":
        homeOutButton.setImage(UIImage(named: "homeout2"),
                               for: .normal)
        break
      default:
        break
      }
      guard let start = UserDefaults.standard.object(forKey: "sceneDidEnterBackground") as? Date else { return }
      let interval = Double(Date().timeIntervalSince(start))
      NotificationCenter.default.post(name: NSNotification.Name("sceneWillEnterForeground"), object: nil, userInfo: ["time" : interval])
    }
    
    // 이거 나중에 지워~
    UserDefaults.standard.setValue(Date(), forKey: "sceneDidEnterBackground")
    self.homeInButton.setImage(UIImage(named: "homeinUnClicked"), for: .normal)
    self.homeOutButton.setImage(UIImage(named: "homeoutUnClicked"),
                                for: .normal)
    self.counter = 0.0
    self.timer.invalidate()
    //
  }
  
  
  override func setupView() {
    
    view.backgroundColor = .clear
    [titleLabel, dateLabel, popupButton, clockImageView,animalTimeImageView, humanTimeImageView,
     carrotNumber, inClockAnimalImageView, inClockTitleLabel, inClockHumanTimeLabel,
     inClockAnimalTimeLabel, homeOutButton, homeInButton].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  override func setLayout() {
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    NSLayoutConstraint.activate([
      dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.adjusted),
      dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    NSLayoutConstraint.activate([
      popupButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
      popupButton.widthAnchor.constraint(equalToConstant: 24.adjusted),
      popupButton.heightAnchor.constraint(equalToConstant: 24.adjusted),
      popupButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 6.adjusted)
    ])
    
    NSLayoutConstraint.activate([
      animalTimeImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 19.adjusted),
      animalTimeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      animalTimeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      animalTimeImageView.bottomAnchor.constraint(equalTo: homeOutButton.topAnchor, constant: -24.adjusted)
    ])
    
    NSLayoutConstraint.activate([
      humanTimeImageView.topAnchor.constraint(equalTo: animalTimeImageView.topAnchor, constant: 15.adjusted),
      humanTimeImageView.leadingAnchor.constraint(equalTo: animalTimeImageView.leadingAnchor, constant: 15.adjusted),
      humanTimeImageView.trailingAnchor.constraint(equalTo: animalTimeImageView.trailingAnchor, constant: -15.adjusted),
      humanTimeImageView.bottomAnchor.constraint(equalTo: animalTimeImageView.bottomAnchor, constant: -15.adjusted)
    ])
    
    NSLayoutConstraint.activate([
      clockImageView.topAnchor.constraint(equalTo: animalTimeImageView.topAnchor, constant: 19.adjusted),
      clockImageView.leadingAnchor.constraint(equalTo: animalTimeImageView.leadingAnchor, constant: 19.adjusted),
      clockImageView.trailingAnchor.constraint(equalTo: animalTimeImageView.trailingAnchor, constant: -19.adjusted),
      clockImageView.bottomAnchor.constraint(equalTo: animalTimeImageView.bottomAnchor, constant: -19.adjusted)
    ])
    
    NSLayoutConstraint.activate([
      carrotNumber.topAnchor.constraint(equalTo: animalTimeImageView.topAnchor, constant: 65.adjusted),
      carrotNumber.centerXAnchor.constraint(equalTo: animalTimeImageView
        .centerXAnchor)
    ])
    
    NSLayoutConstraint.activate([
      inClockAnimalImageView.topAnchor.constraint(equalTo: carrotNumber.bottomAnchor, constant: 2),
      inClockAnimalImageView.centerXAnchor.constraint(equalTo: carrotNumber.centerXAnchor),
      inClockAnimalImageView.heightAnchor.constraint(equalToConstant: 60.adjusted),
      inClockAnimalImageView.widthAnchor.constraint(equalToConstant: 80.adjusted),
    ])
    
    NSLayoutConstraint.activate([
      inClockTitleLabel.topAnchor.constraint(equalTo: inClockAnimalImageView.bottomAnchor, constant: 2),
      inClockTitleLabel.centerXAnchor.constraint(equalTo: clockImageView.centerXAnchor)
    ])
    
    NSLayoutConstraint.activate([
      inClockAnimalTimeLabel.topAnchor.constraint(equalTo: inClockTitleLabel.bottomAnchor,constant: 2.adjusted),
      inClockAnimalTimeLabel.centerXAnchor.constraint(equalTo: clockImageView.centerXAnchor)
    ])
    
    NSLayoutConstraint.activate([
      inClockHumanTimeLabel.topAnchor.constraint(equalTo: inClockAnimalTimeLabel.bottomAnchor, constant: 8.adjusted),
      inClockHumanTimeLabel.centerXAnchor.constraint(equalTo: clockImageView.centerXAnchor)
    ])
    
    NSLayoutConstraint.activate([
      homeOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                            constant: -30.adjusted),
      homeOutButton.leadingAnchor.constraint(equalTo: clockImageView.leadingAnchor, constant: 14.adjusted),
      homeOutButton.widthAnchor.constraint(equalToConstant: 76.adjusted),
      homeOutButton.heightAnchor.constraint(equalToConstant: 76.adjusted)
    ])
    NSLayoutConstraint.activate([
      homeInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                           constant: -30.adjusted),
      homeInButton.trailingAnchor.constraint(equalTo: clockImageView.trailingAnchor, constant: -14.adjusted),
      homeInButton.widthAnchor.constraint(equalToConstant: 76.adjusted),
      homeInButton.heightAnchor.constraint(equalToConstant: 76.adjusted)
    ])
  }
  
}
