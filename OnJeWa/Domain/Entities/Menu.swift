//
//  Menu.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/06/23.
//

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
