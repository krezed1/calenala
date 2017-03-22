//
//  APIManager.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 08/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation

public class APIManager {
//    public static let BASE_API_URL = "http://calendaranal.alijen.cz"
    public static let BASE_API_URL = "http://admin.calenala.com"
    
    public static func callRequest(request: URLRequest, completion: @escaping ([AnyHashable : Any]?) -> Swift.Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard let dataCount = data?.count, dataCount > 0 else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                
                return
            }

            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if statusCode == 200 {

                let jsonObject = try? JSONSerialization.jsonObject(with:data!, options: .allowFragments)
                let JSON = jsonObject as? [AnyHashable : Any]
                DispatchQueue.main.async {
                    completion(JSON)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }

        task.resume()
    }
}
