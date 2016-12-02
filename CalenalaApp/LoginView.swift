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

    var titleLabel: UILabel = UILabel()
    var usernameLabel: UILabel = UILabel()
    var usernameField: UITextField = UITextField()
    var passwordField: UITextField = UITextField()
    var loginButton: UIButton = UIButton(type: .custom)

    private var loginContentView: UIView = UIView()

    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor(colorLiteralRed: 66/255, green: 189/255, blue: 216/255, alpha: 1)

        setUpView()
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//  MARK: Private

    private func setUpView() {
        loginContentView.addSubview(usernameLabel)
        loginContentView.addSubview(usernameField)
        loginContentView.addSubview(loginButton)

        addSubview(titleLabel)
        addSubview(loginContentView)

        passwordField.isSecureTextEntry = true

        usernameField.font = UIFont.systemFont(ofSize: 16)
        usernameField.layer.cornerRadius = 5
        usernameField.layer.borderColor = UIColor(colorLiteralRed: 223/255, green: 223/255, blue: 223/255, alpha: 1).cgColor
        usernameField.layer.borderWidth = 1

        passwordField.font = UIFont.systemFont(ofSize: 16)

        titleLabel.text = NSLocalizedString("CALENALA", comment: "")
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 17)

        usernameLabel.text = NSLocalizedString("Your e-mail", comment: "")
        usernameLabel.textColor = UIColor(colorLiteralRed: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        usernameLabel.textAlignment = .center
        usernameLabel.font = UIFont.systemFont(ofSize: 15)

        loginButton.setTitle(NSLocalizedString("Log in", comment: "LOGIN_BUTTON"), for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        loginButton.backgroundColor = UIColor(colorLiteralRed: 238/255 , green: 215/255, blue: 75/255, alpha: 1)
        loginButton.setTitleColor(UIColor(colorLiteralRed: 102/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)

        loginContentView.backgroundColor = UIColor.white
    }

    private func layoutView() {


        usernameLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        usernameLabel.autoPinEdge(.bottom, to: .top, of: usernameField, withOffset: -17)

        usernameField.autoAlignAxis(toSuperviewAxis: .horizontal)
        usernameField.autoPinEdge(toSuperviewEdge: .left, withInset: 30)
        usernameField.autoPinEdge(toSuperviewEdge: .right, withInset: 30)
        usernameField.autoSetDimension(.height, toSize: 30)
        
//        passwordField?.autoPinEdge(.top, to: .bottom, of: usernameField!, withOffset: 8)
//        passwordField?.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
//        passwordField?.autoPinEdge(toSuperviewEdge: .right, withInset: 16)

        loginButton.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        loginButton.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        loginButton.autoPinEdge(.bottom, to: .bottom, of: loginContentView, withOffset: 0)
        loginButton.autoSetDimension(.height, toSize: 50)

        loginContentView.autoPinEdge(toSuperviewEdge: .left, withInset: 30)
        loginContentView.autoPinEdge(toSuperviewEdge: .right, withInset: 30)

        loginContentView.autoAlignAxis(toSuperviewAxis: .horizontal)
        loginContentView.autoMatch(.height, to: .width, of: loginContentView, withMultiplier: 0.66)
    }
}

