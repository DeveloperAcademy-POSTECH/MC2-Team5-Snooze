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
        let yearTrigger = PublishSubject<String>()
        let monthTrigger = PublishSubject<String>()
        let dayTrigger = PublishSubject<String>()
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
        Observable.combineLatest(input.nameTrigger, input.yearTrigger, input.monthTrigger, input.dayTrigger, input.profileImageTrigger)
            .map { (name, year, month, day, profileImage) in
                let nameFlag = name == "" ? false : true
                let yearFlag = year == "" ? false : true
                let monthFlag = month == "" ? false : true
                let dayFlag = day == "" ? false : true
                return nameFlag && yearFlag && monthFlag && dayFlag && profileImage
            }
            .bind { [weak self] isEnabled in
                self?.output.nextButtonStatus.accept(isEnabled)
            }
            .disposed(by: disposeBag)
    }
}
