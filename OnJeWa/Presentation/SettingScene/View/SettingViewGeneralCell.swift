//
//  SettingViewGeneralCell.swift
//  OnJeWa
//
//  Created by Eojin Choi on 2023/05/13.
//

import UIKit

final class SettingViewGeneralCell: SettingViewCell {
    // MARK: - UI Components
    
    public let name: UILabel = {
        let label = UILabel()
        label.text = "샘플 텍스트"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black
        return label
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.addSubview(name)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        name.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        name.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}
