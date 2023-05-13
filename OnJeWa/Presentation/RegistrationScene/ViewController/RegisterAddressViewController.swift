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
import OnJeWaNetwork

protocol KakaoAddressViewDelegate: AnyObject {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar()
    }
    
    //MARK: - Views
    
    private let pageControl = OnJeWaPageControl(frame: CGRect.zero, entirePage: 4, currentPage: 4)
    private let registerAddressView = RegisterAddressView()
    
    //MARK: - Functions
    
    private func configureNavigationBar() {
        self.navigationItem.hidesBackButton = true
        
        let backbutton = UIBarButtonItem(image: UIImage(named: "backbutton")?
            .withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: 4.0, bottom: 0.0, right: 0.0)),
                                         style: .done, target: self, action: #selector(back))
        backbutton.tintColor = .black
        self.navigationItem.leftBarButtonItem = backbutton
        
        navigationController?.navigationBar.shadowImage = UIImage()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func setupView() {
        
        registerAddressView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: pageControl)
        pageControl.pageControlStackView.subviews[3].backgroundColor =
        hexStringToUIColor(hex: UserDefaultsSetting.mainColor)
        
        [registerAddressView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
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
        do {
            try RealmManager.shared.createProfile(profile: self.profile!) {
                UserDefaultsSetting.isRegister = true
                UserDefaultsSetting.awayTime = 0
                
                let mainViewController = MainViewController()
                mainViewController.modalPresentationStyle = .fullScreen
                self.present(mainViewController, animated: true)
            }
        } catch let error {
            print("Failed to create profile: \(error)")
        }
    }
    
    func didSetAddress() {
        let kakaoAddress = KakaoAddressViewController(webViewTitle: "카카오",
                                                      url: self.kakaoAddressUrlString,
                                                      callBackKey: "callBackHandler")
        kakaoAddress.delegate = self
        self.present(kakaoAddress, animated: true)
    }
}

extension RegisterAddressViewController: KakaoAddressViewDelegate {
    func dismissKakaoAddressWebView(address: String, coordinates:  CLLocationCoordinate2D) {
        self.profile?.longitude = coordinates.longitude
        self.profile?.latitude = coordinates.latitude
        registerAddressView.updateRegisterAddressView(address: address)
    }
}
