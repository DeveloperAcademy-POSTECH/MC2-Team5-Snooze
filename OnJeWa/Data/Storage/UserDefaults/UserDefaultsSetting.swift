//
//  UserDefaultsSetting.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/10.
//

import Foundation

enum UserDefaultsSetting {
    
    /// 등록을 했으면 true, 안했으면 false
    @UserDefaultsWrapper(key: "isRegister", defaultValue: false)
    static var isRegister
    
    /// 흘러간 시간
    @UserDefaultsWrapper(key: "awayTime", defaultValue: 0)
    static var awayTime
    
    /// 등록했을 때 선택한 동물에 맞는 메인 컬러
    @UserDefaultsWrapper(key: "mainColor", defaultValue: "#FFD643")
    static var mainColor
    
    /// 등록할 때 선택한 동물 ( dog, cat, parrot, rabbit )
    @UserDefaultsWrapper(key: "mainPet", defaultValue: "dog")
    static var mainPet
    
    @UserDefaultsWrapper(key: "mainType", defaultValue: "none")
    static var mainType
    
}
