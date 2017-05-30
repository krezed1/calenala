//
//  NotificationViewController.swift
//  CalenalaPushExtension
//
//  Created by Daniel Krezelok on 25/04/2017.
//  Copyright © 2017 Krezelok, Daniel. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

//{"aps":{"alert" : {
//    "title" : "Planning POS",
//    "body" : "Thu, May 4, 15:00 - 15:30"
//    },"badge":"1","mutable-content":"1","meeting_id":"1","category":"technology.tomorrow.calenalarating.notification"}}

class NotificationViewController: UIViewController, UNNotificationContentExtension, UITextFieldDelegate {
    private let BUTTON_BACKGROUND_COLOR = UIColor(colorLiteralRed: 238/255 , green: 215/255, blue: 75/255, alpha: 1)

    @IBOutlet var commentField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commentField?.placeholder = NSLocalizedString("Tap here and write your comment", comment: "")
        commentField?.delegate = self
    }
  
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
//        let userDefaults = UserDefaults(suiteName: "group.technology.tomorrow.calenalarating.CalenalaPushExtension")
//        let token = "dsadas"

//        guard let token = userDefaults?.string(forKey: "token") else {
//            return
//        }
        
//        let userInfo = response.notification.request.content.userInfo
//
//        guard let json = userInfo["aps"] as? [AnyHashable : Any] else {
//            return
//        }
//        
//        guard let meetingId = json["meeting_id"] as? String else {
//            return
//        }
//        
//        guard let ratingDesc = commentField?.text else {
//            return
//        }
//        
//        let url = URL(string: APIManager.BASE_API_URL)
//        let params = String(format: "action=MobileApi&api_key=123456apikey&akce=rateMeeting&token=%@&meeting_id=%@&rating=%d&rating_description=%@", token, meetingId, 1, ratingDesc)
//        let body = params.data(using: .utf8)
//        
//        var request = URLRequest(url: url!)
//        request.httpMethod = "POST"
//        request.httpBody = body

        let session = URLSession.shared
        let url = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFv1SeyEyQ11bW5AApV_wtTfZFQU-VQYrWMyESNfSVB6Y8kVEOqA")
        let downloadTask = session.downloadTask(with: url!) { (originalUrl, response, error) in
            
        }
        
        downloadTask.resume()
        
//        APIManager.callRequest(request: request) { (JSON) in
//            DispatchQueue.main.async {
//                guard let resultStr = JSON?["response"] as? String else {
//                    return
//                }
//                
//                completion(UNNotificationContentExtensionResponseOption.dismiss)
//                print(resultStr)
//            }
//        }
    }
    
    func didReceive(_ notification: UNNotification) {
        print("userInfo\n" + notification.request.content.userInfo.description)
        commentField?.becomeFirstResponder()
    }
    
//  MARK UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
