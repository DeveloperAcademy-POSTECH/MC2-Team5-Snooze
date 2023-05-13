//
//  SettingViewController.swift
//  OnJeWa
//
//  Created by Eojin Choi on 2023/05/11.
//

import UIKit

import OnJeWaCore

final class SettingViewController: UIViewController {
    
    // MARK: - Views

    let tableView = UITableView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingViewProfileCell.self, forCellReuseIdentifier: "ProfileCell")
        tableView.register(SettingViewGeneralCell.self, forCellReuseIdentifier: "GeneralCell")

    }
    
    // MARK: - Model

    private let menus: [Menu] = [
        Menu(profile: UIImage(named: "IMG_2"), name: "복순", menuType: .profile),
        Menu(profile: nil, name: "알림설정", menuType: .general),
        Menu(profile: nil, name: "피드백 & 도움말", menuType: .general),
        Menu(profile: nil, name: "앱 버전", menuType: .general),
        Menu(profile: nil, name: "정보 제공", menuType: .general),
        Menu(profile: nil, name: "개발자 정보", menuType: .general),
    ]
    
    // MARK: - Functions
    
    func setUpNavigation() {
        navigationItem.title = "설정"
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = menus[indexPath.row]
        
        switch cellModel.menuType {
        case .profile:
            print("Profile Menu()")

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
                    as? SettingViewProfileCell else {
                print("Failed to dequeue SettingViewProfileCell.")
                return UITableViewCell()
            }

            cell.profile.image = cellModel.profile
            cell.name.text = cellModel.name

            return cell

        case .general:
            print("General Menu()")

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralCell", for: indexPath)
                    as? SettingViewGeneralCell else {
                print("Failed to dequeue SettingViewGeneralCell.")
                return UITableViewCell()
            }

            cell.name.text = cellModel.name

            return cell
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellModel = menus[indexPath.row]
        
        switch cellModel.menuType {
        case .profile:
            return 92
        case .general:
            return 60
        }
    }
}
