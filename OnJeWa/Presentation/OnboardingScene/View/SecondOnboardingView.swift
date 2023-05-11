//
//  SecondOnBoardingView.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/04.
//

import UIKit

import OnJeWaCore
import OnJeWaUI

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
        return view
    }()
    
    private let onBoardingTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "어떻게 snooze하죠?\n미션을 줄게요!")
        let range = (attributedString.string as NSString).range(of: "미션")
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
    
    private let labelBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = OnjewaColor.primary.color
        return view
    }()
    
    private let onBoardingSubTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "외출 후 돌아오기 버튼을 누르면 하단\n미션 창에 오늘의 미션이 활성화 돼요.\n혼자서 잘 기다린 막둥이에게\n미션을 통해 나와의 시간을 보상으로\n주는건 어떨까요?")
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
    
    private let carrot: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "carrot")
        return imageView
    }()
}

private extension SecondOnboardingView {
    func setupView() {
        [labelBox, onBoardingTitle, onBoardingSubTitle, carrot].forEach {
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
            labelBox.widthAnchor.constraint(equalToConstant: 55),
            labelBox.heightAnchor.constraint(equalToConstant: 15),
        ])
        
        NSLayoutConstraint.activate([
            onBoardingTitle.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                                 constant: UIScreen.main.bounds.size.height / 6),
            onBoardingTitle.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                    constant: 24),
        ])
        
        NSLayoutConstraint.activate([
            onBoardingSubTitle.topAnchor.constraint(equalTo: onBoardingTitle.bottomAnchor, constant: 24),
            onBoardingSubTitle.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                        constant: 24),
        ])
        
        NSLayoutConstraint.activate([
            carrot.topAnchor.constraint(equalTo: onBoardingSubTitle.bottomAnchor, constant: 38),
            carrot.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
