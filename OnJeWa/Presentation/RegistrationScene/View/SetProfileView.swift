//
//  SecondRegistrationView.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/05.
//

import UIKit

import OnJeWaCore
import OnJeWaUI

protocol SetProfileViewDelegate: AnyObject {
    func didTapNextButton()
    func didSetProfileImageView(image: UIImage)
    func changedTextField(nameValue: String)
}

final class SetProfileView: BaseView {
    
    //MARK: - Properties
    
    private let imagePickerController = UIImagePickerController()
    weak var delegate: SetProfileViewDelegate?
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Views
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let setProfileTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "snooze 프로필을\n설정 해 주세요")
        let range = (attributedString.string as NSString).range(of: "snooze 프로필")
        let font = UIFont.systemFont(ofSize: 32, weight: .bold)
        attributedString.addAttribute(.font, value: font, range: range)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle,
                                      range: NSRange(location: 0, length: attributedString.length))
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 125.0 / 2
        imageView.image = UIImage(named: "myimage")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let photoIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "propileplus")
        return imageView
    }()
    
    private let findTownTextField = OnJeWaTextField()
    
    private lazy var dropDownStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 14
        return button
    }()
    
    //MARK: - Functions
    
    func setupNextButton(flag: Bool) {
        if flag {
            nextButton.backgroundColor = hexStringToUIColor(hex: UserDefaultsSetting.mainColor)
            nextButton.addTarget(self, action: #selector(nextButtonTapGesture), for: .touchUpInside)
            nextButton.isUserInteractionEnabled = true
        } else {
            nextButton.backgroundColor = .systemGray6
            nextButton.isUserInteractionEnabled = false
        }
    }
    
    @objc func nextButtonTapGesture(_ sender: UITapGestureRecognizer) {
        delegate?.didTapNextButton()
    }
}

extension SetProfileView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        profileImageView.image = image
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.clipsToBounds = true
        delegate?.didSetProfileImageView(image: image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func profileImageViewTapped() {
        // UIViewController에서 present와 비슷한 기능으로 UIView에도 표시할 수 있도록 window에서 호출
        if let viewController = window?.rootViewController {
            viewController.present(imagePickerController, animated: true, completion: nil)
        }
    }
}

extension SetProfileView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if newText.isEmpty {
            delegate?.changedTextField(nameValue: newText)
        } else {
            delegate?.changedTextField(nameValue: newText)
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        delegate?.changedTextField(nameValue: "")
        return true
    }
}

private extension SetProfileView {
    func setupView() {
        
        findTownTextField.delegate = self
        findTownTextField.placeholder = "이름"
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(profileImageViewTapped))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        [setProfileTitle, profileImageView, photoIcon, findTownTextField,
         dropDownStackView, nextButton].forEach {
            backgroundView.addSubview($0)
        }
        
        addSubview(backgroundView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            setProfileTitle.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                                 constant: 136),
            setProfileTitle.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                     constant: 26),
        ])
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: setProfileTitle.bottomAnchor,
                                                  constant: 32),
            profileImageView.widthAnchor.constraint(equalToConstant: 125),
            profileImageView.heightAnchor.constraint(equalToConstant: 125),
        ])
        
        NSLayoutConstraint.activate([
            photoIcon.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor,
                                               constant: 40),
            photoIcon.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,
                                           constant: -32),
        ])
        
        NSLayoutConstraint.activate([
            findTownTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,
                                                   constant: 32),
            findTownTextField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                       constant: 20),
            findTownTextField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                        constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            dropDownStackView.topAnchor.constraint(equalTo: findTownTextField.bottomAnchor,
                                                   constant: 16),
            dropDownStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                       constant: 20),
            dropDownStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                        constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            nextButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor,
                                               constant: -54),
            nextButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                 constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
