//
//  DefaultUserRepository.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/06/22.
//

import Foundation
import CoreLocation

import OnJeWaNetwork

final class DefaultUserRepository: UserRepository {

	func getUserDates() -> [Profile] {
		RealmManager.shared.getUserDatas()
	}
	
	func readProfileImage() -> Data {
		RealmManager.shared.readProfileImage()
	}
	
	func readBackgroundImage() -> Data {
		RealmManager.shared.readBackgroundImage()
	}
	
	func readCoordinate() -> CLLocation {
		RealmManager.shared.readCoordinate()
	}
	
	func updateProfileImage(newProfileImage: Data) throws {
		try RealmManager.shared.updateProfileImage(newProfileImage: newProfileImage)
	}
	
	func updateBackgroundImage(newBackgroundImage: Data) throws {
		try RealmManager.shared.updateBackgroundImage(newBackgroundImage: newBackgroundImage)
	}
	
	func updateCoordinate(newCoordinate: CLLocation) throws {
		try RealmManager.shared.updateCoordinate(newCoordinate: newCoordinate)
	}
}
