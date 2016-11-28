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

    public static func login(username: String, password: String, completion: @escaping () -> Swift.Void) {
        let url = URL(string: APIManager.BASE_API_URL)
// TODO: Use login

        let params = "action=MobileApi&api_key=123456apikey&akce=login&user=rudolf@calenala.com&password=40bd001563085fc35165329ea1ff5c5ecbdbbeef"
        let body = params.data(using: .utf8)

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = body

        APIManager.callRequest(request: request) { (JSON) in
            let user: User? = try! MTLJSONAdapter.model(of: User.self, fromJSONDictionary: JSON) as? User
            if user != nil {
                User.setCurrentUser(user: user!)
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
