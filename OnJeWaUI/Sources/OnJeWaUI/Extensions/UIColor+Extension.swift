//
//  File.swift
//
//
//  Created by 최효원 on 2023/05/08.
//

import Foundation
import UIKit

extension UIColor {
    // Asset에 등록된 Color 불러오는 메서드
    static func onjewaColor(named: String) -> UIColor {
        guard let color = UIColor(named: named, in: .module, compatibleWith: nil) else {
            return .clear
        }
        return color
    }
}

public enum OnjewaColor {
    case mainBackground
    case primary
    case gray1
}

extension OnjewaColor {
    public var color: UIColor {
        switch self {
        case .mainBackground:
            return UIColor.onjewaColor(named: "mainBackground")
        case .primary:
            return UIColor.onjewaColor(named: "primary")
        case .gray1:
            return UIColor.onjewaColor(named: "gray1")
        }
    }
}
