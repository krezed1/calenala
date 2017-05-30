//
//  User.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 31/10/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import Mantle

class User: MTLModel, MTLJSONSerializing {

    public var accountId: String?
    public var token: String?
    public var userId: String?

//  MARK: LifeCycles

    public static let currentUser : User = {
        let instance: User = User()
        return instance
    }()

    public static func setCurrentUser(user: User) {
        User.currentUser.accountId = user.accountId
        User.currentUser.token = user.token
        User.currentUser.userId = user.userId
    }

//  MARK: MTLJSONSerializing

    public static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return ["accountId" : "account_id",
                "token" : "token",
                "userId" : "user_id"
        ]
    }

//  MARK: Public

    public func sendNotificationToken(pushToken: Data, completion: @escaping () -> Swift.Void) {
        let url = URL(string: APIManager.BASE_API_URL)
        var deviceToken: String = ""
        for i in 0..<pushToken.count {
            deviceToken += String(format: "%02.2hhx", pushToken[i] as CVarArg)
        }

        print("devicetoken\n" + deviceToken)
        
        let userDefaults = UserDefaults(suiteName: "group.technology.tomorrow.calenalarating.CalenalaPushExtension")
        userDefaults?.set(token, forKey: "token")
        userDefaults?.synchronize()
        
        let params = String(format: "action=MobileApi&api_key=123456apikey&akce=savePushToken&token=%@&push_token=%@", token!, deviceToken)
        let body = params.data(using: .utf8)

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = body

        APIManager.callRequest(request: request) { (JSON) in
            DispatchQueue.main.async {
                completion()
            }
        }
    }

    public static func login(username: String, password: String, completion: @escaping (Bool) -> Swift.Void) {
        let url = URL(string: APIManager.BASE_API_URL)
// TODO: Use login

        let params = "action=MobileApi&api_key=123456apikey&akce=login&user=" + username + "&password=" + password.sha1()
        let body = params.data(using: .utf8)

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = body

        APIManager.callRequest(request: request) { (JSON) in
            guard let jsonResponse = JSON else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }

            guard let user = try? MTLJSONAdapter.model(of: User.self, fromJSONDictionary: jsonResponse) else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }

            guard let populatedUser: User = user as? User else {
                DispatchQueue.main.async {
                    completion(false)
                }                
                return
            }

            User.setCurrentUser(user: populatedUser)
            DispatchQueue.main.async {
                completion(true)
            }
        }
    }
}
