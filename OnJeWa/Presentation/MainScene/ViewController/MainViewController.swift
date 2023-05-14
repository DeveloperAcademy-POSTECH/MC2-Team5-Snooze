//
//  MainViewController.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/04.
//

import UIKit
import OnJeWaCore
import OnJeWaUI

class MainViewController: BaseViewController {
    
    //MARK: - Properties
    
    let viewModel = MainViewModel()
    
    //MARK: - View Components
    
    private let backgroundView = BackgroundView()
    private let navigationView = NavigationView()
    private let weekCollectionView = WeekCollectionView()
    private let tapButtonVC = TapButtonViewController()
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tapButtonVC.delegate = self // 내가 대신 하겠다
        navigationView.delegate = self
        weekCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true) // 뷰 컨트롤러가 나타날 때 숨기기
    }
    
    override func bindViewModel() {
        
        self.viewModel.output.outResult
            .bind { [weak self] value in
                if value  {
                    switch UserDefaultsSetting.mainPet {
                    case "dog":
                        self?.tapButtonVC.homeOutButton.setImage(UIImage(named: "homeoutClicked"),
                                                                 for: .normal)
                        break
                    case "cat":
                        self?.tapButtonVC.homeOutButton.setImage(UIImage(named: "homeout3"),
                                                                 for: .normal)
                        break
                    case "parrot":
                        self?.tapButtonVC.homeOutButton.setImage(UIImage(named: "homeout4"),
                                                                 for: .normal)
                        break
                    case "rabbit":
                        self?.tapButtonVC.homeOutButton.setImage(UIImage(named: "homeout2"),
                                                                 for: .normal)
                        break
                    default:
                        break
                    }
                    self?.tapButtonVC.tapPositionImageView.image = UIImage(named: "rightlight")
                } else {
                    if UserDefaultsSetting.mainType != "work" {
                        self?.tapButtonVC.homeOutButton.setImage(UIImage(named: "homeoutUnClicked"),
                                                                 for: .normal)
                    }
                    self?.tapButtonVC.tapPositionImageView.image = UIImage(named: "leftlight")
                }
            }
            .disposed(by: disposeBag)
        
        self.viewModel.output.inResult
            .bind {[weak self] value in
                if value {
                    switch UserDefaultsSetting.mainPet {
                    case "dog":
                        self?.tapButtonVC.homeInButton.setImage(UIImage(named: "homeinClicked"), for: .normal)
                        break
                    case "cat":
                        self?.tapButtonVC.homeInButton.setImage(UIImage(named: "homein3"), for: .normal)
                        break
                    case "parrot":
                        self?.tapButtonVC.homeInButton.setImage(UIImage(named: "homein4"), for: .normal)
                        break
                    case "rabbit":
                        self?.tapButtonVC.homeInButton.setImage(UIImage(named: "homein2"), for: .normal)
                        break
                    default:
                        break
                    }
                }else {
                    if UserDefaultsSetting.mainType != "leave" {
                        self?.tapButtonVC.homeInButton.setImage(UIImage(named: "homeinUnClicked"), for: .normal)
                    }
                }
                
            }
            .disposed(by: disposeBag)
    }
    
    override func setupView() {
        //MARK: 수정 - 배경 색상 변경 필요
        view.backgroundColor = .white
        [navigationView, tapButtonVC.view, weekCollectionView].forEach {
            backgroundView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
    }
    
    override func setLayout() {
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4.adjusted),
            navigationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 38.adjusted),
            navigationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -38.adjusted),
            navigationView.heightAnchor.constraint(equalToConstant: 29.adjusted)
        ])
        
        NSLayoutConstraint.activate([
            tapButtonVC.view.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 63.adjusted),
            tapButtonVC.view.bottomAnchor.constraint(equalTo: weekCollectionView.topAnchor, constant: -65.adjusted),
            tapButtonVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 45.adjusted),
            tapButtonVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -39.adjusted),
        ])
        NSLayoutConstraint.activate([
            weekCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 42.adjusted),
            weekCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -42.adjusted),
            weekCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16.adjusted),
            weekCollectionView.heightAnchor.constraint(equalToConstant: 64.adjusted)
        ])
    }
}

extension MainViewController: TapButtonViewDelegate {
    func didTapButton(value: String) {
        if value == "in" {
            let sheet = UIAlertController(title: "집에 돌아오셨나요?", message: "나의 반려동물과\n 즐거운 시간을 보내세요!", preferredStyle: .alert)
            sheet.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { _ in
                self.viewModel.input.inTrigger.onNext(true)
                self.viewModel.input.outTrigger.onNext(false)
            }))
            sheet.addAction(UIAlertAction(title: "취소", style: .cancel))
            present(sheet, animated: true)
        } else {
            // Out
            let sheet = UIAlertController(title: "밖으로 외출하시나요?", message: "반려동물이 집에서 기다리고\n 있으니 빨리 다녀오세요!", preferredStyle: .alert)
            sheet.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { _ in
                self.viewModel.input.outTrigger.onNext(true)
                self.viewModel.input.inTrigger.onNext(false)
                
            }))
            sheet.addAction(UIAlertAction(title: "취소", style: .cancel))
            present(sheet, animated: true)
        }
    }
}

extension MainViewController: NavigationViewDelegate, WeekCollectionViewDelegate {
    func didTapAlbum() {
        let drawerViewController = DrawerViewController()
        self.navigationController?.pushViewController(drawerViewController, animated: true)
    }
    
    func didTapNoti() {
        let notificationViewController = NotificationViewController()
        self.navigationController?.pushViewController(notificationViewController, animated: true)
    }
    
    func didTapProfile() {
        let settingViewController = SettingViewController()
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    func didTapMission() {
        let mission = MissionViewController()
        self.navigationController?.pushViewController(mission, animated: true)
    }
}
