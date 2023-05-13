//
//  SettingViewModel.swift
//  OnJeWa
//
//  Created by Eojin Choi on 2023/05/13.
//

import Foundation
import UIKit

public enum MenuType {
    case profile
    case general
}

struct Menu {
    let profile: UIImage?
    let name: String
    let menuType: MenuType
}
