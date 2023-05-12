//
//  UserDefaultsSetting.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/10.
//

import Foundation

enum UserDefaultsSetting {
    
    @UserDefaultsWrapper(key: "isRegister", defaultValue: false)
    static var isRegister
    
    @UserDefaultsWrapper(key: "awayTime", defaultValue: 0)
    static var awayTime
    
    @UserDefaultsWrapper(key: "mainColor", defaultValue: "#FFD643")
    static var mainColor
    
    @UserDefaultsWrapper(key: "mainPet", defaultValue: "dog")
    static var mainPet
}
