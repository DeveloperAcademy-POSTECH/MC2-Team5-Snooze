//
//  File.swift
//  
//
//  Created by 최효원 on 2023/05/12.
//

import Foundation
import UIKit

extension UIImageView {
   public func makeBlur() {
    let blurEffect = UIBlurEffect(style: .regular)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
     blurEffectView.alpha = 0.3
    blurEffectView.frame = self.bounds
     blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.addSubview(blurEffectView)
  }
}
