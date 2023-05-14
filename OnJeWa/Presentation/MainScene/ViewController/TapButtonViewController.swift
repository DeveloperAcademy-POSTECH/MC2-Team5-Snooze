//
//  TapButtonViewController.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/09.
//

import UIKit
import OnJeWaUI
import OnJeWaCore
import Gifu

protocol TapButtonViewDelegate: AnyObject {
  func didTapButton(value: String)
}

class TapButtonViewController: BaseViewController {
  
  // 델리게이트는 무조건 weak var
  weak var delegate: TapButtonViewDelegate?
  //타이머
  var timer: Timer?
  //현재 시간
  var counter = 0.0
  
  
  //MARK: - UI Components
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "막둥이의 하루"
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
    imageView.image = UIImage(named: "watch")
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let animalTimeImageView: UIImageView = {
    let imageView = UIImageView()
    switch UserDefaultsSetting.mainPet {
    case "dog":
      imageView.image = UIImage(named: "animaltime")
      break
    case "cat":
      imageView.image = UIImage(named: "animaltime3")
      break
    case "parrot":
      imageView.image = UIImage(named: "animaltime4")
      break
    case "rabbit":
      imageView.image = UIImage(named: "animaltime2")
      break
    default:
      break
    }
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let humanTimeImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "persontime")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  // 애니메이션 시작
  //  func startAnimation() {
  //    rotateView(view: animalTimeImageView)
  //    rotateView(view: humanTimeImageView)
  //  }
  
  // 컴포넌트 회전 애니메이션
  //  func rotateView(view: UIView) {
  //    UIView.animate(withDuration: 1.0, animations: {
  //      view.transform = view.transform.rotated(by: CGFloat.pi / 36.0) // 5도씩 회전 (180도를 36으로 나눔)
  //    }) { (_) in
  //      self.rotateView(view: view) // 애니메이션 재귀 호출
  //    }
  //  }
  
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
  
  private let inClockTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "막둥이가 나를 기다린지"
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
  
  private let inClockHumanTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "00:00:00"
    label.font = UIFont.systemFont(ofSize: 14)
    return label
  }()
  
  
  lazy var homeOutButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "homeoutUnClicked"), for: .normal)
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
  
  let tapPositionImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "leftlight"))
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private var previousButton: UIButton?
  
  @objc private func homeOutButtonTapped(_ sender: UIButton) {
    delegate?.didTapButton(value: "out")
    timer?.invalidate()
    timer = nil
    counter = 0.0
    
    timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    
  }
  
  @objc func updateTimer() {
    counter += 0.1
    let flooredCounter = Int(floor(counter))
    let humanHour = flooredCounter / 3600
    let minute = (flooredCounter % 3600) / 60
    let second = (flooredCounter % 3600) % 60
    let humanTimeString = String(format: "%02d:%02d:%02d", humanHour, minute, second)
    inClockHumanTimeLabel.text = humanTimeString
    
    let animalHour = humanHour + 4
    let animalTimeString = String(format: "%02d:%02d:%02d", animalHour, minute, second)
    inClockAnimalTimeLabel.text = animalTimeString
    
    UserDefaults.shared.set(minute, forKey: "animalHour")
  }
  
  @objc private func homeInButtonTapped(_ sender: UIButton) {
    delegate?.didTapButton(value: "in")
    timer?.invalidate()
    timer = nil
    counter = 0.0
    
    timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
  }
  
  override func setupView() {
    
    view.backgroundColor = .clear
    [titleLabel, dateLabel, popupButton, clockImageView,animalTimeImageView, humanTimeImageView,
     carrotNumber, inClockAnimalImageView, inClockTitleLabel, inClockHumanTimeLabel,
     inClockAnimalTimeLabel, homeOutButton, tapPositionImageView, homeInButton].forEach {
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
      clockImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 19.adjusted),
      clockImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      clockImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      clockImageView.bottomAnchor.constraint(equalTo: homeOutButton.topAnchor, constant: -24.adjusted)
    ])
    
    NSLayoutConstraint.activate([
      animalTimeImageView.topAnchor.constraint(equalTo: clockImageView.topAnchor, constant: 26
        .adjusted),
      animalTimeImageView.leadingAnchor.constraint(equalTo: clockImageView.leadingAnchor, constant: 5.adjusted),
      animalTimeImageView.trailingAnchor.constraint(equalTo: clockImageView.trailingAnchor),
      animalTimeImageView.heightAnchor.constraint(equalToConstant: 155.adjusted)
    ])
    
    NSLayoutConstraint.activate([
      humanTimeImageView.topAnchor.constraint(equalTo: clockImageView.topAnchor, constant: 44.adjusted),
      humanTimeImageView.leadingAnchor.constraint(equalTo: clockImageView.centerXAnchor),
      humanTimeImageView.widthAnchor.constraint(equalToConstant: 140.adjusted),
      humanTimeImageView.heightAnchor.constraint(equalToConstant: 140.adjusted)
    ])
    
    NSLayoutConstraint.activate([
      carrotNumber.topAnchor.constraint(equalTo: clockImageView.topAnchor, constant: 85.adjusted),
      carrotNumber.centerXAnchor.constraint(equalTo: clockImageView.centerXAnchor)
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
      homeOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      homeOutButton.leadingAnchor.constraint(equalTo: clockImageView.leadingAnchor, constant: 14.adjusted),
      homeOutButton.widthAnchor.constraint(equalToConstant: 76.adjusted),
      homeOutButton.heightAnchor.constraint(equalToConstant: 76.adjusted)
    ])
    NSLayoutConstraint.activate([
      tapPositionImageView.centerYAnchor.constraint(equalTo: homeOutButton.centerYAnchor),
      tapPositionImageView.leadingAnchor.constraint(equalTo: homeOutButton.trailingAnchor, constant: 48.adjusted),
      tapPositionImageView.widthAnchor.constraint(equalToConstant: 24.adjusted)
    ])
    NSLayoutConstraint.activate([
      homeInButton.bottomAnchor.constraint(equalTo: homeOutButton.bottomAnchor),
      homeInButton.leadingAnchor.constraint(equalTo: tapPositionImageView.trailingAnchor, constant: 48.adjusted),
      homeInButton.widthAnchor.constraint(equalToConstant: 76.adjusted),
      homeInButton.heightAnchor.constraint(equalToConstant: 76.adjusted)
    ])
  }
  
}

