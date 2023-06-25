//
//  SecondRegistrationViewController.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/05.
//

import UIKit

import OnJeWaCore
import OnJeWaUI
import OnJeWaNetwork

final class SetProfileViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var profile: Profile?
    private let viewModel = SetProfileViewModel()
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    configureNavigationBar()
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unregisterKeyboardNotifications()
    }
    
    //MARK: - Views
    
    private let pageControl = OnJeWaPageControl(frame: CGRect.zero, entirePage: 4, currentPage: 2)
    private let setProfileView = SetProfileView()
    
    //MARK: - Functions
    
    override func setupView() {
        
        setProfileView.delegate = self
        
        pageControl.pageControlStackView.subviews[1].backgroundColor =
        hexStringToUIColor(hex: UserDefaultsSetting.mainColor)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: pageControl)
        
        [setProfileView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        NSLayoutConstraint.activate([
            setProfileView.topAnchor.constraint(equalTo: view.topAnchor),
            setProfileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            setProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            setProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func bindViewModel() {
        
        // Input
        
        viewModel.input.profileImageTrigger.onNext(true)
        self.profile?.profileImage = UIImage(named: "setBackgroundImage")?.jpegData(compressionQuality: 0.5)
        
        // Output
        
        viewModel.output.nextButtonStatus
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .drive { [weak self] isEnabled in
                self?.setProfileView.setupNextButton(flag: isEnabled)
            }
            .disposed(by: disposeBag)
    }
}

extension SetProfileViewController: SetProfileViewDelegate {
    func didTapNextButton() {
        guard let profile else { return }
        view.endEditing(true)
        let setBackgroundViewController = SetBackgroundViewController(profile: profile)
        self.navigationController?.pushViewController(setBackgroundViewController, animated: true)
    }
    
    func didSetProfileImageView(image: UIImage) {
        self.profile?.profileImage = image.jpegData(compressionQuality: 0.5)
        self.viewModel.input.profileImageTrigger.onNext(true)
    }
    
    func changedTextField(nameValue: String) {
        self.viewModel.input.nameTrigger.onNext(nameValue)
        self.profile?.name = nameValue
    }
}

extension SetProfileViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
  
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardRectangle = keyboardFrame.cgRectValue
        
        UIView.animate(withDuration: 0.3) {
            self.view.transform = CGAffineTransform(translationX: 0, y: -300)
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.view.transform = .identity
        }
    }
}
