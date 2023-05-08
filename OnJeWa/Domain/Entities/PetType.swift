//
//  AnimalType.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/05.
//

import Foundation

enum PetType: String, CaseIterable {
    case dog
    case cat
    case parrot
    case rabbit
    case none
    
    var description: String {
        switch self {
        case .dog:
            return "강아지"
        case .cat:
            return "고양이"
        case .parrot:
            return "앵무새"
        case .rabbit:
            return "토끼"
        case .none:
            return "선택안함"
        }
    }
}
