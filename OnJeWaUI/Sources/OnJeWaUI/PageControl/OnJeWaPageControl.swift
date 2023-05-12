//
//  File.swift
//  
//
//  Created by Kim SungHun on 2023/05/06.
//

import UIKit

public class OnJeWaPageControl: UIView {
    
    //MARK: - Preperties
    
    private var entirePage: Int?
    private var currentPage: Int?
    
    //MARK: - Views
    
    public let pageControlStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Life Cycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(frame: CGRect, entirePage: Int, currentPage: Int) {
        self.init(frame: frame)
        self.entirePage = entirePage
        self.currentPage = currentPage
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension OnJeWaPageControl {
    func setupView() {
        for i in 1...(entirePage ?? 1)  {
            let circleView = UIView()
            circleView.backgroundColor = .lightGray
            circleView.translatesAutoresizingMaskIntoConstraints = false
            circleView.heightAnchor.constraint(equalToConstant: 10).isActive = true
            if i == currentPage {
                circleView.widthAnchor.constraint(equalToConstant: 20).isActive = true
                circleView.layer.cornerRadius = 4
                circleView.backgroundColor = .systemPink
            } else {
                circleView.widthAnchor.constraint(equalToConstant: 10).isActive = true
                circleView.layer.cornerRadius = 5
            }
            circleView.layer.masksToBounds = true
            pageControlStackView.addArrangedSubview(circleView)
        }
        
        addSubview(pageControlStackView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            pageControlStackView.topAnchor.constraint(equalTo: self.topAnchor),
            pageControlStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            pageControlStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pageControlStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
