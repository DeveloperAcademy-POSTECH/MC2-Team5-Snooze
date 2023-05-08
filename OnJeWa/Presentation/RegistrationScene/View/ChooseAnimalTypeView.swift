//
//  FirstRegistrationView.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/05.
//

import UIKit

import OnJeWaCore
import RxCocoa
import RxSwift

protocol ChooseAnimalTypeViewDelegate: AnyObject {
    func didTapNextButton()
}

final class ChooseAnimalTypeView: BaseView {
    
    static var testHeightValue = 125.0
    
    //MARK: - Properties
    
    private var petType: AnimalType = .none
    weak var proxyDelegate: ChooseAnimalTypeViewProxyDelegate?
    weak var delegate: ChooseAnimalTypeViewDelegate?
    
    
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
    
    // 수정 : 폰트, 크기, padding
    private let registrationTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "어떤 동물을\n기르세요?")
        let range = (attributedString.string as NSString).range(of: "동물을")
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
    
    private lazy var dogStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    let dogImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = testHeightValue / 2
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.clear.cgColor
        return imageView
    }()
    
    private let dogTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "강아지"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var catStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    let catImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = testHeightValue / 2
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.clear.cgColor
        return imageView
    }()
    
    private let catTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "고양이"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var parrotStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    private let parrotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = testHeightValue / 2
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.clear.cgColor
        return imageView
    }()
    
    private let parrotTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "앵무새"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var rabbitStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    private let rabbitImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = testHeightValue / 2
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.clear.cgColor
        return imageView
    }()
    
    private let rabbitTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "토끼"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    // 수정 : cornerRadius
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 14
        button.backgroundColor = .systemGray6
        return button
    }()
    
    //MARK: - Functions
    
    @objc func stackViewTapGesture(_ sender: UITapGestureRecognizer) {
        guard let sender = sender.view else { return }
        let petType = sender.tag == 1 ? "강아지" : sender.tag == 2 ? "고양이" :
        sender.tag == 3 ? "앵무새" : sender.tag == 4 ? "토끼" : "선택안함"
        proxyDelegate?.didSelectPetType?(value: petType)
    }
    
    @objc func nextButtonTapGesture(_ sender: UITapGestureRecognizer) {
        delegate?.didTapNextButton()
    }
    
    func setupPetType(_ passedPetTpye: String) {
        switch passedPetTpye {
        case "강아지":
            resetPetTpye()
            dogImageView.layer.borderColor = UIColor.systemPink.cgColor
            nextButton.backgroundColor = .systemPink
            nextButton.addTarget(self, action: #selector(nextButtonTapGesture), for: .touchUpInside)
            break
        case "고양이":
            resetPetTpye()
            catImageView.layer.borderColor = UIColor.systemPink.cgColor
            nextButton.backgroundColor = .systemPink
            nextButton.addTarget(self, action: #selector(nextButtonTapGesture), for: .touchUpInside)
            break
        case "앵무새":
            resetPetTpye()
            parrotImageView.layer.borderColor = UIColor.systemPink.cgColor
            nextButton.backgroundColor = .systemPink
            nextButton.addTarget(self, action: #selector(nextButtonTapGesture), for: .touchUpInside)
            break
        case "토끼":
            resetPetTpye()
            rabbitImageView.layer.borderColor = UIColor.systemPink.cgColor
            nextButton.backgroundColor = .systemPink
            nextButton.addTarget(self, action: #selector(nextButtonTapGesture), for: .touchUpInside)
            break
        default:
            break
        }
    }
    
    func resetPetTpye() {
        dogImageView.layer.borderColor = UIColor.clear.cgColor
        catImageView.layer.borderColor = UIColor.clear.cgColor
        parrotImageView.layer.borderColor = UIColor.clear.cgColor
        rabbitImageView.layer.borderColor = UIColor.clear.cgColor
    }
}

private extension ChooseAnimalTypeView {
    func setupView() {
        
        [dogImageView, dogTitle].forEach {
            dogStackView.addArrangedSubview($0)
            dogStackView.tag = 1
            let tapGesture = UITapGestureRecognizer(target: self,
                                                    action: #selector(stackViewTapGesture(_:)))
            dogStackView.addGestureRecognizer(tapGesture)
        }
        
        [catImageView, catTitle].forEach {
            catStackView.addArrangedSubview($0)
            catStackView.tag = 2
            let tapGesture = UITapGestureRecognizer(target: self,
                                                    action: #selector(stackViewTapGesture(_:)))
            catStackView.addGestureRecognizer(tapGesture)
        }
        
        [parrotImageView, parrotTitle].forEach {
            parrotStackView.addArrangedSubview($0)
            parrotStackView.tag = 3
            let tapGesture = UITapGestureRecognizer(target: self,
                                                    action: #selector(stackViewTapGesture(_:)))
            parrotStackView.addGestureRecognizer(tapGesture)
        }
        
        [rabbitImageView, rabbitTitle].forEach {
            rabbitStackView.addArrangedSubview($0)
            rabbitStackView.tag = 4
            let tapGesture = UITapGestureRecognizer(target: self,
                                                    action: #selector(stackViewTapGesture(_:)))
            rabbitStackView.addGestureRecognizer(tapGesture)
        }
        
        [registrationTitle, dogStackView, catStackView,
         parrotStackView, rabbitStackView, nextButton].forEach {
            backgroundView.addSubview($0)
        }
        
        addSubview(backgroundView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            registrationTitle.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                                   constant: 136),
            registrationTitle.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                       constant: 26),
        ])
        
        NSLayoutConstraint.activate([
            dogStackView.topAnchor.constraint(equalTo: registrationTitle.bottomAnchor, constant: 66),
            dogStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 46),
        ])
        
        NSLayoutConstraint.activate([
            dogImageView.widthAnchor.constraint(equalToConstant: ChooseAnimalTypeView.testHeightValue),
            dogImageView.heightAnchor.constraint(equalToConstant: ChooseAnimalTypeView.testHeightValue),
        ])
        
        NSLayoutConstraint.activate([
            catStackView.topAnchor.constraint(equalTo: registrationTitle.bottomAnchor, constant: 66),
            catStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -46),
        ])
        
        NSLayoutConstraint.activate([
            catImageView.widthAnchor.constraint(equalToConstant: ChooseAnimalTypeView.testHeightValue),
            catImageView.heightAnchor.constraint(equalToConstant: ChooseAnimalTypeView.testHeightValue),
        ])
        
        NSLayoutConstraint.activate([
            parrotStackView.topAnchor.constraint(equalTo: dogStackView.bottomAnchor, constant: 26),
            parrotStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 46),
        ])
        
        NSLayoutConstraint.activate([
            parrotImageView.widthAnchor.constraint(equalToConstant: ChooseAnimalTypeView.testHeightValue),
            parrotImageView.heightAnchor.constraint(equalToConstant: ChooseAnimalTypeView.testHeightValue),
        ])
        
        NSLayoutConstraint.activate([
            rabbitStackView.topAnchor.constraint(equalTo: catStackView.bottomAnchor, constant: 26),
            rabbitStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -46),
        ])
        
        NSLayoutConstraint.activate([
            rabbitImageView.widthAnchor.constraint(equalToConstant: ChooseAnimalTypeView.testHeightValue),
            rabbitImageView.heightAnchor.constraint(equalToConstant: ChooseAnimalTypeView.testHeightValue),
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            // 수정 : 버튼 height
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            nextButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor,
                                               constant: -54),
            nextButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                 constant: -20),
        ])
    }
}

