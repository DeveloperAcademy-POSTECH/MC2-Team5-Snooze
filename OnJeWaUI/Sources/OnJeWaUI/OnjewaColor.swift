//
//  File.swift
//  
//
//  Created by 최효원 on 2023/05/08.
//

import Foundation
import UIKit
import OnJeWaUI


public enum OnjewaColor {
  case mainBackground
  
}


extension OnjewaColor {
  
  public var color: UIColor {
    switch self {
    case .mainBackground:
      return UIColor.onjewaColor(named: "mainBackground")
    }
  }
}
