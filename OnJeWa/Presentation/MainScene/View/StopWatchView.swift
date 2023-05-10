//
//  stopWatchViewController.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/10.
//

import UIKit
import Foundation
import OnJeWaUI
import OnJeWaCore

  //MARK: - 라벨 다 폰트 색상 수정 필요

class StopWatchView: BaseView {
  
  //MARK: - UI Components
  
  private let backgroundView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    return view
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "카키의 하루"
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    return label
  }()
  
  private let dateLabel: UILabel = {
    let label = UILabel()
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy년 M월 d일"
    let dateString = dateFormatter.string(from: currentDate)
    label.text = dateString
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()
  
  private let popupButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "question"), for: .normal)
    button.contentMode = .scaleAspectFit
    return button
  }()
  
  private let clockImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "watch")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let animalTimeImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "animaltime")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let humanTimeImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "persontime")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let carrotNumber: UILabel = {
    let label = UILabel()
    var labelData = 0
    label.text = "🥕x\(labelData)"
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .black
    return label
  }()
  
  private let inClockAnimalImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "watchdog")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let inClockTitleLable: UILabel = {
    let label = UILabel()
    label.text = "카키가 나와 떨어진지"
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = .black
    return label
  }()
  
  private let inClockAnimalTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "00:00:00"
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 36)
    return label
  }()
  
  private let inClockHumanTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "00:00:00"
    label.font = UIFont.systemFont(ofSize: 14)
    return label
  }()
  
   
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
extension StopWatchView {
  private func setupView() {
   [titleLabel, dateLabel, popupButton, clockImageView,
   carrotNumber, inClockAnimalImageView, inClockTitleLable, inClockHumanTimeLabel, inClockAnimalTimeLabel]
     .forEach {
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
     titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor),
     titleLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
   ])
   NSLayoutConstraint.activate([
     dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.adjusted),
     dateLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
   ])
   NSLayoutConstraint.activate([
     popupButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
     popupButton.widthAnchor.constraint(equalToConstant: 24.adjusted),
     popupButton.heightAnchor.constraint(equalToConstant: 24.adjusted),
     popupButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 6.adjusted)
   ])
   NSLayoutConstraint.activate([
     clockImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 24.adjusted),
     clockImageView.leadingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.leadingAnchor, constant: 42.adjusted),
     clockImageView.trailingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.trailingAnchor, constant: -42.adjusted),
     clockImageView.heightAnchor.constraint(equalToConstant: 300.adjusted)
   ])
   
   NSLayoutConstraint.activate([
     carrotNumber.topAnchor.constraint(equalTo: clockImageView.topAnchor, constant: 50.adjusted),
     carrotNumber.centerXAnchor.constraint(equalTo: clockImageView.centerXAnchor)
   ])
   NSLayoutConstraint.activate([
     inClockAnimalImageView.topAnchor.constraint(equalTo: carrotNumber.bottomAnchor, constant: 9.adjusted),
     inClockAnimalImageView.leadingAnchor.constraint(equalTo: clockImageView.leadingAnchor, constant: 120.adjusted),
     inClockAnimalImageView.trailingAnchor.constraint(equalTo: clockImageView.trailingAnchor, constant: -120.adjusted),
     inClockAnimalImageView.heightAnchor.constraint(equalToConstant: 45.adjusted)
   ])
   NSLayoutConstraint.activate([
     inClockTitleLable.topAnchor.constraint(equalTo: inClockAnimalImageView.bottomAnchor, constant: 18.adjusted),
     inClockTitleLable.centerXAnchor.constraint(equalTo: clockImageView.centerXAnchor)
   ])
   NSLayoutConstraint.activate([
     inClockAnimalTimeLabel.topAnchor.constraint(equalTo: inClockTitleLable.bottomAnchor,constant: 2.adjusted),
     inClockAnimalTimeLabel.centerXAnchor.constraint(equalTo: clockImageView.centerXAnchor)
   ])
   NSLayoutConstraint.activate([
     inClockHumanTimeLabel.topAnchor.constraint(equalTo: inClockAnimalTimeLabel.bottomAnchor, constant: 8.adjusted),
     inClockHumanTimeLabel.centerXAnchor.constraint(equalTo: clockImageView.centerXAnchor)
   ])
   
 }
  
}
