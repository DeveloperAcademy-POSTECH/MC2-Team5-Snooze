//
//  RegistrationViewController.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/05.
//

import UIKit

import OnJeWaCore
import OnJeWaUI

final class ChooseAnimalTypeViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var viewModel = ChooseAnimalTypeViewModel()
    private var profile = Profile()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseAnimalTypeView.delegate = self
    }
    
    //MARK: - Views

    private var registrationPages: [UIView] = []
    private let chooseAnimalTypeView = ChooseAnimalTypeView()
    private let pageControl = OnJeWaPageControl(frame: CGRect.zero, entirePage: 4, currentPage: 1)
    
    //MARK: - Functions
    
    override func setupView() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: pageControl)
        
        [chooseAnimalTypeView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        chooseAnimalTypeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chooseAnimalTypeView.topAnchor.constraint(equalTo: view.topAnchor),
            chooseAnimalTypeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            chooseAnimalTypeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chooseAnimalTypeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func bindViewModel() {
        
        // Input
        
        chooseAnimalTypeView.rx.didSelectPetType
            .bind { [weak self] petType in
                guard let petType else { return }
                self?.viewModel.input.petTypeTrigger.onNext(petType)
                self?.profile.animalType = petType
            }
            .disposed(by: disposeBag)
        
        // Outpt
        
        viewModel.output.selectedPetType
            .bind { [weak self] petType in
                if petType != "" {
                    self?.chooseAnimalTypeView.setupPetType(petType)
                }
            }
            .disposed(by: disposeBag)
    }
}

extension ChooseAnimalTypeViewController: ChooseAnimalTypeViewDelegate {
    func didTapNextButton() {
        let setProfileViewController = SetProfileViewController(profile: self.profile)
        self.navigationController?.pushViewController(setProfileViewController, animated: true)
    }
}
