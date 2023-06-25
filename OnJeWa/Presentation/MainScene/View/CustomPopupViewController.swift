//
//  CustomPopupVIew.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/10.
//

import UIKit
import OnJeWaUI
import OnJeWaCore

final class CustomPopupViewController: BaseViewController  {
  
  private let popupBackgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 16
    view.clipsToBounds = true
    return view
  }()
  
  private let popupTitleLable: UILabel = {
    let label = UILabel()
    label.text = "나와 막둥이의 시간"
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    return label
  }()
  
  private let popupImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "image_logo")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let contentLabel: UILabel = {
    let attributedString = NSMutableAttributedString(string: "사람의 1시간은 막둥이들의 시간과 달라요.\nsnooze와 함께 막둥이의 시간을 체험해보고\n미션을 수행해 함께하는 시간을 늘려봐요!")
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 8
    attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                  value:paragraphStyle,
                                  range:NSMakeRange(0, attributedString.length))
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.attributedText = attributedString
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    label.textAlignment = .center
    label.textColor = .black
    return label
  }()
  
  private lazy var checkButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = hexStringToUIColor(hex: UserDefaultsSetting.mainColor)
    button.layer.cornerRadius = 14
    button.setTitle("확인", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    button.titleLabel?.textColor = .black
    button.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
    return button
  }()
  
  @objc private func didTapCheckButton() {
    self.dismiss(animated: false)
  }
  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setLayout()
  }
  
  override func setupView() {
    view.backgroundColor = .black.withAlphaComponent(0.3)
    [popupBackgroundView, popupTitleLable, popupImageView, contentLabel, checkButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
  }
  
  override func setLayout() {
    
    NSLayoutConstraint.activate([
      popupBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 170.adjusted),
      popupBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23.adjusted),
      popupBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23.adjusted),
      popupBackgroundView.heightAnchor.constraint(equalToConstant: 474.adjusted)
    ])
    
    NSLayoutConstraint.activate([
      popupTitleLable.topAnchor.constraint(equalTo: popupBackgroundView.topAnchor, constant: 59.adjusted),
      popupTitleLable.centerXAnchor.constraint(equalTo: popupBackgroundView.centerXAnchor)
    ])
    
    NSLayoutConstraint.activate([
      popupImageView.topAnchor.constraint(equalTo: popupTitleLable.bottomAnchor, constant: 24.adjusted),
      popupImageView.leadingAnchor.constraint(equalTo: popupBackgroundView.leadingAnchor, constant: 32.adjusted),
      popupImageView.trailingAnchor.constraint(equalTo: popupBackgroundView.trailingAnchor, constant: -32.adjusted),
      popupImageView.heightAnchor.constraint(equalToConstant: 139.adjusted)
    ])
    
    NSLayoutConstraint.activate([
      contentLabel.topAnchor.constraint(equalTo: popupImageView.bottomAnchor, constant: 32.adjusted),
      contentLabel.leadingAnchor.constraint(equalTo: popupImageView.leadingAnchor),
      contentLabel.trailingAnchor.constraint(equalTo: popupImageView.trailingAnchor)
    ])
    
    NSLayoutConstraint.activate([
      checkButton.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 32.adjusted),
      checkButton.leadingAnchor.constraint(equalTo: popupImageView.leadingAnchor),
      checkButton.trailingAnchor.constraint(equalTo: popupImageView.trailingAnchor),
      checkButton.heightAnchor.constraint(equalToConstant: 60.adjusted)
    ])
  }
}
