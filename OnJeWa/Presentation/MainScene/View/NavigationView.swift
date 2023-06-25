//
//  NavigationViewController.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/04.
//

import UIKit
import OnJeWaUI
import OnJeWaCore
import OnJeWaNetwork

protocol NavigationViewDelegate: AnyObject {
  func didTapProfile()
}

final class NavigationView: BaseView {
  
  //MARK: - Properties
  
  weak var delegate: NavigationViewDelegate?
  
  //MARK: - UI Components
  
  private let backgroundView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    return view
  }()
  
  private let logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "logo_white")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private lazy var profileButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(data: RealmManager.shared.readProfileImage()), for: .normal)
    button.contentMode = .scaleAspectFit
    button.layer.cornerRadius = 14
    button.clipsToBounds = true
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  
  @objc private func didTapProfile() {
    delegate?.didTapProfile()
  }
}

//MARK: - Extensions

extension NavigationView {
  
  private func setupView() {
    profileButton.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
    
    [logoImageView, profileButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      backgroundView.addSubview($0)
    }
    addSubview(backgroundView)
  }
  
  private func setLayout() {
    
    NSLayoutConstraint.activate([
      backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    ])
    
    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 11.adjusted),
      logoImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
      logoImageView.widthAnchor.constraint(equalToConstant: 92.adjusted),
      logoImageView.heightAnchor.constraint(equalToConstant: 28.adjusted)
    ])
    
    NSLayoutConstraint.activate([
      profileButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 4.adjusted),
      profileButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
      profileButton.widthAnchor.constraint(equalToConstant: 28.adjusted),
      profileButton.heightAnchor.constraint(equalToConstant: 28.adjusted)
    ])
    
  }
}

