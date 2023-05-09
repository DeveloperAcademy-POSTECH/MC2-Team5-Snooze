//
//  SecondRegistrationViewController.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/05.
//

import UIKit

import OnJeWaCore
import OnJeWaUI

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBarAppearance()
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
        
        setProfileView.yearDropDown.rx.didSelectDropDown
            .bind { [weak self] yearValue in
                guard let yearValue else { return }
                self?.viewModel.input.yearTrigger.onNext(yearValue == "나이" ? "" : yearValue)
                self?.profile?.year = yearValue == "나이" ? "" : yearValue
            }
            .disposed(by: disposeBag)
        
        setProfileView.monthDropDown.rx.didSelectDropDown
            .bind { [weak self] monthValue in
                guard let monthValue else { return }
                self?.viewModel.input.monthTrigger.onNext(monthValue == "월" ? "" : monthValue)
                self?.profile?.month = monthValue == "월" ? "" : monthValue
            }
            .disposed(by: disposeBag)
        
        setProfileView.dayDropDown.rx.didSelectDropDown
            .bind { [weak self] dayValue in
                guard let dayValue else { return }
                self?.viewModel.input.dayTrigger.onNext(dayValue == "일" ? "" : dayValue)
                self?.profile?.day = dayValue == "일" ? "" : dayValue
            }
            .disposed(by: disposeBag)
        
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
        let setBackgroundViewController = SetBackgroundViewController(profile: profile)
        self.navigationController?.pushViewController(setBackgroundViewController, animated: true)
    }
    
    func didSetProfileImageView(image: UIImage) {
        self.profile?.profileImage = image
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
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardRectangle = keyboardFrame.cgRectValue
        
        UIView.animate(withDuration: 0.3) {
            self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height)
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.view.transform = .identity
        }
    }
}
