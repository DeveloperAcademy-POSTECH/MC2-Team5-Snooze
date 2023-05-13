//
//  NotificationViewChatCell.swift
//  OnJeWa
//
//  Created by Eojin Choi on 2023/05/13.
//

import Foundation
import UIKit

final class NotificationViewChatCell: NotificationViewCell {
    static let cellId = "Chat Type Cell"
    
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
    
    // MARK: - Functions

    private func setLayout() {
        self.addSubview(profile)
        self.addSubview(containerView)
        
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
        
        contentLabel.widthAnchor.constraint(equalToConstant: 282).isActive = true
    }
}
