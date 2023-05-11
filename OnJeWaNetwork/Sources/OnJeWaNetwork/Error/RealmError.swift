//
//  File.swift
//  
//
//  Created by Kim SungHun on 2023/05/10.
//

import Foundation

public enum RealmError: LocalizedError, Equatable {
    case createProfile
    
    case updatePetType
    case updateName
    case updateProfileImage
    case updateBackgroundImage
    case updateCoordinate
    
    public var errorDescription: String? {
        switch self {
        case .createProfile:
            return "profile 생성 에러"
        case .updatePetType:
            return "petType 업데이트 에러"
        case .updateName:
            return "name 업데이트 에러"
        case .updateProfileImage:
            return "profileImage 업데이트 에러"
        case .updateBackgroundImage:
            return "backgroundImage 업데이트 에러"
        case .updateCoordinate:
            return "coordinate 업데이트 에러"
        }
    }
}
