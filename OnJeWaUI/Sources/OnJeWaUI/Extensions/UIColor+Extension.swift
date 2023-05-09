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


