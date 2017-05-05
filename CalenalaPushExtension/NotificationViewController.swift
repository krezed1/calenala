//
//  NotificationViewController.swift
//  CalenalaPushExtension
//
//  Created by Daniel Krezelok on 25/04/2017.
//  Copyright © 2017 Krezelok, Daniel. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import PureLayout

class NotificationViewController: UIViewController, UNNotificationContentExtension, UITextFieldDelegate {
    private let BUTTON_BACKGROUND_COLOR = UIColor(colorLiteralRed: 238/255 , green: 215/255, blue: 75/255, alpha: 1)

    @IBOutlet var commentField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commentField?.placeholder = NSLocalizedString("Tap here and write your comment", comment: "")
        commentField?.delegate = self
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        completion(UNNotificationContentExtensionResponseOption.dismiss)
    }
    
    func didReceive(_ notification: UNNotification) {
        print("userInfo\n" + notification.request.content.userInfo.description)
        commentField?.becomeFirstResponder()
    }
    
//  MARK UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
