//
//  RegistrationViewModel.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/05.
//

import UIKit

import OnJeWaCore
import RxSwift
import RxCocoa

final class ChooseAnimalTypeViewModel: BaseViewModel {
    struct Input {
        let petTypeTrigger = PublishSubject<String>()
    }
    
    struct Output {
        let selectedPetType = BehaviorSubject<String>(value: "")
    }
    
    let input = Input()
    let output = Output()
    
    override init() { }
    
    override func bind() {
        self.input.petTypeTrigger
            .bind { [weak self] petType in
                self?.output.selectedPetType.onNext(petType)
            }
            .disposed(by: disposeBag)
    }
}
