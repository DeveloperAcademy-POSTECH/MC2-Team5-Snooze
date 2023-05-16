//
//  UserDefaults+Extension.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/14.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
//        let appGroupId = "group.OnjewaGroup"
        let appGroupId = "group.OnjewaAzhy"
        return UserDefaults(suiteName: appGroupId)!
    }
}
