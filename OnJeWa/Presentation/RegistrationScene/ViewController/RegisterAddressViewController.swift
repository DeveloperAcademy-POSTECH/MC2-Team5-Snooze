//
//  RegisterAddressViewController.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/08.
//

import UIKit
import CoreLocation

import OnJeWaCore
import OnJeWaUI

// 웹뷰로 부터 주소 데이터를 받아옴
protocol LocationAndYearsDelegate: AnyObject {
    func dismissKakaoAddressWebView(address: String, coordinates: CLLocationCoordinate2D)
}

final class RegisterAddressViewController: BaseViewController {
    
    //MARK: - Properteis
    
    private let kakaoAddressUrlString = "https://ungchun.github.io/Kakao-Postcode/"
    private var profile: Profile?
    
    //MARK: - Life Cycle
    
    init(profile: Profile) {
        super.init(nibName: nil, bundle: nil)
        self.profile = profile
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        registerAddressView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.shadowImage = UIImage()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
    
    //MARK: - Views
    
    private let pageControl = OnJeWaPageControl(frame: CGRect.zero, entirePage: 4, currentPage: 4)
    private let registerAddressView = RegisterAddressView()
    
    //MARK: - Functions
    
    override func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: pageControl)
        
        [registerAddressView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        registerAddressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerAddressView.topAnchor.constraint(equalTo: view.topAnchor),
            registerAddressView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            registerAddressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerAddressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension RegisterAddressViewController: RegisterAddressViewDelegate {
    func didTapNextButton() {
        print("didTapNextButton")
    }
    
    func didSetAddress() {
        print("didSetAddress")
        let kakaoAddress = KakaoAddressViewController(webViewTitle: "카카오",
                                                      url: self.kakaoAddressUrlString,
                                                      callBackKey: "callBackHandler")
        kakaoAddress.delegate = self
        self.present(kakaoAddress, animated: true)
    }
}

extension RegisterAddressViewController: LocationAndYearsDelegate {
    func dismissKakaoAddressWebView(address: String, coordinates:  CLLocationCoordinate2D) {
        // function으로 빼기
        print("coordinates \(coordinates)")
        registerAddressView.addressStackView.isHidden = false
        registerAddressView.addressTitle.text = address
        registerAddressView.nextButton.setTitle("제리와 함께 행복한 시간을 즐겨봐요", for: .normal)
    }
}
