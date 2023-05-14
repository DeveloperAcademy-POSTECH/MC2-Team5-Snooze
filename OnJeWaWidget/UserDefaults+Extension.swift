//
//  UserDefaults+Extension.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/14.
//

import Foundation
import UIKit

extension UserDefaults {
    static var shared: UserDefaults {
        let appGroupId = "group.OnjewaGroup"
        return UserDefaults(suiteName: appGroupId)!
    }
}
