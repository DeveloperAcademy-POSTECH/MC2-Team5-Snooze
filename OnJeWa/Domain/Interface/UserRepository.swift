//
//  UserRepository.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/06/22.
//

import Foundation
import CoreLocation

import OnJeWaNetwork

protocol UserRepository {
	func getUserDates() -> [Profile]
	func readProfileImage() -> Data
	func readBackgroundImage() -> Data
	func readCoordinate() -> CLLocation
	func updateProfileImage(newProfileImage: Data) throws
	func updateBackgroundImage(newBackgroundImage: Data) throws
	func updateCoordinate(newCoordinate: CLLocation) throws
}
