//
//  GalleryViewController.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/11.
//

import UIKit
import OnJeWaUI
import OnJeWaCore

class GalleryViewController: BaseViewController {
  
  
  //MARK: - UI Components
    
  private let missionAlbumLabel : UILabel = {
    let label = UILabel()
    label.text = "미션 앨범"
    label.font = .systemFont(ofSize: 18, weight: .bold)
    return label
  }()
  
  
  private let exitBtn : UIButton = {
    let button = UIButton()
    button.tintColor = .black
    button.addTarget(self, action: #selector(returnDrawerVC), for: .touchUpInside)
    button.setImage(UIImage(systemName:"chevron.backward"), for: .normal)
    return button
  }()
  
  @objc
  private func returnDrawerVC() {
    guard let presentingVC = self.presentingViewController as? UINavigationController else { return }
    self.dismiss(animated: false) {
      presentingVC.popViewController(animated: false)
    }
  }
  
  private let exitLabel: UILabel = {
    let label = UILabel()
    label.text = "서랍"
    label.font = UIFont.systemFont(ofSize: 18)
    return label
  }()
  
  private lazy var addButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "person.crop.circle.badge.plus"), for: .normal)
    return button
  }()
  
  private lazy var gridCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.isScrollEnabled = true
    collectionView.showsVerticalScrollIndicator = false
    collectionView.delegate = self
    collectionView.dataSource = self
    return collectionView
  }()
  
  
  //MARK: - Constant
  
  final let gridInset: UIEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
  final let gridLineSpacing:CGFloat = 5
  final let gridInterItemSpacing: CGFloat = 3
  final let gridCellHeight :CGFloat = 123
  
  override func viewDidLoad() {
    super.viewDidLoad()
    register()
//    setupView()
//    setLayout()
  }
  
  //MARK: - General Helpers
  
  private func register() {
    gridCollectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
    
  }
  
  private func calculateCellHeight() -> CGFloat {
    let count = CGFloat(gridList.count)
    let heightCount = count/3 + count.truncatingRemainder(dividingBy: 2)
    return heightCount * gridCellHeight + (heightCount - 1) * gridLineSpacing + gridInset.top
  }
  
  override func setupView() {
    view.backgroundColor = .white
    [exitBtn,exitLabel, missionAlbumLabel, addButton, gridCollectionView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
  
  }
  
  override func setLayout() {
    NSLayoutConstraint.activate([
      exitBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4.adjusted),
      exitBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.adjusted),
      exitBtn.widthAnchor.constraint(equalToConstant: 8.adjusted),
      exitBtn.heightAnchor.constraint(equalToConstant: 16.adjusted)
    ])
    
    NSLayoutConstraint.activate([
      exitLabel.topAnchor.constraint(equalTo: exitBtn.topAnchor),
      exitLabel.leadingAnchor.constraint(equalTo: exitBtn.trailingAnchor, constant: 12.adjusted)
    ])
    
    NSLayoutConstraint.activate([
      missionAlbumLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      missionAlbumLabel.centerYAnchor.constraint(equalTo: exitLabel.centerYAnchor)
    ])
    
    NSLayoutConstraint.activate([
      addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.adjusted),
      addButton.centerYAnchor.constraint(equalTo: missionAlbumLabel.centerYAnchor),
      addButton.widthAnchor.constraint(equalToConstant: 29.adjusted),
      addButton.heightAnchor.constraint(equalToConstant: 29.adjusted)
    ])
    
    NSLayoutConstraint.activate([
      gridCollectionView.topAnchor.constraint(equalTo: missionAlbumLabel.bottomAnchor, constant: 16.adjusted),
      gridCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      gridCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      gridCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
    
  }
  
}

//MARK: - UICollectionView DelegateFlowLayout
extension GalleryViewController: UICollectionViewDelegateFlowLayout {
  
  //위아래 간격
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return gridLineSpacing
  }
  
  //옆 간격
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return gridInterItemSpacing
  }
  
  //cell 사이즈
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let screenWidth = UIScreen.main.bounds.width
    let cellWidth = screenWidth - gridInterItemSpacing * 2
    return CGSize(width: cellWidth/3, height: gridCellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return gridInset
  }
}

//MARK: - UICollectionView DataSource

extension GalleryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return gridList.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath)
            as? GalleryCollectionViewCell else {return UICollectionViewCell() }
    gridCell.dataBind(model: gridList[indexPath.item])
    return gridCell
  }
}



