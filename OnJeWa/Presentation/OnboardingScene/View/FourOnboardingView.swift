//
//  FourOnboardingView.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/04.
//

import UIKit

import OnJeWaCore
import OnJeWaUI

protocol FourOnboardingViewDelegate: AnyObject {
    func didTapStartButton()
}

final class FourOnboardingView: BaseView {
    
    //MARK: - Properties
    
    weak var delegate: FourOnboardingViewDelegate?
    
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
        return view
    }()
    
    private let onBoardingTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "우리 함께 snooze\n시작해볼까요?")
        let range = (attributedString.string as NSString).range(of: "snooze")
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
    
    private let onBoardingSubTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "막둥이와 함께하는 시간이 당연해지지\n않도록! 지금 snooze 해요!")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle,
                                      range: NSRange(location: 0, length: attributedString.length))
        let label = UILabel()
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("시작하기", for: .normal)
        button.backgroundColor = OnjewaColor.primary.color
        button.layer.cornerRadius = 14
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    private let labelBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = OnjewaColor.primary.color
        return view
    }()
    
    //MARK: - Functions
    
    @objc private func startButtonTapped() {
        delegate?.didTapStartButton()
    }
}

private extension FourOnboardingView {
    func setupView() {
        [labelBox, onBoardingTitle, onBoardingSubTitle, startButton].forEach {
            backgroundView.addSubview($0)
        }
        
        addSubview(backgroundView)
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            labelBox.topAnchor.constraint(equalTo: onBoardingTitle.topAnchor,
                                          constant: 24),
            labelBox.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                              constant: 145),
            labelBox.widthAnchor.constraint(equalToConstant: 113),
            labelBox.heightAnchor.constraint(equalToConstant: 15),
        ])
        
        NSLayoutConstraint.activate([
            onBoardingTitle.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                                 constant: UIScreen.main.bounds.size.height / 6),
            onBoardingTitle.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                     constant: 24),
        ])
        
        NSLayoutConstraint.activate([
            onBoardingSubTitle.topAnchor.constraint(equalTo: onBoardingTitle.bottomAnchor,
                                                    constant: 24),
            onBoardingSubTitle.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                        constant: 24),
        ])
        
        NSLayoutConstraint.activate([
            startButton.heightAnchor.constraint(equalToConstant: 60),
            startButton.bottomAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.bottomAnchor,
                                                constant: -20),
            startButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                 constant: 20),
            startButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
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
