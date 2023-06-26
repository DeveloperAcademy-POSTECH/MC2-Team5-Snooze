//
//  SettingViewController.swift
//  OnJeWa
//
//  Created by Eojin Choi on 2023/05/11.
//

import UIKit

import OnJeWaCore
import OnJeWaNetwork

final class SettingViewController: BaseViewController {
	
	//MARK: - Properties
	
	let viewModel = SettingViewModel()
	
	// MARK: - Views
	
	let tableView = UITableView()
	
	// MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.setNavigationBarHidden(false, animated: true)
		configureNavigationBar()
	}
	
	// MARK: - Model
	
	private var menus: [Menu] = []
	
	// MARK: - Functions
	
	override func setLayout() {
		view.addSubview(tableView)
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
	}
	
	override func setupView() {
		menus = [
			Menu(profile: UIImage(data: viewModel.userUseCase.readProfileImage()),
				 name: viewModel.petUseCase.readName(), menuType: .profile),
			Menu(profile: nil, name: "좌표 변경", menuType: .general),
			Menu(profile: nil, name: "알림설정", menuType: .general),
			Menu(profile: nil, name: "앱 버전", menuType: .general),
			Menu(profile: nil, name: "개발자 정보", menuType: .general),
		]
		
		navigationItem.title = "설정"
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(SettingViewProfileCell.self, forCellReuseIdentifier: "ProfileCell")
		tableView.register(SettingViewGeneralCell.self, forCellReuseIdentifier: "GeneralCell")
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
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
					as? SettingViewProfileCell else {
				return UITableViewCell()
			}
			
			cell.profile.image = cellModel.profile
			cell.name.text = cellModel.name
			cell.selectionStyle = .none
			
			return cell
			
		case .general:
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralCell", for: indexPath)
					as? SettingViewGeneralCell else {
				return UITableViewCell()
			}
			
			cell.name.text = cellModel.name
			cell.selectionStyle = .none
			
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
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath, animated: true)
		
		if indexPath.row == 0 {
			let profile = Profile(value: RealmManager.shared.getUserDatas().first!)
			let controller = SetProfileViewController(profile: profile)
			controller.updateChk = true
			navigationController?.pushViewController(controller, animated: true)
		}
	}
}
