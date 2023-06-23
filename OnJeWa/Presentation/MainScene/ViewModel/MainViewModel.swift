//
//  MainViewModel.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/13.
//

import Foundation

import OnJeWaCore
import RxSwift
import RxCocoa
import RxRelay

final class MainViewModel: BaseViewModel {
  
  struct Input {
    let outTrigger = PublishSubject<Bool>()
    let inTrigger = PublishSubject<Bool>()
  }
  
  struct Output {
    let outResult = BehaviorSubject<Bool>(value: false)
    let inResult = BehaviorSubject<Bool>(value: false)
  }
  
  let input = Input()
  let output = Output()
  
  override init() { }
  
  override func bind() {
    
    self.input.outTrigger
      .bind { [weak self] value in
        // value -> 가공
        // 가공한 데이터를
        self?.output.outResult.onNext(value)
      }
      .disposed(by: disposeBag)
    
    
    self.input.inTrigger
      .bind { [weak self] value in
        self?.output.inResult.onNext(value)
      }
      .disposed(by: disposeBag)
  }
	
	//MARK: - UseCase
	
	let userUseCase: UserUseCase = DefaultUserUseCase()
	let petUseCase: PetUseCase = DefaultPetUseCase()
}
