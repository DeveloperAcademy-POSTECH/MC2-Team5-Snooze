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
    func didSetProfileImageView()
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
        let attributedString = NSMutableAttributedString(string: "스누즈 프로필을\n설정 해 주세요")
        let range = (attributedString.string as NSString).range(of: "스누즈 프로필")
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
        imageView.backgroundColor = .blue
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let photoIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "camera.circle")
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
    
    var yearDropDown: DropDown = {
        let dropdown = DropDown(data: ["나이","1","2","3","4","5","6","7","8","9","10"], contentHeight: 150)
        return dropdown
    }()
    
    var monthDropDown: DropDown = {
        let dropdown = DropDown(data: ["월", "1","2","3","4","5","6","7","8","9","10"], contentHeight: 150)
        return dropdown
    }()
    
    var dayDropDown: DropDown = {
        let dropdown = DropDown(data: ["일", "1","2","3","4","5","6","7","8","9","10"], contentHeight: 150)
        return dropdown
    }()
    
    // 수정 : cornerRadius
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 20
        return button
    }()
    
    //MARK: - Functions
    
    func setupNextButton(flag: Bool) {
        if flag {
            nextButton.backgroundColor = .systemPink
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        profileImageView.image = image
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.clipsToBounds = true
        delegate?.didSetProfileImageView()
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 현재 입력된 텍스트와 변경된 텍스트를 합칩니다.
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // 변경된 텍스트를 콘솔에 출력합니다.
        if newText.isEmpty {
            print("isEmpty \(newText)")
            delegate?.changedTextField(nameValue: newText)
        } else {
            print("not isEmpty \(newText)")
            delegate?.changedTextField(nameValue: newText)
        }
        
        // true를 반환하여 텍스트 필드가 변경된 텍스트를 반영하도록 합니다.
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("clear")
        delegate?.changedTextField(nameValue: "")
        return true
    }
}

private extension SetProfileView {
    func setupView() {
        [yearDropDown, monthDropDown, dayDropDown].forEach {
            dropDownStackView.addArrangedSubview($0)
        }
        
        [setProfileTitle, profileImageView, photoIcon, findTownTextField, dropDownStackView, nextButton].forEach {
            backgroundView.addSubview($0)
        }
        
        addSubview(backgroundView)
        
        findTownTextField.delegate = self
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        
        findTownTextField.placeholder = "이름"
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            setProfileTitle.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                                 constant: UIScreen.main.bounds.size.height / 6),
            setProfileTitle.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                     constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: setProfileTitle.bottomAnchor, constant: 32),
            profileImageView.widthAnchor.constraint(equalToConstant: 125),
            profileImageView.heightAnchor.constraint(equalToConstant: 125),
        ])
        
        NSLayoutConstraint.activate([
            photoIcon.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor,constant: 40),
            photoIcon.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -32),
            photoIcon.widthAnchor.constraint(equalToConstant: 40),
            photoIcon.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            findTownTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 48),
            findTownTextField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            findTownTextField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16)
        ])
        
        yearDropDown.widthAnchor.constraint(equalTo: dropDownStackView.widthAnchor, multiplier: 1.8/4).isActive = true
        monthDropDown.widthAnchor.constraint(equalTo: dropDownStackView.widthAnchor, multiplier: 1/4).isActive = true
        dayDropDown.widthAnchor.constraint(equalTo: dropDownStackView.widthAnchor, multiplier: 1/4).isActive = true
        
        NSLayoutConstraint.activate([
            dropDownStackView.topAnchor.constraint(equalTo: findTownTextField.bottomAnchor, constant: 12),
            dropDownStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            dropDownStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            // 수정 : 버튼 height
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            nextButton.bottomAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.bottomAnchor,
                                               constant: -20),
            nextButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                 constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
