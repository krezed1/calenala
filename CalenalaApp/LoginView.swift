//
//  LoginView.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 03/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class LoginView: UIView {

    var usernameField: UITextField?
    var passwordField: UITextField?
    var loginButton: UIButton?
    private var loginContentView: UIView?

    private var didSetupConstraints = false

    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white

        usernameField = UITextField()
        passwordField = UITextField()
        passwordField?.isSecureTextEntry = true

        usernameField?.font = UIFont.systemFont(ofSize: 16)
        passwordField?.font = UIFont.systemFont(ofSize: 16)

        usernameField?.placeholder = NSLocalizedString("example@mail.com", comment: "USERNAME_FIELD")
        passwordField?.placeholder = NSLocalizedString("password", comment: "PASSWORD_FIELD")

        loginButton = UIButton(type: .custom)
        loginButton?.setTitle(NSLocalizedString("Login", comment: "LOGIN_BUTTON"), for: .normal)
        loginButton?.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        loginButton?.backgroundColor = UIColor.darkGray

        loginContentView = UIView()

        loginContentView?.addSubview(usernameField!)
        loginContentView?.addSubview(passwordField!)
        loginContentView?.addSubview(loginButton!)

        self.addSubview(loginContentView!)

        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {

        if didSetupConstraints == false {
            didSetupConstraints = true

            usernameField?.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
            usernameField?.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
            usernameField?.autoPinEdge(toSuperviewEdge: .right, withInset: 16)

            passwordField?.autoPinEdge(.top, to: .bottom, of: usernameField!, withOffset: 8)
            passwordField?.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
            passwordField?.autoPinEdge(toSuperviewEdge: .right, withInset: 16)

            loginButton?.autoPinEdge(.top, to: .bottom, of: passwordField!, withOffset: 64)
            loginButton?.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
            loginButton?.autoPinEdge(toSuperviewEdge: .right, withInset: 16)

            loginButton?.autoPinEdge(.bottom, to: .bottom, of: loginContentView!, withOffset: 0)

            loginContentView?.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
            loginContentView?.autoPinEdge(toSuperviewEdge: .right, withInset: 0)

            loginContentView?.autoAlignAxis(toSuperviewAxis: .horizontal)
        }

        super.updateConstraints()
    }
}

