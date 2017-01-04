//
//  LoginViewController.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 03/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import UserNotifications

class LoginViewController: UIViewController {
    
    var loginView: LoginView? {
        return view as? LoginView
    }

// MARK: LifeCycles

    override func loadView() {
        super.loadView()

        view = LoginView()
    }

    override func viewDidLoad() {
        loginView?.loginButton.addTarget(self, action: #selector(LoginViewController.loginButtonDidPress), for: .touchUpInside)
    }

// MARK: UserActions

    func loginButtonDidPress() {

        guard let username = loginView?.usernameField.text, let password = loginView?.passwordField.text else {
            return
        }

        let hud = MBProgressHUD.showAdded(to: loginView!, animated: true)
        hud.mode = .indeterminate

        weak var weakSelf = self
        User.login(username: username, password: password, completion: {
            hud.hide(animated: true)
            let meetingsViewController = MeetingsViewController()
            let navigationController = UINavigationController(rootViewController: meetingsViewController)
            weakSelf!.present(navigationController, animated: true, completion: nil)
            weakSelf?.initializeNotifications()
        })
    }

//  MARK: Private

    private func initializeNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        }

        UIApplication.shared.registerForRemoteNotifications()
    }
}
