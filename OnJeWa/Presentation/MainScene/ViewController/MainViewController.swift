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
  
  //MARK: - UI Components
  let weekCollectionVC = WeekCollectionViewController()

  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setLayout()
  }
  
  
  override func setupView() {
    //MARK: 수정 - 배경 색상 변경 필요
    view.backgroundColor = .white
    
    addChild(weekCollectionVC)
    view.addSubview(weekCollectionVC.view)
    weekCollectionVC.view.translatesAutoresizingMaskIntoConstraints = false
    weekCollectionVC.didMove(toParent: self)


  }
  
  override func setLayout() {
    NSLayoutConstraint.activate([
      weekCollectionVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 42.adjusted),
      weekCollectionVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -42.adjusted),
      weekCollectionVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16.adjusted),
      weekCollectionVC.view.heightAnchor.constraint(equalToConstant: 64.adjusted)
    ])
  }
  
  
}





