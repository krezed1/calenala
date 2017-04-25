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
    private static let BUTTON_OFF: UIImage = UIImage(named: "star-empty", in: nil, compatibleWith: nil)!
    private static let BUTTON_1: UIImage = UIImage(named: "star1-icon", in: nil, compatibleWith: nil)!
    private static let BUTTON_2: UIImage = UIImage(named: "star2-icon", in: nil, compatibleWith: nil)!
    private static let BUTTON_3: UIImage = UIImage(named: "star3-icon", in: nil, compatibleWith: nil)!
    private static let BUTTON_4: UIImage = UIImage(named: "star4-icon", in: nil, compatibleWith: nil)!
    private static let BUTTON_5: UIImage = UIImage(named: "star5-icon", in: nil, compatibleWith: nil)!

    @IBOutlet var commentField: UITextField?
    @IBOutlet var button1: UIButton?
    @IBOutlet var button2: UIButton?
    @IBOutlet var button3: UIButton?
    @IBOutlet var button4: UIButton?
    @IBOutlet var button5: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentField?.placeholder = NSLocalizedString("Tap here and write your comment", comment: "")

        button1?.setImage(NotificationViewController.BUTTON_OFF, for: .normal)
        button2?.setImage(NotificationViewController.BUTTON_OFF, for: .normal)
        button3?.setImage(NotificationViewController.BUTTON_OFF, for: .normal)
        button4?.setImage(NotificationViewController.BUTTON_OFF, for: .normal)
        button5?.setImage(NotificationViewController.BUTTON_OFF, for: .normal)
        
        button1?.setImage(NotificationViewController.BUTTON_1, for: .selected)
        button2?.setImage(NotificationViewController.BUTTON_2, for: .selected)
        button3?.setImage(NotificationViewController.BUTTON_3, for: .selected)
        button4?.setImage(NotificationViewController.BUTTON_4, for: .selected)
        button5?.setImage(NotificationViewController.BUTTON_5, for: .selected)
    }
    
    func didReceive(_ notification: UNNotification) {
//        self.label?.text = notification.request.content.body
    }

// MARK: UserActions
    
    @IBAction func button1DidPress() {
        button1?.isSelected = true
        button2?.isSelected = false
        button3?.isSelected = false
        button4?.isSelected = false
        button5?.isSelected = false
    }
    
    @IBAction func button2DidPress() {
        button1?.isSelected = true
        button2?.isSelected = true
        button3?.isSelected = false
        button4?.isSelected = false
        button5?.isSelected = false
    }
    
    @IBAction func button3DidPress() {
        button1?.isSelected = true
        button2?.isSelected = true
        button3?.isSelected = true
        button4?.isSelected = false
        button5?.isSelected = false
    }
    
    @IBAction func button4DidPress() {
        button1?.isSelected = true
        button2?.isSelected = true
        button3?.isSelected = true
        button4?.isSelected = true
        button5?.isSelected = false
    }
    
    @IBAction func button5DidPress() {
        button1?.isSelected = true
        button2?.isSelected = true
        button3?.isSelected = true
        button4?.isSelected = true
        button5?.isSelected = true
    }
}
