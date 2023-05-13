//
//  SetProfileViewModel.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/06.
//

import UIKit

import OnJeWaCore
import RxSwift
import RxCocoa

final class SetProfileViewModel: BaseViewModel {
    struct Input {
        let profileImageTrigger = PublishSubject<Bool>()
        let nameTrigger = PublishSubject<String>()
    }
    
    struct Output {
        let nextButtonStatus = BehaviorRelay<Bool>(value: false)
    }
    
    let input = Input()
    let output = Output()
    
    override init() {
        super.init()
    }
    
    override func bind() {
        Observable.combineLatest(input.nameTrigger, input.profileImageTrigger)
            .map { (name, profileImage) in
                let nameFlag = name == "" ? false : true
                return nameFlag && profileImage
            }
            .bind { [weak self] isEnabled in
                self?.output.nextButtonStatus.accept(isEnabled)
            }
            .disposed(by: disposeBag)
    }
}
