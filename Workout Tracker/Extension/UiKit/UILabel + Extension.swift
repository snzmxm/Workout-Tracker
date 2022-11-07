//
//  UILabel + Extension.swift
//  Workout Tracker
//
//  Created by SNZ on 06.11.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String = "") {
        self.init()

        self.text = text
        self.font = .robotoMedium14()
        self.textColor = .specialLightBrown
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    convenience init(text: String = "", font: UIFont?, textColor: UIColor, textAlignment: NSTextAlignment = .left) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
