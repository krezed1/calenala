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
    var passwordLabel: UILabel = UILabel()
    var passwordField: UITextField = UITextField()
    var loginButton: UIButton = UIButton(type: .custom)

    private var loginContentView: UIView = UIView()
    
    private let VERTICAL_INSET = UIScreen.main.bounds.size.height * 30/588
    
    private let TITLE_LABEL_FONT_SIZE = UIFont.systemFont(ofSize: 20)
    private let TEXT_COLOR = UIColor(colorLiteralRed: 102/255, green: 102/255, blue: 102/255, alpha: 1)
    private let FONT_AND_SIZE = UIFont.systemFont(ofSize: 16)
    private let TEXTFIELD_BORDER_WIDTH: CGFloat = 1
    private let TEXTFIELD_CORNER_RADIUS: CGFloat = 5
    private let TEXTFIELD_FONT_AND_SIZE = UIFont.systemFont(ofSize: 16)
    private let TEXTFIELD_BORDER_COLOR = UIColor(colorLiteralRed: 223/255, green: 223/255, blue: 223/255, alpha: 1)
    private let BUTTON_BACKGROUND_COLOR = UIColor(colorLiteralRed: 238/255 , green: 215/255, blue: 75/255, alpha: 1)

    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor(colorLiteralRed: 66/255, green: 189/255, blue: 216/255, alpha: 1)

        setUpView()
        layoutView()
        addAttributedTitleText()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//  MARK: Private

    private func setUpView() {
        loginContentView.addSubview(usernameLabel)
        loginContentView.addSubview(usernameField)
        loginContentView.addSubview(passwordLabel)
        loginContentView.addSubview(passwordField)
        loginContentView.addSubview(loginButton)

        addSubview(titleLabel)
        addSubview(loginContentView)
        
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = TITLE_LABEL_FONT_SIZE
        
        usernameLabel.text = NSLocalizedString("Your e-mail", comment: "")
        usernameLabel.textColor = TEXT_COLOR
        usernameLabel.textAlignment = .center
        usernameLabel.font = FONT_AND_SIZE

        usernameField.font = TEXTFIELD_FONT_AND_SIZE
        usernameField.layer.cornerRadius = TEXTFIELD_CORNER_RADIUS
        usernameField.layer.borderColor = TEXTFIELD_BORDER_COLOR.cgColor
        usernameField.layer.borderWidth = TEXTFIELD_BORDER_WIDTH
        
        passwordLabel.text = NSLocalizedString("Password", comment: "")
        passwordLabel.textColor = TEXT_COLOR
        passwordLabel.textAlignment = .center
        passwordLabel.font = FONT_AND_SIZE

        passwordField.font = TEXTFIELD_FONT_AND_SIZE
        passwordField.layer.cornerRadius = TEXTFIELD_CORNER_RADIUS
        passwordField.layer.borderColor = TEXTFIELD_BORDER_COLOR.cgColor
        passwordField.layer.borderWidth = TEXTFIELD_BORDER_WIDTH
        passwordField.isSecureTextEntry = true
    
        loginButton.setTitle(NSLocalizedString("Log in", comment: "LOGIN_BUTTON"), for: .normal)
        loginButton.backgroundColor = BUTTON_BACKGROUND_COLOR
        loginButton.setTitleColor(TEXT_COLOR, for: .normal)
        loginButton.titleLabel?.font = FONT_AND_SIZE

        loginContentView.backgroundColor = UIColor.white
    }

    private func layoutView() {
        
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        titleLabel.autoPinEdge(.bottom, to: .top, of: loginContentView, withOffset: -VERTICAL_INSET * 2)
        
        loginContentView.autoMatch(.width, to: .width, of: self, withMultiplier: 260/320)
        loginContentView.autoCenterInSuperview()

        usernameLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        usernameLabel.autoPinEdge(.top, to: .top, of: loginContentView, withOffset: VERTICAL_INSET)

        usernameField.autoPinEdge(.top, to: .bottom, of: usernameLabel, withOffset: 8)
        usernameField.autoAlignAxis(toSuperviewAxis: .vertical)
        usernameField.autoMatch(.width, to: .width, of: loginContentView, withMultiplier: 200/260)
        usernameField.autoMatch(.height, to: .width, of: loginContentView, withMultiplier: 30/260)
        
        passwordLabel.autoPinEdge(.top, to: .bottom, of: usernameField, withOffset: VERTICAL_INSET)
        passwordLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        passwordField.autoPinEdge(.top, to: .bottom, of: passwordLabel, withOffset: 8)
        passwordField.autoAlignAxis(toSuperviewAxis: .vertical)
        passwordField.autoMatch(.width, to: .width, of: usernameField)
        passwordField.autoMatch(.height, to: .height, of: usernameField)

        loginButton.autoPinEdge(.top, to: .bottom, of: passwordField, withOffset: VERTICAL_INSET * 1.5)
        loginButton.autoAlignAxis(toSuperviewAxis: .vertical)
        loginButton.autoMatch(.width, to: .width, of: loginContentView)
        loginButton.autoMatch(.height, to: .width, of: loginButton, withMultiplier: 50/260)
        loginButton.autoPinEdge(.bottom, to: .bottom, of: loginContentView)
        
    }
    
    private func addAttributedTitleText() {
        let amountText = NSMutableAttributedString(string: "CALENALA")
        
        // set the custom font and color for the 0,1 range in string
        amountText.setAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: 0.6)],
                                 range: NSMakeRange(0, 5))
        amountText.setAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 20)],
                                 range: NSMakeRange(5, 3))
        // if you want, you can add more attributes for different ranges calling .setAttributes many times
        
        // set the attributed string to the UILabel object
        titleLabel.attributedText = amountText
    }
}

