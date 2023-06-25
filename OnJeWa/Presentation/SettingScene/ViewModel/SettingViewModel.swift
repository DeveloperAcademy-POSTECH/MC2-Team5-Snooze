//
//  SettingViewModel.swift
//  OnJeWa
//
//  Created by Eojin Choi on 2023/05/13.
//

import UIKit

import RxSwift
import RxCocoa
import OnJeWaCore

final class SettingViewModel: BaseViewModel {
	
	struct Input {
		let fetchTrigger = PublishSubject<Void>()
	}
	
	struct Output {
		let myProfileImage = PublishSubject<Data>()
		let myName = PublishSubject<String>()
	}
	
	let input = Input()
	var output = Output()
	
	override func bind() {
		self.input.fetchTrigger
			.bind {[weak self] in
				self?.output.myProfileImage.onNext(self?.userUseCase.readProfileImage() ?? Data())
				self?.output.myName.onNext(self?.petUseCase.readName() ?? "")
			}
			.disposed(by: disposeBag)
	}
	
	//MARK: - UseCase
	
	let userUseCase: UserUseCase = DefaultUserUseCase()
	let petUseCase: PetUseCase = DefaultPetUseCase()
}
