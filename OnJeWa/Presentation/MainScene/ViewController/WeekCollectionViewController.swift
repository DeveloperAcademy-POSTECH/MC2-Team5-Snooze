//
//  WeekCollectionViewController.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/04.
//

import UIKit
import OnJeWaCore

class WeekCollectionViewController: UIViewController {
  
  //MARK: - UI Components
  private let weekTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "이번주 카키와 함께한 시간"
    //MARK: 수정 - 색상 변경 필요
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 16.adjusted, weight: .bold)
    return label
  }()
  
  private lazy var weekCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.isScrollEnabled = false
    collectionView.delegate = self
    collectionView.dataSource = self
    return collectionView
  }()
  
  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setConfig()
    register()
    setLayout()
  }

}


//MARK: - Extension

extension WeekCollectionViewController  {
  private func setConfig() {
    view.backgroundColor = .white
    [weekCollectionView, weekTitleLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }

  }
  
  private func setLayout() {
    
    NSLayoutConstraint.activate([
      weekCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      weekCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      weekCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      weekCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    
    NSLayoutConstraint.activate([
      weekTitleLabel.bottomAnchor.constraint(equalTo: weekCollectionView.topAnchor, constant: -16.adjusted),
      weekTitleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
    ])
  }
  
  private func register() {
    weekCollectionView.register(WeekCollectionViewCell.self,
                                forCellWithReuseIdentifier: WeekCollectionViewCell.identifier)
  }
}


extension WeekCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let screenWidth = UIScreen.main.bounds.width
    //MARK: - padding을 뺀 cell의 넓이, 계산 값으로 변경 필요
    let cellWidth = (screenWidth - 144) / 7
    return CGSize(width: 35.adjusted, height: 64.adjusted)
    
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 10.adjusted
  }
}


extension WeekCollectionViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return mainWeekData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let collectionCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.identifier,
                                                                  for: indexPath) as? WeekCollectionViewCell else { return UICollectionViewCell() }
    collectionCell.dataBind(model: mainWeekData[indexPath.item])
    return collectionCell
  }
  
}
