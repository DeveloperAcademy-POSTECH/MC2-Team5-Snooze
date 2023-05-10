//
//  UserDefaultsSetting.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/10.
//

import Foundation

enum UserDefaultsSetting {
    
    @UserDefaultsWrapper(key: "UUID", defaultValue: "")
    static var UUID
    
    @UserDefaultsWrapper(key: "awayTime", defaultValue: 0)
    static var awayTime
}