//MARK: - DelegateProxy

@objc protocol ChooseAnimalTypeViewProxyDelegate: AnyObject {
    @objc optional func didSelectPetType(value: String)
}

private class InfraIconDelegateProxy: DelegateProxy<ChooseAnimalTypeView, ChooseAnimalTypeViewProxyDelegate>
, DelegateProxyType, ChooseAnimalTypeViewProxyDelegate
{
    static func registerKnownImplementations() {
        self.register { (ChooseAnimalTypeView) -> InfraIconDelegateProxy in
            InfraIconDelegateProxy(parentObject: ChooseAnimalTypeView, delegateProxy: self)
        }
    }
    
    static func currentDelegate(for object: ChooseAnimalTypeView) -> ChooseAnimalTypeViewProxyDelegate? {
        return object.proxyDelegate
    }
    
    static func setCurrentDelegate(_ delegate: ChooseAnimalTypeViewProxyDelegate?,
                                   to object: ChooseAnimalTypeView)
    {
        object.proxyDelegate = delegate
    }
}

extension Reactive where Base: ChooseAnimalTypeView {
    
    var delegate : DelegateProxy<ChooseAnimalTypeView, ChooseAnimalTypeViewProxyDelegate> {
        return InfraIconDelegateProxy.proxy(for: self.base)
    }
    
    var didSelectPetType: Observable<String?> {
        return delegate.methodInvoked(#selector(ChooseAnimalTypeViewProxyDelegate.didSelectPetType(value:)))
            .map { petTypes in
                return petTypes[0] as? String
            }
    }
}
