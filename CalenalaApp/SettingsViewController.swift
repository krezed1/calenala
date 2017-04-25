//
//  SettingsViewController.swift
//  CalenalaApp
//
//  Created by Daniel Krezelok on 24/04/2017.
//  Copyright © 2017 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    var settings: Settings?
    var settingsView: SettingsView? {
        return self.view as? SettingsView
    }
    
//      MARK: LifeCycles
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = NSLocalizedString("Settings", comment: "SETTINGS_TITLE")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = SettingsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveButton = UIBarButtonItem(title: NSLocalizedString("Save", comment: "SAVE_BUTTON"),
                                         style: .plain,
                                        target: self,
                                        action: #selector(saveButtonDidPress))

        let cancelButton = UIBarButtonItem(title: NSLocalizedString("Cancel", comment: "CANCEL_BUTTON"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(cancelButtonDidPress))
        
        initializeSettings()
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }
    

//      MARK: UserActions
    
    func saveButtonDidPress() {
        let push: String = String(settingsView?.pushSwitch.isOn == true ? 1 : 0)
        let pushReacurring: String = String(settingsView?.pushReacurringSwitch.isOn == true ? 1 : 0)
        let email: String = String(settingsView?.emailNotificationSwitch.isOn == true ? 1 : 0)
        let pushLimit = settingsView?.pushLimitField.text
        
        Settings.saveUserSettings(push: push, pushReacurring: pushReacurring, emailNotification: email, pushLimit: pushLimit!) {

        }
    }
    
    func cancelButtonDidPress() {
        dismiss(animated: true, completion: nil)
    }
    
//      MARK: Private
    
    private func initializeSettings() {
        weak var weakSelf: SettingsViewController? = self
        Settings.loadUserSettings { (result) in
            if let settings = result {
                weakSelf?.settings = settings
                weakSelf?.settingsView?.pushSwitch.isOn = settings.pushBoolValue
                weakSelf?.settingsView?.pushReacurringSwitch.isOn = settings.pushReacurringBoolValue
                weakSelf?.settingsView?.emailNotificationSwitch.isOn = settings.emailNotificationBoolValue
                weakSelf?.settingsView?.pushLimitField.text = settings.pushMinlimit
            }
        }
    }
}
