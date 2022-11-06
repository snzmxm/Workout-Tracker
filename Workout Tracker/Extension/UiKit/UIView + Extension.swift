//
//  UIView + Extension.swift
//  Workout Tracker
//
//  Created by SNZ on 05.11.2022.
//

import UIKit
//Расширение для тени
extension UIView {
    func addShadowOnView() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 1.0
    }
}
