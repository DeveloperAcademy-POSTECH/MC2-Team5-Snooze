//
//  ViewController.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/04/25.
//

import UIKit
import CoreLocation
import UserNotifications

// 이거 iOS 13 이후부터는 항상 불가능 -> 백그라운드에서 계속 세팅하다보면 팝업이 하나 더뜸 (https://sosoingkr.tistory.com/113)
// + 온보딩에 설정 -> 항상으로 세팅하라는 안내 필요할지도
// 권한도 위에 블로그 적힌 부분 3개면 될듯
// 백그라운드 모드도 위에 블로그 보고 세팅
// 앱델리게이트는 전부 다 들어가야할듯 코드 -> 종권좌 블로그 확인

// 앱 메인에서 세팅하는 코드 들어가야할듯

class TestViewController: UIViewController, CLLocationManagerDelegate {
  
  let locationManager = CLLocationManager()
  //타이머
  var timer: Timer?
  //현재 시간
  var counter = 0.0
  
  private let testLabel : UILabel = {
    let label = UILabel()
    label.text = "00:00"
    label.textColor = .blue
    label.textAlignment = .center
    return label
  }()
  
  private let testButton: UIButton = {
    let button = UIButton()
    button.setTitle("button", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(timerHandler), for: .touchUpInside)
    return button
  }()
  
  @objc func timerHandler() {
    if timer == nil {
      //타이머가 nil인 경우, 타이머를 생성하고 시작
      timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    
    } else {
      // 타이머가 nil이 아닌 경우, 타이머를 중지
      timer?.invalidate()
      timer = nil
    }
  }
  
  @objc func updateTimer() {
    counter += 0.1
    let flooredCounter = Int(floor(counter))
    let minute = flooredCounter / 60
    let second = flooredCounter % 60
    testLabel.text = String(format: "%02d:%02d.0", minute, second)
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    [testLabel, testButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    NSLayoutConstraint.activate([testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                 testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    NSLayoutConstraint.activate([testButton.topAnchor.constraint(equalTo: testLabel.bottomAnchor, constant: 50),
                                 testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                 testButton.heightAnchor.constraint(equalToConstant: 100),
                                 testButton.widthAnchor.constraint(equalToConstant: 100)])
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
  
      //standard에 값 저장
    UserDefaults.shared.set(counter, forKey: "timerValue")
    

  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways {
      // 범위를 설정하는 기준좌표 -> 예를 들어 우리 앱에서는 집 혹은 회사
      let center = CLLocationCoordinate2D(latitude: 36.0167547, longitude: 129.3227777)
      
      // 2km의 원형 영역
      let region = CLCircularRegion(center: center, radius: 2000.0, identifier: "Geofence")
      
      region.notifyOnEntry = true
      region.notifyOnExit = true
      
      locationManager.startMonitoring(for: region)
    }
  }
  
  // 지정한 지역에 들어왔을 때 수행할 작업
  func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    print("사용자가 지정한 지역에 들어왔습니다.")
    
    let content = UNMutableNotificationContent()
    content.title = "지역 모니터링"
    content.body = "지정한 지역에 들어왔습니다."
    content.sound = .default
    
    let request = UNNotificationRequest(identifier: "Geofence", content: content, trigger: nil)
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
  }
  
  // 지정한 지역을 벗어났을 때 수행할 작업
  func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
    print("사용자가 지정한 지역을 벗어났습니다.")
    
    let content = UNMutableNotificationContent()
    content.title = "지역 모니터링"
    content.body = "지정한 지역을 벗어났습니다."
    content.sound = .default
    
    let request = UNNotificationRequest(identifier: "Geofence", content: content, trigger: nil)
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
  }
}



