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
    imageView.image = UIImage(named: "full")
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
    [dayLabel, missionGaugeImageView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
  }
  
  private func setLayout() {
    let screenWidth = UIScreen.main.bounds.width
    let imageWidth = (screenWidth - 144) / 7
    
    let contentViewHeight = contentView.frame.height
    let imageHeight = contentViewHeight - 29
    
    NSLayoutConstraint.activate([
      missionGaugeImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      missionGaugeImageView.widthAnchor.constraint(equalToConstant: imageWidth.adjusted),
      missionGaugeImageView.heightAnchor.constraint(equalToConstant: imageHeight.adjusted)])
    
    
    NSLayoutConstraint.activate([
      dayLabel.topAnchor.constraint(equalTo: missionGaugeImageView.bottomAnchor, constant: 12.adjusted),
      dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
    ])
    
  }
  
  func dataBind(model: MainWeekModel) {
    dayLabel.text = model.day
  }
}
