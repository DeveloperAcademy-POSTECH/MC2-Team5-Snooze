//
//  MainWeekCollectionViewCell.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/04.
//

import UIKit
import OnJeWaUI
import OnJeWaCore

class WeekCollectionViewCell: UICollectionViewCell {
  
  var missionTapAction: (() -> Void)?
  
  static let identifier = "WeekCollectionViewCell"
  
  private let dayLabel: UILabel = {
    let label = UILabel()
    label.text = " "
    label.font = UIFont.systemFont(ofSize: 14)
    //폰트 색 변경
    label.textColor = .black
    return label
  }()
  
   let missionGaugeImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "zero")
    imageView.contentMode = .scaleAspectFit
    imageView.isUserInteractionEnabled = true
    return imageView
  }()
  
   let circleBorder: UIView = {
    let circleSize = CGSize(width: 35, height: 35)
    let view = UIView()
    view.layer.borderWidth = 2.0
    view.backgroundColor = .clear
    view.layer.borderColor = UIColor.red.cgColor
    view.layer.cornerRadius = circleSize.width / 2.0
    view.isHidden = true
    return view
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

extension WeekCollectionViewCell {
  private func setupView() {
    contentView.backgroundColor = .clear
    [dayLabel ,missionGaugeImageView, circleBorder].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
  }
  
  private func setLayout() {
    
    NSLayoutConstraint.activate([
      missionGaugeImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      missionGaugeImageView.widthAnchor.constraint(equalToConstant: 35.adjusted),
      missionGaugeImageView.heightAnchor.constraint(equalToConstant: 35.adjusted)])
    
    NSLayoutConstraint.activate([
      dayLabel.topAnchor.constraint(equalTo: missionGaugeImageView.bottomAnchor, constant: 12.adjusted),
      dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
    ])
    
    NSLayoutConstraint.activate([
      circleBorder.topAnchor.constraint(equalTo: missionGaugeImageView.topAnchor),
      circleBorder.leadingAnchor.constraint(equalTo: missionGaugeImageView.leadingAnchor),
      circleBorder.trailingAnchor.constraint(equalTo: missionGaugeImageView.trailingAnchor),
      circleBorder.bottomAnchor.constraint(equalTo: missionGaugeImageView.bottomAnchor)
    ])
    
  }
  
  @objc func missionTapGesture(_ sender: UITapGestureRecognizer) {
    missionTapAction?()
  }
  
  func dataBind(model: MainWeekModel) {
    if model.image == "full" {
      let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(missionTapGesture))
      missionGaugeImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    let cal = Calendar(identifier: .gregorian)
    let now = Date()
    let comps = cal.dateComponents([.weekday], from: now)
    
    dayLabel.text = model.day
    missionGaugeImageView.image = UIImage(named: model.image)
    if let weekday = comps.weekday, weekday == model.index {
      
      dayLabel.textColor = hexStringToUIColor(hex: UserDefaultsSetting.mainColor)
      dayLabel.font = .systemFont(ofSize: 14, weight: .bold)
    }
  }
}
