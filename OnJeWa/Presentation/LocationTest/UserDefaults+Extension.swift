//
//  UserDefaults+Extension.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/04.
//

import Foundation


extension UserDefaults {
    static var shared: UserDefaults {
        let appGroupId = "group.com.wonniiii.onjewa"
        return UserDefaults(suiteName: appGroupId)!
    }
}
