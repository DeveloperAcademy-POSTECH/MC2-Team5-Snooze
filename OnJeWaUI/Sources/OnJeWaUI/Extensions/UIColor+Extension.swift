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
    case dog
    case cat
    case parrot
    case rabbit
    case namebackground
    case dogselect
    case main
    case slidepoint
    case button
    case camerabutton
    case loginblack
}

extension OnjewaColor {
    public var color: UIColor {
        switch self {
        case .mainBackground:
            return UIColor.onjewaColor(named: "mainBackground")
        case .dog:
            return UIColor.onjewaColor(named: "dog")
        case .cat:
            return UIColor.onjewaColor(named: "cat")
        case .parrot:
            return UIColor.onjewaColor(named: "parrot")
        case .rabbit:
            return UIColor.onjewaColor(named: "rabbit")
        case .namebackground:
            return UIColor.onjewaColor(named: "namebackground")
        case .dogselect:
            return UIColor.onjewaColor(named: "dogselect")
        case .main:
            return UIColor.onjewaColor(named: "main")
        case .slidepoint:
            return UIColor.onjewaColor(named: "slidepoint")
        case .button:
            return UIColor.onjewaColor(named: "button")
        case .camerabutton:
            return UIColor.onjewaColor(named: "camerabutton")
        case .loginblack:
            return UIColor.onjewaColor(named: "loginblack")
        }
    }
}

public func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
