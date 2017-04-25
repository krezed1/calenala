//
//  Settings.swift
//  CalenalaApp
//
//  Created by Daniel Krezelok on 24/04/2017.
//  Copyright © 2017 Krezelok, Daniel. All rights reserved.
//

import Foundation
import Mantle

class Settings: MTLModel, MTLJSONSerializing {

//  MARK: MTLJSONSerializing
    
    public var push: String?
    public var pushReacurring: String?
    public var pushMinlimit: String?
    public var emailNotification: String?

    public var emailNotificationBoolValue: Bool {
        guard let value = emailNotification else {
            return false
        }
        
        switch value {
        case "0":
            return false
        case "1":
            return true
        default:
            return false
        }
    }
    
    public var pushBoolValue: Bool {
        guard let value = push else {
            return false
        }
        
        switch value {
        case "0":
            return false
        case "1":
            return true
        default:
            return false
        }
    }

    public var pushReacurringBoolValue: Bool {
        guard let value = pushReacurring else {
            return false
        }
        
        switch value {
        case "0":
            return false
        case "1":
            return true
        default:
            return false
        }
    }
    
    public static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return ["push" : "push",
                "pushReacurring" : "push_reacurring",
                "pushMinlimit" : "push_minlimit",
                "emailNotification" : "email_notification"
        ]
    }

//  MARK: Public
    
    public static func saveUserSettings(push: String, pushReacurring: String, emailNotification: String, pushLimit: String, completion: @escaping () -> Swift.Void) {
        let params = String(format: "action=MobileApi&api_key=123456apikey&akce=setUserSettings&token=%@&push=%@&push_reacurring=%@&push_minlimit=%@&email_notification=%@", User.currentUser.token!, push, pushReacurring, pushLimit, emailNotification)
        
        let url = URL(string: APIManager.BASE_API_URL)
        let body = params.data(using: .utf8)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = body
        
        APIManager.callRequest(request: request) { (JSON) in
            guard let result = JSON?["response"] else {
                completion()
                return
            }
            
            
            completion()
        }
    }
    
    public static func loadUserSettings(completion: @escaping (Settings?) -> Swift.Void) {
        let params = String(format: "action=MobileApi&api_key=123456apikey&akce=getUserSettings&token=%@", User.currentUser.token!)
        let url = URL(string: APIManager.BASE_API_URL)
        
        let body = params.data(using: .utf8)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = body
        
        APIManager.callRequest(request: request) { (JSON) in
            guard let settingsJSON = JSON?["settings"] as? [AnyHashable : Any] else {
                completion(nil)
                return
            }
            
            let settings = try! MTLJSONAdapter.model(of: Settings.self, fromJSONDictionary: settingsJSON) as? Settings            
            completion(settings)
        }
    }
}
