//
//  NotificationViewMissionCell.swift
//  OnJeWa
//
//  Created by Eojin Choi on 2023/05/14.
//

import Foundation
import UIKit

final class NotificationViewMissionCell: NotificationViewCell {
    static let cellId = "Mission Type Cell"
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    public let profile: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "IMG_2")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 30
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let containerView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        return stackView
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "contentLabel"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "timeLabel"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let missionImage: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "IMG_5")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 8
        imgView.clipsToBounds = true
        return imgView
    }()
    
    // MARK: - Functions

    private func setLayout() {
        self.addSubview(profile)
        self.addSubview(containerView)
        self.addSubview(missionImage)
        
        [contentLabel, timeLabel].forEach {
            containerView.addArrangedSubview($0)
        }
        containerView.addSubview(contentLabel)
        containerView.addSubview(timeLabel)
        
        profile.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        profile.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profile.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profile.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.profile.trailingAnchor, constant: 16).isActive = true
        
        contentLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        missionImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        missionImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -36).isActive = true
        missionImage.widthAnchor.constraint(equalToConstant: 56).isActive = true
        missionImage.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
}

