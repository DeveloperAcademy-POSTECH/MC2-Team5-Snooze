//
//  RegistrationViewController.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/05.
//

import UIKit

import OnJeWaCore
import OnJeWaUI
import OnJeWaNetwork

final class ChoosePetTypeViewController: BaseViewController {
    
    //MARK: - Properties
    
    private let viewModel = ChoosePetTypeViewModel()
    private var profile = Profile()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Views
    
    private var registrationPages: [UIView] = []
    private let choosePetTypeView = ChoosePetTypeView()
    private let pageControl = OnJeWaPageControl(frame: CGRect.zero, entirePage: 4, currentPage: 1)
    
    //MARK: - Functions
    
    override func bindViewModel() {
        
        // Input
        
        choosePetTypeView.rx.didSelectPetType
            .bind { [weak self] petType in
                guard let petType else { return }
                self?.viewModel.input.petTypeTrigger.onNext(petType)
                self?.profile.petType = petType
            }
            .disposed(by: disposeBag)
        
        // Outpt
        
        viewModel.output.selectedPetType
            .bind { [weak self] petType in
                if petType != "" {
                    self?.choosePetTypeView.setupPetType(petType)
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func setupView() {
        choosePetTypeView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: pageControl)
        
        [choosePetTypeView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        NSLayoutConstraint.activate([
            choosePetTypeView.topAnchor.constraint(equalTo: view.topAnchor),
            choosePetTypeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            choosePetTypeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            choosePetTypeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension ChoosePetTypeViewController: ChoosePetTypeViewDelegate {
    func didTapNextButton() {
        let setProfileViewController = SetProfileViewController(profile: self.profile)
        self.navigationController?.pushViewController(setProfileViewController, animated: true)
    }
}
