//
//  MainWeekCollectionViewCell.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/04.
//

import UIKit

class WeekCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "WeekCollectionViewCell"
  
  private let dayLabel: UILabel = {
    let label = UILabel()
    label.text = " "
    label.font = UIFont.systemFont(ofSize: 14)
    //폰트 색 변경
    label.textColor = .black
    return label
  }()
  
  private let missionGaugeImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "zero")
    imageView.contentMode = .scaleAspectFit
    return imageView
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
    [dayLabel ,missionGaugeImageView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
  }
  
  private func setLayout() {
    let screenWidth = UIScreen.main.bounds.width
    let imageWidth = (screenWidth - 144) / 7
    
    let contentViewHeight = contentView.frame.height
    let imageHeight = contentViewHeight - 39
    
    NSLayoutConstraint.activate([
      missionGaugeImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      missionGaugeImageView.widthAnchor.constraint(equalToConstant: 35.adjusted),
      missionGaugeImageView.heightAnchor.constraint(equalToConstant: 35.adjusted)])

    NSLayoutConstraint.activate([
      dayLabel.topAnchor.constraint(equalTo: missionGaugeImageView.bottomAnchor, constant: 12.adjusted),
      dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
    ])
    
  }
  
  func dataBind(model: MainWeekModel) {
    let cal = Calendar(identifier: .gregorian)
    let now = Date()
    let comps = cal.dateComponents([.weekday], from: now)
    
    dayLabel.text = model.day
    missionGaugeImageView.image = UIImage(named: model.image)
    if let weekday = comps.weekday, weekday == model.index {
          
      dayLabel.textColor = .red
      dayLabel.font = .systemFont(ofSize: 14, weight: .bold)
        }
  }
}
