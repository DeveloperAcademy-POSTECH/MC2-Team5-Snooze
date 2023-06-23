//
//  DefaultUserRepository.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/06/22.
//

import Foundation
import CoreLocation

import OnJeWaNetwork

protocol UserUseCase {
	func createProfile(profile: Profile) async throws
	func getUserDates() -> [Profile]
	func readProfileImage() -> Data
	func readBackgroundImage() -> Data
	func readCoordinate() -> CLLocation
	func updateProfileImage(newProfileImage: Data) throws
	func updateBackgroundImage(newBackgroundImage: Data) throws
	func updateCoordinate(newCoordinate: CLLocation) throws
}

final class DefaultUserUseCase: UserUseCase {

	let userRepository: UserRepository = DefaultUserRepository()
	
	func createProfile(profile: Profile) async throws {
		try await userRepository.createProfile(profile: profile)
	}
	
	func getUserDates() -> [Profile] {
		return userRepository.getUserDates()
	}
	
	func readProfileImage() -> Data {
		return userRepository.readProfileImage()
	}
	
	func readBackgroundImage() -> Data {
		return userRepository.readBackgroundImage()
	}
	
	func readCoordinate() -> CLLocation {
		return userRepository.readCoordinate()
	}
	
	func updateProfileImage(newProfileImage: Data) throws {
		try userRepository.updateProfileImage(newProfileImage: newProfileImage)
	}
	
	func updateBackgroundImage(newBackgroundImage: Data) throws {
		try userRepository.updateBackgroundImage(newBackgroundImage: newBackgroundImage)
	}
	
	func updateCoordinate(newCoordinate: CLLocation) throws {
		try userRepository.updateCoordinate(newCoordinate: newCoordinate)
	}
}
