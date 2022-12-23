//
//  Int + Extensions.swift
//  Workout Tracker
//
//  Created by SNZ on 13.11.2022.
//

import Foundation

extension Int {

    func convertSeconds() -> (Int, Int) {
        let min = self / 60
        let sec = self % 60
        return (min, sec)
    }

    func setZeroForSecond() -> String {
        return (Double(self) / 10.0 < 1 ? "0\(self)" : "\(self)")
    }
}
