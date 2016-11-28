//
//  UIViewController+Alert.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 28/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(message, comment: ""), preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }

        self.present(alert, animated: true, completion: nil)
    }
}
