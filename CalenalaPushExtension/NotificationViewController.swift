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

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }

}
