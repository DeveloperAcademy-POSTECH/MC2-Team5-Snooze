//
//  RegisterAddressViewModel.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/08.
//

import UIKit

import OnJeWaCore
import OnJeWaNetwork
import RxSwift
import RxCocoa

final class RegisterAddressViewModel: BaseViewModel {
	
	//MARK: - UseCase
	
	let userUseCase: UserUseCase = DefaultUserUseCase()
	
	// MARK: - Task
	
	private var userTask: Task<Void, Error>?
}
