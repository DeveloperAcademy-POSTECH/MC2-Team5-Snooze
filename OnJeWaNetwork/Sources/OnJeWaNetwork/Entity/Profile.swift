//
//  File.swift
//  
//
//  Created by Kim SungHun on 2023/05/10.
//

import UIKit
import CoreLocation
import RealmSwift

public class Profile: Object {
    @objc public dynamic var petType: String?
    @objc public dynamic var profileImage: Data?
    @objc public dynamic var name: String?
    @objc public dynamic var year: String?
    @objc public dynamic var month: String?
    @objc public dynamic var day: String?
    @objc public dynamic var backgroundImage: Data?
    @objc public dynamic var latitude = 0.0
    @objc public dynamic var longitude = 0.0
}
