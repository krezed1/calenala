//
//  SettingsView.swift
//  CalenalaApp
//
//  Created by Daniel Krezelok on 24/04/2017.
//  Copyright © 2017 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit

class SettingsView: UIView {

    var pushLabel: UILabel = UILabel()
    var pushReacurringLabel: UILabel = UILabel()
    var emailNotificationLabel: UILabel = UILabel()
    
    var pushSwitch: UISwitch = UISwitch()
    var pushReacurringSwitch: UISwitch = UISwitch()
    var emailNotificationSwitch: UISwitch = UISwitch()
    
    var pushLimitField: UITextField = UITextField()
    var pushLimitLabel: UILabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        setUpView()
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Private
    
    private func setUpView() {
        addSubview(pushSwitch)
        addSubview(pushReacurringSwitch)
        addSubview(pushLabel)
        addSubview(pushReacurringLabel)
        addSubview(pushLimitField)
        addSubview(emailNotificationLabel)
        addSubview(emailNotificationSwitch)
        
        pushLimitLabel.text = NSLocalizedString("Minimum people on meeting for push", comment: "MINIMUM_PEOPLE_LABEL")
        pushLimitLabel.frame = CGRect(x: 0, y: 0, width: 300, height: 20)
        pushLimitField.leftViewMode = .always
        pushLimitField.leftView = pushLimitLabel
        
        emailNotificationLabel.text = NSLocalizedString("Email Notifications", comment: "")
        pushLabel.text = NSLocalizedString("Push Notifications", comment: "")
        pushReacurringLabel.text = NSLocalizedString("Push reacurring label", comment: "")
        pushLimitField.keyboardType = .numberPad
    }
    
    private func layoutView() {
        pushSwitch.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        pushSwitch.autoPinEdge(toSuperviewEdge: .top, withInset: 80)
        
        pushLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 82)
        pushLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        
        pushReacurringSwitch.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        pushReacurringSwitch.autoPinEdge(.top, to: .bottom, of: pushSwitch, withOffset: 16)
        
        pushReacurringLabel.autoPinEdge(.top, to: .bottom, of: pushLabel, withOffset: 30)
        pushReacurringLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)

        emailNotificationSwitch.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        emailNotificationSwitch.autoPinEdge(.top, to: .bottom, of: pushReacurringSwitch, withOffset: 16)
        
        emailNotificationLabel.autoPinEdge(.top, to: .bottom, of: pushReacurringLabel, withOffset: 30)
        emailNotificationLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        
        pushLimitField.autoPinEdge(.top, to: .bottom, of: emailNotificationSwitch, withOffset: 16)
        pushLimitField.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        pushLimitField.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
    }
}
