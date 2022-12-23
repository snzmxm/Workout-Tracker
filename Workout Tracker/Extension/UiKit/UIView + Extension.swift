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

    convenience init(backgroundColor: UIColor, cornerRadius: CGFloat = 0) {
        self.init()
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
//private let addPhotoView: UIView = {
//    let view = UIView()
//    view.backgroundColor = .specialGreen
//    view.layer.cornerRadius = 10
//    view.translatesAutoresizingMaskIntoConstraints = false
//    return view
//}()
