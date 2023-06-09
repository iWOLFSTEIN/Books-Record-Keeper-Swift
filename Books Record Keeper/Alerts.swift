//
//  Alerts.swift
//  Books Record Keeper
//
//  Created by BrainX Technologies on 08/06/2023.
//

import UIKit

func showAlert(from viewController: UIViewController, withTitle title: String, andSubtitle subtitle: String, withCustomAction: (() -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
    }
    alertController.addAction(cancelAction)
    
    if let customAction = withCustomAction {
        let customAction = UIAlertAction(title: "Delete", style: .default) { _ in
            customAction()
        }
        alertController.addAction(customAction)
    }
    viewController.present(alertController, animated: true, completion: nil)
}
