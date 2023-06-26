//
//  SettingViewProfileCell.swift
//  OnJeWa
//
//  Created by Eojin Choi on 2023/05/12.
//

import UIKit

final class SettingViewProfileCell: SettingViewCell {
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
        imgView.image = UIImage(named: "IMG_9")
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
    
    let name: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let desc: UILabel = {
        let label = UILabel()
        label.text = "내 프로필 수정하기"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Functions

    private func setLayout() {
        self.addSubview(profile)
        self.addSubview(containerView)
        
        [name, desc].map {
            containerView.addArrangedSubview($0)
        }
        containerView.addSubview(name)
        containerView.addSubview(desc)
        
        profile.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        profile.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profile.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profile.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.profile.trailingAnchor, constant: 16).isActive = true
    }
}
