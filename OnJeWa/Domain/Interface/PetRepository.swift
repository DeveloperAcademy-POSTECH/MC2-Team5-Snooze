//
//  PetRepository.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/06/22.
//

import Foundation

protocol PetRepository {
	func readPetType() -> String
	func readName() -> String
}
