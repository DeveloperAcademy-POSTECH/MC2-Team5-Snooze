//
//  SetBackgroundView.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/08.
//

import UIKit

import OnJeWaCore
import OnJeWaUI

protocol SetBackgroundViewDelegate: AnyObject {
    func didTapNextButton()
    func didSetBackgroundImageView(image: UIImage)
}

final class SetBackgroundView: BaseView {
    
    //MARK: - Properties
    
    private var setBackgroundImageStatus = false
    private let imagePickerController = UIImagePickerController()
    weak var delegate: SetBackgroundViewDelegate?
    
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
    
    private let blackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "registBlack")
        imageView.isHidden = true
        return imageView
    }()
    
    private let whiteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "registWhite")
        return imageView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        let originalImage = UIImage(named: "setBackgroundImage")
        let size = CGSize(width: originalImage!.size.width / 3, height: originalImage!.size.height / 3)
        let renderer = UIGraphicsImageRenderer(size: size)
        let resizedImage = renderer.image { _ in
            originalImage!.draw(in: CGRect(origin: .zero, size: size))
        }
        imageView.image = resizedImage
        imageView.sizeToFit()
        return imageView
    }()
    
    private let userSetBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.isHidden = true
        return imageView
    }()
    
    private let setBackgroundTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "snoze 배경화면을\n설정 해 주세요")
        let range = (attributedString.string as NSString).range(of: "snoze 배경화면을")
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
    
    private let resetTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "다시 설정하기"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = OnjewaColor.button.color
        label.isHidden = true
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("배경화면 업로드 하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 14
        button.backgroundColor = hexStringToUIColor(hex: UserDefaultsSetting.mainColor)
        return button
    }()
    
    //MARK: - Functions
}

extension SetBackgroundView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        setBackgroundTitle.textColor = .white
        nextButton.setTitle("다음", for: .normal)
        userSetBackgroundImageView.image = image
        delegate?.didSetBackgroundImageView(image: image)
        setBackgroundImageStatus = true
        backgroundImageView.isHidden = true
        userSetBackgroundImageView.isHidden = false
        blackImageView.isHidden = false
        resetTitle.isHidden = false
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func buttonTapped() {
        if setBackgroundImageStatus {
            delegate?.didTapNextButton()
        } else {
            // UIViewController에서 present와 비슷한 기능으로 UIView에도 표시할 수 있도록 window에서 호출
            if let viewController = window?.rootViewController {
                viewController.present(imagePickerController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func resetTapped() {
        if let viewController = window?.rootViewController {
            viewController.present(imagePickerController, animated: true, completion: nil)
        }
    }
}

private extension SetBackgroundView {
    func setupView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resetTapped))
        resetTitle.addGestureRecognizer(tapGestureRecognizer)
        
        nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        [userSetBackgroundImageView, backgroundImageView, blackImageView, setBackgroundTitle,
         whiteImageView, resetTitle, nextButton].forEach {
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
            resetTitle.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -12),
            resetTitle.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            nextButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -54),
            nextButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                 constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: setBackgroundTitle.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userSetBackgroundImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            userSetBackgroundImageView.heightAnchor.constraint(equalToConstant: 503.adjusted),
            userSetBackgroundImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            userSetBackgroundImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            blackImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            blackImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            blackImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            blackImageView.heightAnchor.constraint(equalToConstant: 375.adjusted)
        ])
        
        NSLayoutConstraint.activate([
            whiteImageView.topAnchor.constraint(equalTo: blackImageView.bottomAnchor),
            whiteImageView.heightAnchor.constraint(equalToConstant: 323.adjusted),
            whiteImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            whiteImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
