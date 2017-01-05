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
        
        let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""),
                                     style: .cancel,
                                     handler: nil)
        if username.isEmpty {
            self.showAlert(title: "Empty email", message: "please enter email", actions: [okAction])
        } else if !validateEmail(candidate: username) {
            self.showAlert(title: "Invalid email", message: "please enter valid email", actions: [okAction])
        } else if password.isEmpty {
                self.showAlert(title: "Empty password", message: "please enter password", actions: [okAction])
                }

        let hud = MBProgressHUD.showAdded(to: loginView!, animated: true)
        hud.mode = .indeterminate

        weak var weakSelf = self
        User.login(username: username, password: password, completion: { (result) in
            hud.hide(animated: true)
            if result == true {
                let meetingsViewController = MeetingsViewController()
                let navigationController = UINavigationController(rootViewController: meetingsViewController)
                weakSelf!.present(navigationController, animated: true, completion: nil)
                weakSelf?.initializeNotifications()
            } else {
                let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: "")
                    , style: .cancel
                    , handler: nil)
                weakSelf?.showAlert(title: "Error", message: "Please try again later", actions: [okAction])
            }
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
    
    private func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
}
