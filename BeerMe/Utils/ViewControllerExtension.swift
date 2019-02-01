//
//  ViewControllerExtension.swift
//  BeerMe
//
//  Created by Scarpz on 01/02/19.
//  Copyright © 2019 scarpz. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Creates an Alert with a single Ok Button and an Ok Action
    ///
    /// - Parameters:
    ///   - title: Title of the Alert
    ///   - message: Message of the Alert
    ///   - okButton: Text to be in the Ok Button (Default is "Ok")
    ///   - okAction: Action to be in the Ok Button (Default is nil)
    func createAlert(title: String?, message: String?, okButton: String = "Ok", okAction: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okButton, style: .default, handler: okAction))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Creates an Alert with an Ok and Cancel Buttons its actions
    ///
    /// - Parameters:
    ///   - title: Title of the Alert
    ///   - message: Message of the Alert
    ///   - okButton: Text to be in the Ok Button (Default is "Ok")
    ///   - okAction: Action to be in the Ok Button
    ///   - cancelButton: Text to be in the Cancel Button (Default is "Cancel")
    ///   - cancelAction: Action to be in the Cancel Button (Default is nil)
    func createAlert(title: String?, message: String?, okButton: String = "Ok", okAction: ((UIAlertAction) -> Void)?, cancelButton: String = "Cancel", cancelAction: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelButton, style: .cancel, handler: cancelAction))
        alert.addAction(UIAlertAction(title: okButton, style: .default, handler: okAction))
        self.present(alert, animated: true, completion: nil)
    }
}
