//
//  ThirdOnboardingView.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/04.
//

import UIKit

import OnJeWaCore
import OnJeWaUI

final class ThirdOnboardingView: BaseView {
    
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
        let attributedString = NSMutableAttributedString(string: "snooze와 함께\n앨범을 공유해봐요.")
        let range = (attributedString.string as NSString).range(of: "앨범을 공유")
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
        let attributedString = NSMutableAttributedString(string: "막둥이와 함께한 미션 사진이 담긴\n앨범을 가족과 공유해보세요.\n막둥이의 사진으로 가족들과 다양한\n이야기를 할 수 있을지도 몰라요!")
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
    
    private let labelBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = OnjewaColor.primary.color
        return view
    }()
}

private extension ThirdOnboardingView {
    func setupView() {
        [labelBox, onBoardingTitle, onBoardingSubTitle].forEach {
            backgroundView.addSubview($0)
        }
        
        addSubview(backgroundView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            labelBox.topAnchor.constraint(equalTo: onBoardingTitle.bottomAnchor,
                                          constant: -16),
            labelBox.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                              constant: 24),
            labelBox.widthAnchor.constraint(equalToConstant: 145),
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
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
