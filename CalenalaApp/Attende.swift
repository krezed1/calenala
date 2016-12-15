//
//  Attendes.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 07/12/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import UIKit
import Mantle

class Attende: MTLModel, MTLJSONSerializing {

    public var name: String?
    public var email: String?
    public var response: String?
    public var rating: String?
    public var ratingDesc: String?

//  MARK: MTLJSONSerializing

    public static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {

        return ["name" : "name",
                "email" : "email",
                "response" : "response",
                "rating" : "rating",
                "ratingDesc" : "rating_description"
        ]
    }

}
