//
//  SetBackgroundView.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/08.
//

import UIKit

import OnJeWaCore

protocol SetBackgroundViewDelegate: AnyObject {
    func didTapNextButton()
    func didSetBackgroundImageView(image: UIImage)
}

final class SetBackgroundView: BaseView {
    
    //MARK: - Properties
    
    private let imagePickerController = UIImagePickerController()
    weak var delegate: SetBackgroundViewDelegate?
    private var setBackgroundCheckFlag = false
    
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
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let backgroundOpaqueView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.isHidden = true
        return view
    }()
    
    private let setBackgroundTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "스누즈 배경화면을\n설정 해 주세요")
        let range = (attributedString.string as NSString).range(of: "스누즈 배경화면을")
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
    
    // 수정 : cornerRadius
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("배경화면 업로드 하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 14
        button.backgroundColor = .systemPink
        return button
    }()
    
    //MARK: - Functions
}

extension SetBackgroundView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        setBackgroundTitle.textColor = .white
        setBackgroundCheckFlag = true
        nextButton.setTitle("다음", for: .normal)
        backgroundImageView.image = image
        delegate?.didSetBackgroundImageView(image: image)
        backgroundOpaqueView.isHidden = false
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func buttonTapped() {
        if setBackgroundCheckFlag {
            delegate?.didTapNextButton()
        } else {
            // UIViewController에서 present와 비슷한 기능으로 UIView에도 표시할 수 있도록 window에서 호출
            if let viewController = window?.rootViewController {
                viewController.present(imagePickerController, animated: true, completion: nil)
            }
        }
    }
}

private extension SetBackgroundView {
    func setupView() {
        
        nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        
        [backgroundImageView, backgroundOpaqueView, setBackgroundTitle, nextButton].forEach {
            backgroundView.addSubview($0)
        }
        
        addSubview(backgroundView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            setBackgroundTitle.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                                    constant: 136),
            setBackgroundTitle.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                        constant: 26),
        ])
        
        NSLayoutConstraint.activate([
            // 수정 : 버튼 height
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            nextButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -54),
            nextButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                 constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            backgroundOpaqueView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            backgroundOpaqueView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            backgroundOpaqueView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            backgroundOpaqueView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
