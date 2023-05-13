//
//  NotificationViewInvitationCell.swift
//  OnJeWa
//
//  Created by Eojin Choi on 2023/05/14.
//

import Foundation
import UIKit

final class NotificationViewInvitationCell: NotificationViewCell {
    static let cellId = "Invitation Type Cell"
    
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
    
    let button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitle("초대 수락", for: [])
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemYellow
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Functions

    private func setLayout() {
        self.addSubview(profile)
        self.addSubview(containerView)
        self.addSubview(button)
        
        [contentLabel, timeLabel].forEach {
            containerView.addArrangedSubview($0)
        }
        containerView.addSubview(contentLabel)
        containerView.addSubview(timeLabel)
        
        profile.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        profile.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profile.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profile.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.profile.trailingAnchor, constant: 16).isActive = true
        
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        button.widthAnchor.constraint(equalToConstant: 98).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
