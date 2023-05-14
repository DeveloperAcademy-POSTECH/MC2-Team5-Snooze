//
//  BackgroundView.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/11.
//

import UIKit
import OnJeWaUI
import OnJeWaCore
import OnJeWaNetwork

final class BackgroundView: BaseView {
    
    //MARK: - UI Components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(data: RealmManager.shared.readBackgroundImage())
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let blackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "black")
        return imageView
    }()
    
    private let whiteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "white")
        return imageView
    }()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Extension

extension BackgroundView {
    func setupView() {
        [backgroundImageView, blackImageView, whiteImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.addSubview($0)
        }
        addSubview(backgroundView)
    }
    
    func setLayout() {
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 503.adjusted)
        ])
        
        NSLayoutConstraint.activate([
            blackImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            blackImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            blackImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            blackImageView.heightAnchor.constraint(equalToConstant: 200.adjusted)
        ])
        
        NSLayoutConstraint.activate([
            whiteImageView.topAnchor.constraint(equalTo: blackImageView.bottomAnchor, constant: 158.adjusted),
            whiteImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            whiteImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor)
        ])
        
    }
}
