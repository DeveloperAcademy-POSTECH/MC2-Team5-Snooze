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
    func didTapAlbum()
    func didTapNoti()
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
  
  private lazy var albumButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "redalbumbutton1"), for: .normal)
    button.contentMode = .scaleAspectFit
    return button
  }()
  
  private lazy var notificationButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "redalarmbutton1"), for: .normal)
    button.contentMode = .scaleAspectFit
    return button
  }()
  
  lazy var profileButton: UIButton = {
    let button = UIButton()
//      button.setImage(UIImage(data: Data()), for: .normal)
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
    
    @objc private func didTapAlbum() {
        delegate?.didTapAlbum()
    }
    
    @objc private func didTapNoti() {
        delegate?.didTapNoti()
    }
    
    @objc private func didTapProfile() {
        delegate?.didTapProfile()
    }
}

extension NavigationView {
  
  private func setupView() {
      
      albumButton.addTarget(self, action: #selector(didTapAlbum), for: .touchUpInside)
      notificationButton.addTarget(self, action: #selector(didTapNoti), for: .touchUpInside)
      profileButton.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
      
    [logoImageView, albumButton, notificationButton, profileButton].forEach {
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
      albumButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 4.adjusted),
      albumButton.trailingAnchor.constraint(equalTo: notificationButton.leadingAnchor, constant: -18.adjusted),
      albumButton.widthAnchor.constraint(equalToConstant: 34.adjusted),
      albumButton.heightAnchor.constraint(equalToConstant: 29.adjusted)

    ])

    NSLayoutConstraint.activate([
      notificationButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 4.adjusted),
      notificationButton.trailingAnchor.constraint(equalTo: profileButton.leadingAnchor, constant: -18.adjusted),
      notificationButton.widthAnchor.constraint(equalToConstant: 28.adjusted),
      notificationButton.heightAnchor.constraint(equalToConstant: 29.adjusted)
    ])

    NSLayoutConstraint.activate([
      profileButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 4.adjusted),
      profileButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
      profileButton.widthAnchor.constraint(equalToConstant: 28.adjusted),
      profileButton.heightAnchor.constraint(equalToConstant: 28.adjusted)
    ])
    
  }
}

