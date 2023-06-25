//
//  DefaultPetUseCase.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/06/22.
//

import Foundation

protocol PetUseCase {
	func readPetType() -> String
	func readName() -> String
}

final class DefaultPetUseCase: PetUseCase {
	
	let petRepository: PetRepository = DefaultPetRepository()
	
	func readPetType() -> String {
		return petRepository.readPetType()
	}
	
	func readName() -> String {
		return petRepository.readName()
	}
}
