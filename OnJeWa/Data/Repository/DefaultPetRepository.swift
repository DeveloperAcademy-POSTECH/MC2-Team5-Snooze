//
//  DefaultPetRepository.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/06/22.
//

import Foundation

import OnJeWaNetwork

final class DefaultPetRepository: PetRepository {
	func readPetType() -> String {
		RealmManager.shared.readPetType()
	}
	
	func readName() -> String {
		RealmManager.shared.readName()
	}
}
