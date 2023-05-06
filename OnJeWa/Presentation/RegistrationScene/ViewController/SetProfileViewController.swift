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
        view.backgroundColor = .white
        
        setProfileView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.shadowImage = UIImage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardUp(notification:NSNotification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
           let keyboardRectangle = keyboardFrame.cgRectValue
       
            UIView.animate(
                withDuration: 0.3
                , animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height)
//                    self.view.transform = CGAffineTransform(translationX: 0, y: -100)
                }
            )
        }
    }
    
    @objc func keyboardDown() {
        self.view.transform = .identity
    }
    
    //MARK: - Views
    
    private let pageControl = OnJeWaPageControl(frame: CGRect.zero, entirePage: 4, currentPage: 2)
    private let setProfileView = SetProfileView()
    
    //MARK: - Functions
    
    override func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: pageControl)
        
        [setProfileView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        setProfileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setProfileView.topAnchor.constraint(equalTo: view.topAnchor),
            setProfileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            setProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            setProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func bindViewModel() {
        setProfileView.yearDropDown.rx.didSelectDropDown
            .bind { [weak self] yearValue in
                guard let yearValue else { return }
                print("yearDropDown \(yearValue)")
                self?.viewModel.input.yearTrigger.onNext(yearValue == "나이" ? "" : yearValue)
            }
            .disposed(by: disposeBag)
        
        setProfileView.monthDropDown.rx.didSelectDropDown
            .bind { [weak self] monthValue in
                guard let monthValue else { return }
                print("monthValue \(monthValue)")
                self?.viewModel.input.monthTrigger.onNext(monthValue == "월" ? "" : monthValue)
            }
            .disposed(by: disposeBag)
        
        setProfileView.dayDropDown.rx.didSelectDropDown
            .bind { [weak self] dayValue in
                guard let dayValue else { return }
                print("dayValue \(dayValue)")
                self?.viewModel.input.dayTrigger.onNext(dayValue == "일" ? "" : dayValue)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.nextButtonStatus
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .drive { [weak self] isEnabled in
                print("nextButtonStatus \(isEnabled)")
                self?.setProfileView.setupNextButton(flag: isEnabled)
            }
            .disposed(by: disposeBag)
    }
}

extension SetProfileViewController: SetProfileViewDelegate {
    func didTapNextButton() {
        print("didTapNextButton")
    }
    
    func didSetProfileImageView() {
        print("didSetProfileImageView")
        self.viewModel.input.profileImageTrigger.onNext(true)
    }
    
    func changedTextField(nameValue: String) {
        print("changedTextField \(nameValue)")
        self.viewModel.input.nameTrigger.onNext(nameValue)
    }
}
