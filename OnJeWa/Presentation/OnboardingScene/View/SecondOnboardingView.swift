//
//  SecondOnBoardingView.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/04.
//

import UIKit

import OnJeWaCore

final class SecondOnboardingView: BaseView {
    
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
        view.backgroundColor = .blue
        return view
    }()
    
    // 수정 : 폰트, 크기, padding
    private let onBoardingTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "안녕 나는\n브랜드야 헤헿")
        let range = (attributedString.string as NSString).range(of: "브랜드야")
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
    
    // 수정 : 폰트, 크기, padding
    private let onBoardingSubTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "안녕 나는 브랜드야 히히안녕 나는 \n안녕 나는 브랜드야 히히안녕 나는 \n안녕 나는 브랜드야 히히안녕 나는 \n안녕 나는 브랜드야 히히안녕 나는 \n안녕 나는 브랜드야 히히안녕 나는")
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
}

private extension SecondOnboardingView {
    func setupView() {
        [onBoardingTitle, onBoardingSubTitle].forEach {
            backgroundView.addSubview($0)
        }
        
        addSubview(backgroundView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            onBoardingTitle.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                                 constant: UIScreen.main.bounds.size.height / 6),
            onBoardingTitle.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                    constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            onBoardingSubTitle.topAnchor.constraint(equalTo: onBoardingTitle.bottomAnchor, constant: 16),
            onBoardingSubTitle.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                        constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
