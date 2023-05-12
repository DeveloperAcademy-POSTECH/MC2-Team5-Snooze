//
//  SecondOnBoardingView.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/04.
//

import UIKit

import OnJeWaCore
import OnJeWaUI

final class FirstOnboardingView: BaseView {
    
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
        let attributedString = NSMutableAttributedString(string: "외출한 후 돌아와\nsnooze해요.")
        let range = (attributedString.string as NSString).range(of: "돌아와")
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
        let attributedString = NSMutableAttributedString(string: "외출하기를 누르면, 막둥이와 나의\n떨어진 시간이 시작돼요.\n막둥이와 나의 하루의 시간은 얼마나\n다른지 snooze에서 확인해봐요.")
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
    
    private let onboardingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let originalImage = UIImage(named: "firstOnboarding")
        let size = CGSize(width: originalImage!.size.width / 3, height: originalImage!.size.height / 3)
        let renderer = UIGraphicsImageRenderer(size: size)
        let resizedImage = renderer.image { _ in
            originalImage!.draw(in: CGRect(origin: .zero, size: size))
        }
        imageView.image = resizedImage
        imageView.sizeToFit()
        return imageView
    }()
}

private extension FirstOnboardingView {
    func setupView() {
        [labelBox, onBoardingTitle, onBoardingSubTitle, onboardingImage].forEach {
            backgroundView.addSubview($0)
        }
        
        addSubview(backgroundView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            labelBox.topAnchor.constraint(equalTo: onBoardingTitle.topAnchor,
                                          constant: 24),
            labelBox.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                              constant: 148),
            labelBox.widthAnchor.constraint(equalToConstant: 85),
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
            onboardingImage.topAnchor.constraint(equalTo: onBoardingSubTitle.bottomAnchor,
                                                 constant: 20),
            onboardingImage.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
