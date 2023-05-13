//
//  NotificationViewController.swift
//  OnJeWa
//
//  Created by Eojin Choi on 2023/05/13.
//

import UIKit

import OnJeWaCore

final class NotificationViewController: UIViewController {
    
    // MARK: - View Components
    
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
        tableView.register(NotificationViewChatCell.self, forCellReuseIdentifier: NotificationViewChatCell.cellId)
        tableView.register(NotificationViewInvitationCell.self, forCellReuseIdentifier: NotificationViewInvitationCell.cellId)
        tableView.register(NotificationViewMissionCell.self, forCellReuseIdentifier: NotificationViewMissionCell.cellId)

    }
    
    // MARK: - Functions
    
    func setUpNavigation() {
        navigationItem.title = "알림"
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = menus[indexPath.row]
        
        switch cellModel.notificationType {
        case .chat:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationViewChatCell.cellId, for: indexPath)
                        as? NotificationViewChatCell else {
                    print("Failed to dequeue NotificationViewChatCell.")
                    return UITableViewCell()
                }
                
                cell.selectionStyle = .none
                cell.profile.image = UIImage(named: cellModel.profile)
                cell.contentLabel.text = cellModel.content
                cell.timeLabel.text = cellModel.time

                return cell

        case .invitation:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationViewInvitationCell.cellId, for: indexPath)
                    as? NotificationViewInvitationCell else {
                print("Failed to dequeue NotificationViewInvitationCell.")
                return UITableViewCell()
            }

            cell.selectionStyle = .none
            cell.profile.image = UIImage(named: cellModel.profile)
            cell.contentLabel.text = "\(cellModel.content)님이 앨범에 초대했어요.\n수락하시겠습니까?"
            cell.timeLabel.text = cellModel.time

            return cell
            
        case .mission:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationViewMissionCell.cellId, for: indexPath)
                    as? NotificationViewMissionCell else {
                print("Failed to dequeue NotificationViewMissionCell.")
                return UITableViewCell()
            }

            cell.selectionStyle = .none
            cell.profile.image = UIImage(named: cellModel.profile)
            cell.contentLabel.text = "\(cellModel.content)님이 미션을 완료한 사진이 앨범에 등록됐어요."
            cell.timeLabel.text = cellModel.time
            cell.missionImage.image = UIImage(named: cellModel.image!)

            return cell
        }

    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cellModel = menus[indexPath.row]
//
//        switch cellModel.menuType {
//        case .profile:
            return 92
//        case .general:
//            return 60
//        }
    }
}
