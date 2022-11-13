//
//  OkCancelAlert.swift
//  Workout Tracker
//
//  Created by SNZ on 12.11.2022.
//

import UIKit

extension UIViewController {

    func alertOkCancel(title: String, message: String?, completionHandler: @escaping () -> Void) {

        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler()
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(ok)
        alertController.addAction(cancel)

        present(alertController, animated: true)
    }
}
