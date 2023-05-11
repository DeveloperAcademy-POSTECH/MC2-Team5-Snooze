//
//  GalleryCollectionViewCell.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/11.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
  
  //MARK: - Identifier
  static let identifier = "GalleryCollectionViewCell"
  
  //MARK: - UI Components
  private let galleryImageContainerView = UIView()
  private let galleryImageView = UIImageView()
  
  //MARk: - Life Cycles
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setLayout()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

//MARK: - Extensions

extension GalleryCollectionViewCell {
  
  private func setupView() {
    backgroundColor = .clear
    contentView.backgroundColor = .clear
    
    galleryImageContainerView.addSubview(galleryImageView)
    contentView.addSubview(galleryImageContainerView)
    
    galleryImageContainerView.translatesAutoresizingMaskIntoConstraints = false
    galleryImageView.translatesAutoresizingMaskIntoConstraints = false

  }
  private func setLayout() {
    
    NSLayoutConstraint.activate([
      galleryImageContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      galleryImageContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      galleryImageContainerView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
      galleryImageContainerView.heightAnchor.constraint(equalToConstant: contentView.frame.height)
    ])
    
    
    NSLayoutConstraint.activate([
      galleryImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      galleryImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      galleryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      galleryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
    
  }
  
  //MARK: - General Helpers
  
  func dataBind(model: GalleryPhotoModel) {
    galleryImageView.image = UIImage(named: model.photoImage)
  }
}
