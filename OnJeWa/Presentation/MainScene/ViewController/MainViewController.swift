//
//  MainViewController.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/04.
//

import UIKit
import OnJeWaCore
import OnJeWaUI
import OnJeWaNetwork
import CoreLocation
import WidgetKit

class MainViewController: BaseViewController, CLLocationManagerDelegate {
  
  //MARK: - Properties
  
  let viewModel = MainViewModel()
  let locationManager = CLLocationManager()
  
  //MARK: - View Components
  
  private let backgroundView = BackgroundView()
  private let navigationView = NavigationView()
  private let tapButtonVC = TapButtonViewController()
  
  
  //MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let popupVC = CustomPopupViewController()
    popupVC.modalPresentationStyle = .overFullScreen
    self.present(popupVC, animated: false)
    
    UNUserNotificationCenter.current().requestAuthorization(
      options: [.alert, .badge, .sound]
    ) {
      success, error in
    }
    
    locationManager.requestAlwaysAuthorization()
    locationManager.allowsBackgroundLocationUpdates = true
    
    // 위치 서비스 정확도 설정
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.delegate = self
    
    // 위치 서비스 업데이트 시작
    locationManager.startUpdatingLocation()
    
    tapButtonVC.delegate = self
    navigationView.delegate = self
  
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let currentLocation = locations.last else { return }
   
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways {
      
      // C5 좌표
      let center = CLLocationCoordinate2D(latitude: 36.01438502747284, longitude: 129.32562437615857)
      
      // 100m의 원형 영역
      let region = CLCircularRegion(center: center, radius: 75.0, identifier: "Geofence")
      
      region.notifyOnEntry = true
      region.notifyOnExit = true
      
      locationManager.startMonitoring(for: region)
    }
  }
  
  // 지정한 지역에 들어왔을 때 수행할 작업
  
  func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    print("사용자가 지정한 지역에 들어왔습니다.")
    
    let content = UNMutableNotificationContent()
    content.title = "집에 들어오셨군요!"
    content.body = "들어오기를 눌러주세요!"
    content.sound = .default
    
    let request = UNNotificationRequest(identifier: "Geofence", content: content, trigger: nil)
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
  }
  
  // 지정한 지역을 벗어났을 때 수행할 작업
  
  func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
    print("사용자가 지정한 지역을 벗어났습니다.")
    
    let content = UNMutableNotificationContent()
    content.title = "집을 나오셨군요!"
    content.body = "외출하기를 눌러주세요!"
    content.sound = .default
    
    let request = UNNotificationRequest(identifier: "Geofence", content: content, trigger: nil)
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  override func bindViewModel() {
    
    self.viewModel.output.outResult
      .bind { [weak self] value in
        if value  {
          
          self?.tapButtonVC.homeOutButton.setImage(UIImage(named: "homeoutUnClicked"),
                                                   for: .normal)
          
        } else {
          if UserDefaultsSetting.mainType != "work" {
            switch UserDefaultsSetting.mainPet {
            case "dog":
              self?.tapButtonVC.homeOutButton.setImage(UIImage(named: "homeoutClicked"),
                                                       for: .normal)
              break
            case "cat":
              self?.tapButtonVC.homeOutButton.setImage(UIImage(named: "homeout3"),
                                                       for: .normal)
              break
            case "parrot":
              self?.tapButtonVC.homeOutButton.setImage(UIImage(named: "homeout4"),
                                                       for: .normal)
              break
            case "rabbit":
              self?.tapButtonVC.homeOutButton.setImage(UIImage(named: "homeout2"),
                                                       for: .normal)
              break
            default:
              break
            }
          }
          
        }
      }
      .disposed(by: disposeBag)
    
    self.viewModel.output.inResult
      .bind {[weak self] value in
        if value {
          
          self?.tapButtonVC.homeInButton.setImage(UIImage(named: "homeinUnClicked"), for: .normal)
          
        }else {
          if UserDefaultsSetting.mainType != "leave" {
            switch UserDefaultsSetting.mainPet {
            case "dog":
              self?.tapButtonVC.homeInButton.setImage(UIImage(named: "homeinClicked"), for: .normal)
              break
            case "cat":
              self?.tapButtonVC.homeInButton.setImage(UIImage(named: "homein3"), for: .normal)
              break
            case "parrot":
              self?.tapButtonVC.homeInButton.setImage(UIImage(named: "homein4"), for: .normal)
              break
            case "rabbit":
              self?.tapButtonVC.homeInButton.setImage(UIImage(named: "homein2"), for: .normal)
              break
            default:
              break
            }
          }
        }
      }
      .disposed(by: disposeBag)
  }
  
  override func setupView() {
    view.backgroundColor = .white
    [navigationView, tapButtonVC.view].forEach {
      backgroundView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(backgroundView)
    
    navigationView.profileButton.setImage(UIImage(data: viewModel.userUseCase.readProfileImage()), for: .normal)
    backgroundView.backgroundImageView.image = UIImage(data: viewModel.userUseCase.readBackgroundImage())
  }
  
  override func setLayout() {
    NSLayoutConstraint.activate([
      backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
      backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([
      navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4.adjusted),
      navigationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 38.adjusted),
      navigationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -38.adjusted),
      navigationView.heightAnchor.constraint(equalToConstant: 29.adjusted)
    ])
    
    NSLayoutConstraint.activate([
      tapButtonVC.view.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 63.adjusted),
      tapButtonVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200.adjusted),
      tapButtonVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 45.adjusted),
      tapButtonVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -39.adjusted),
    ])
  }
}

extension MainViewController: TapButtonViewDelegate {
  func didTapButton(value: String) {
    if value == "in" {
      let sheet = UIAlertController(title: "집에 돌아오셨나요?", message: "나의 반려동물과\n 즐거운 시간을 보내세요!", preferredStyle: .alert)
      sheet.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { _ in
        self.tapButtonVC.homeInButtonTappedDemo()
        self.viewModel.input.inTrigger.onNext(true)
        self.viewModel.input.outTrigger.onNext(false)
      }))
      
      sheet.addAction(UIAlertAction(title: "취소", style: .cancel))
      present(sheet, animated: true)
      
    } else {
      // Out
      let sheet = UIAlertController(title: "밖으로 외출하시나요?", message: "반려동물이 집에서 기다리고\n 있으니 빨리 다녀오세요!", preferredStyle: .alert)
      sheet.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { _ in
        self.tapButtonVC.homeOutButtonTappedDemo()
        self.viewModel.input.outTrigger.onNext(true)
        self.viewModel.input.inTrigger.onNext(false)
        
      }))
      
      sheet.addAction(UIAlertAction(title: "취소", style: .cancel))
      present(sheet, animated: true)
    }
  }
}

extension MainViewController: NavigationViewDelegate {
  
  func didTapProfile() {
    let settingViewController = SettingViewController()
    self.navigationController?.pushViewController(settingViewController, animated: true)
  }
  
}
