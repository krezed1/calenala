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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let password = UserDefaults.standard.object(forKey: "password") as? String,
            let username = UserDefaults.standard.object(forKey: "username") as? String {
            loginView?.usernameField.text = username
            loginView?.passwordField.text = password

            loginButtonDidPress()
        }
    }

// MARK: UserActions

    func loginButtonDidPress() {
        let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""),
                                     style: .cancel,
                                     handler: nil)

        guard let username = loginView?.usernameField.text, let password = loginView?.passwordField.text, username.characters.count > 0, password.characters.count > 0 else {
            self.showAlert(title: "Invalid email", message: "Please fill all fields", actions: [okAction])
            return
        }
        
        if !validateEmail(candidate: username) {
            self.showAlert(title: "Invalid email", message: "Please enter valid email", actions: [okAction])
        }

        let hud = MBProgressHUD.showAdded(to: loginView!, animated: true)
        hud.mode = .indeterminate

        weak var weakSelf = self
        User.login(username: username, password: password, completion: { (result) in
            hud.hide(animated: true)
            if result == true {
                UserDefaults.standard.set(username, forKey: "username")
                UserDefaults.standard.set(password, forKey: "password")

                let tabbar = UITabBarController()
                
                let meetingsViewController = MeetingsViewController()
                let meetingsNavigationController = UINavigationController(rootViewController: meetingsViewController)
                let ratedMeetingsViewController = RatedMeetingsViewController()
                let ratedNavigationController = UINavigationController(rootViewController: ratedMeetingsViewController)
                
                tabbar.viewControllers = [meetingsNavigationController, ratedNavigationController]
                
                weakSelf!.present(tabbar, animated: true, completion: nil)
                weakSelf?.initializeNotifications()
                weakSelf?.loginView?.usernameField.text = nil
                weakSelf?.loginView?.passwordField.text = nil
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
        center.requestAuthorization(options:[.alert]) { (granted, error) in
            let categoryId = "technology.tomorrow.calenalarating.notification"
            let rate1 = UNNotificationAction(identifier: "Star1", title: "⭐️", options: [])
            let rate2 = UNNotificationAction(identifier: "Star2", title: "⭐️⭐️", options: [])
            let rate3 = UNNotificationAction(identifier: "Star3", title: "⭐️⭐️⭐️", options: [])
            let rate4 = UNNotificationAction(identifier: "Star4", title: "⭐️⭐️⭐️⭐️", options: [])
            let rate5 = UNNotificationAction(identifier: "Star5", title: "⭐️⭐️⭐️⭐️⭐️", options: [])
            
            let category = UNNotificationCategory(identifier: categoryId, actions: [rate1, rate2, rate3, rate4, rate5], intentIdentifiers: [], options: [])
            center.setNotificationCategories([category])
        }
        
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    private func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
}
