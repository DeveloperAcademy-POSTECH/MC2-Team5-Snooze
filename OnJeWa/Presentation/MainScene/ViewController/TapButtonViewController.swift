//
//  TapButtonViewController.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/09.
//

import UIKit
import OnJeWaUI
import OnJeWaCore

class TapButtonViewController: BaseViewController {
  
  private lazy var homeOutButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "homeoutUnClicked"), for: .normal)
    button.contentMode = .scaleAspectFit
    button.addTarget(self, action: #selector(homeOutButtonTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var homeInButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "homeinUnClicked"), for: .normal)
    button.contentMode = .scaleAspectFit
    button.addTarget(self, action: #selector(homeInButtonTapped), for: .touchUpInside)
    return button
  }()
  
  private let tapPositionImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "leftlight"))
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private var isHomeOutButtonClicked = false {
    didSet {
      if isHomeOutButtonClicked {
        self.tapPositionImageView.image = UIImage(named: "leftlight")
        self.homeOutButton.setImage(UIImage(named: "homeoutClicked"), for: .normal)
      }else {
        homeInButton.setImage(UIImage(named: "homeinUnClicked"), for: .normal)
      }
    }
  }
  
  private var isHomeInButtonClicked = false {
    didSet {
      if isHomeInButtonClicked {
        self.tapPositionImageView.image = UIImage(named: "rightlight")
        self.homeInButton.setImage(UIImage(named: "homeinClicked"), for: .normal)
      }else {
        homeOutButton.setImage(UIImage(named: "homeoutUnClicked"), for: .normal)
      }
    }
  }
  private var previousButton: UIButton?
  
  
  //MARK: 수정 - 기능
  @objc private func homeOutButtonTapped(_ sender: UIButton) {
    if sender != previousButton {
      let sheet = UIAlertController(title: "밖으로 외출하시나요?", message: "반려동물이 집에서 기다리고\n 있으니 빨리 다녀오세요!", preferredStyle: .alert)
      sheet.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { _ in
        self.isHomeInButtonClicked = false
        self.isHomeOutButtonClicked = true
      }))
      sheet.addAction(UIAlertAction(title: "취소", style: .cancel))
      
      present(sheet, animated: true)
      previousButton = sender
    }

   }
   
  @objc private func homeInButtonTapped(_ sender: UIButton) {

    if sender != previousButton {
      let sheet = UIAlertController(title: "집에 돌아오셨나요?", message: "나의 반려동물과\n 즐거운 시간을 보내세요!", preferredStyle: .alert)
      sheet.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { _ in
        self.isHomeInButtonClicked = true
        self.isHomeOutButtonClicked = false
      }))
      sheet.addAction(UIAlertAction(title: "취소", style: .cancel))
      present(sheet, animated: true)
      previousButton = sender
      
    }
    
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setLayout()
    setupView()
  }
  
  override func setupView() {
    view.backgroundColor = .clear
    [homeOutButton, tapPositionImageView, homeInButton].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  override func setLayout() {
    NSLayoutConstraint.activate([
      homeOutButton.topAnchor.constraint(equalTo: view.topAnchor),
      homeOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      homeOutButton.widthAnchor.constraint(equalToConstant: 76.adjusted),
      homeOutButton.heightAnchor.constraint(equalToConstant: 76.adjusted)
    ])
    NSLayoutConstraint.activate([
      tapPositionImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      tapPositionImageView.leadingAnchor.constraint(equalTo: homeOutButton.trailingAnchor, constant: 48.adjusted),
      tapPositionImageView.widthAnchor.constraint(equalToConstant: 24.adjusted)
    ])
    NSLayoutConstraint.activate([
      homeInButton.topAnchor.constraint(equalTo: view.topAnchor),
      homeInButton.leadingAnchor.constraint(equalTo: tapPositionImageView.trailingAnchor, constant: 48.adjusted),
      homeInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      homeInButton.widthAnchor.constraint(equalToConstant: 76.adjusted),
      homeInButton.heightAnchor.constraint(equalToConstant: 76.adjusted)
    ])
  }

}
