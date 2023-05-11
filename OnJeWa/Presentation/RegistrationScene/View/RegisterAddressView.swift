//
//  RegisterAddressView.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/08.
//

import UIKit

import OnJeWaCore
import OnJeWaUI

protocol RegisterAddressViewDelegate: AnyObject {
    func didTapNextButton()
    func didSetAddress()
}

final class RegisterAddressView: BaseView {
    
    //MARK: - Properties
    
    weak var delegate: RegisterAddressViewDelegate?
    private var setAddressFlag = false
    
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
    
    private let setAddressTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "우리집 위치를\n설정해주세요")
        let range = (attributedString.string as NSString).range(of: "우리집")
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
    
    lazy var addressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.isHidden = true
        return stackView
    }()
    
    private let pinIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "mappin.and.ellipse")
        return imageView
    }()
    
    let addressTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let resetAddressButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("다시 설정하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.systemGray4, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("위치 설정하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 14
        button.backgroundColor = .systemPink
        return button
    }()
    
    //MARK: - Functions
    
    @objc func buttonTapGesture(_ sender: UITapGestureRecognizer) {
        if setAddressFlag {
            delegate?.didTapNextButton()
        } else {
            delegate?.didSetAddress()
        }
    }
    
    @objc func resetButtonTapGesture(_ sender: UITapGestureRecognizer) {
        delegate?.didSetAddress()
    }
    
    func updateRegisterAddressView(address: String) {
        setAddressFlag = true
        addressStackView.isHidden = false
        addressTitle.text = address
        nextButton.setTitle("제리와 함께 행복한 시간을 즐겨봐요", for: .normal)
    }
}

private extension RegisterAddressView {
    func setupView() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        resetAddressButton.addTarget(self, action: #selector(resetButtonTapGesture), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(buttonTapGesture), for: .touchUpInside)
        
        [pinIcon, addressTitle, emptyView, resetAddressButton].forEach {
            addressStackView.addArrangedSubview($0)
        }
        
        [setAddressTitle, addressStackView, nextButton].forEach {
            backgroundView.addSubview($0)
        }
        
        addSubview(backgroundView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            setAddressTitle.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                                 constant: 136),
            setAddressTitle.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                     constant: 26),
        ])
        
        NSLayoutConstraint.activate([
            addressStackView.topAnchor.constraint(equalTo: setAddressTitle.bottomAnchor,
                                                  constant: 24),
            addressStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                      constant: 26),
            addressStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                       constant: -26),
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
