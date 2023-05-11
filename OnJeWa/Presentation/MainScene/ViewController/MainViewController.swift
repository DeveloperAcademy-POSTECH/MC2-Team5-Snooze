//
//  MainViewController.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/04.
//

import UIKit
import OnJeWaCore
import OnJeWaUI

class MainViewController: BaseViewController {
  
  //MARK: - View Components
  private let navigationView = NavigationView()
  private let stopWatchView = StopWatchViewController()
  private let weekCollectionView = WeekCollectionView()
  private let tapButtonVC = TapButtonViewController()
  
  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setLayout()
  }

  
  override func setupView() {
    //MARK: 수정 - 배경 색상 변경 필요
    view.backgroundColor = .gray
    [navigationView,stopWatchView.view, weekCollectionView, tapButtonVC.view].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
   
  }
  
  override func setLayout() {
    
    NSLayoutConstraint.activate([
      navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4.adjusted),
      navigationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 38.adjusted),
      navigationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -38.adjusted),
      navigationView.heightAnchor.constraint(equalToConstant: 29.adjusted)
    ])
    
    NSLayoutConstraint.activate([
      stopWatchView.view.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 63.adjusted),
      stopWatchView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      stopWatchView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      stopWatchView.view.bottomAnchor.constraint(equalTo: tapButtonVC.view.topAnchor, constant: -34.adjusted)
    ])

    NSLayoutConstraint.activate([
      tapButtonVC.view.bottomAnchor.constraint(equalTo: weekCollectionView.topAnchor, constant: -38.adjusted),
      tapButtonVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 59.adjusted),
      tapButtonVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -59.adjusted),
      tapButtonVC.view.heightAnchor.constraint(equalToConstant: 76.adjusted)
    ])
    NSLayoutConstraint.activate([
      weekCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 42.adjusted),
      weekCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -42.adjusted),
      weekCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16.adjusted),
      weekCollectionView.heightAnchor.constraint(equalToConstant: 64.adjusted)
    ])
  }
  
  
}





