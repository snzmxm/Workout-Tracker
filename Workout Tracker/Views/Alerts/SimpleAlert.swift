//
//  SimpleAlert.swift
//  Workout Tracker
//
//  Created by SNZ on 09.11.2022.
//

import UIKit

extension UIViewController {

    func alertOk(tittle: String, message: String?) {

        let allertController = UIAlertController(title: tittle,
                                                 message: message,
                                                 preferredStyle: .alert)

        let ok = UIAlertAction(title: "OK", style: .default)
        allertController.addAction(ok)
        present(allertController, animated: true)
    }
}
