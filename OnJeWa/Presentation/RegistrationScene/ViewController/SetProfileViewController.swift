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
	var updateChk = false
	
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
		
		if updateChk {
			setProfileView.nextButton.setTitle("변경하기", for: .normal)
			setProfileView.profileImageView.image = UIImage(data: (profile?.profileImage)!)
			setProfileView.onJeWaTextField.placeholder = profile?.name!
		} else {
			setProfileView.nextButton.setTitle("다음", for: .normal)
			navigationItem.rightBarButtonItem = UIBarButtonItem(customView: pageControl)
		}
		
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
		
		if !updateChk {
			self.profile?.profileImage = UIImage(named: "setBackgroundImage")?.jpegData(compressionQuality: 0.5)
		}
		
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
		if updateChk {
			let alert = UIAlertController(title: "알림", message: "프로필을 변경하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
			let defaultAction =  UIAlertAction(title: "변경하기", style: UIAlertAction.Style.default) { _ in
				do {
					try RealmManager.shared.createProfile(profile: self.profile!) {
						if let homeVC = self.navigationController?.viewControllers.first as? MainViewController {
							homeVC.navigationView.profileButton.setImage(UIImage(data: RealmManager.shared.readProfileImage()), for: .normal)
						}
						self.navigationController?.popToRootViewController(animated: true)
					}
				} catch _ {
					print("error")
				}
			}
			let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.destructive, handler: nil)
			
			alert.addAction(defaultAction)
			alert.addAction(cancelAction)
			
			self.present(alert, animated: false)
		} else {
			guard let profile else { return }
			view.endEditing(true)
			let setBackgroundViewController = SetBackgroundViewController(profile: profile)
			self.navigationController?.pushViewController(setBackgroundViewController, animated: true)
		}
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
