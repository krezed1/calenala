//
//  MeetingDetail.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 09/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import Mantle

class MeetingDetail: MTLModel, MTLJSONSerializing {

    public var meetingId: String?
    public var name: String?
    public var start: String?
    public var end: String?
    public var organizer: String?
    public var rating: NSNumber?
    public var ratedByMe: NSNumber?
    public var locationName: String?
    public var meetingDesc: String?
    public var roomName: String?
    public var duration: String?
    public var peopleCount: String?
    public var accepted: String?
    public var declined: String?
    public var tentative: String?
    public var price: String?
    public var potentialPrice: String?
    public var attendees: Array<Attende>?    
    
    public var populatedMeetingInterval: String? {
        var meetingInterval = ""
        if let baseDate = start?.populateBaseDate(),
            let startHours = start?.populateHours(),
            let endHours = end?.populateHours() {
            meetingInterval  = String(format:"%@, %@ - %@",
                                      baseDate,
                                      startHours,
                                      endHours)
        }
        
        
        return meetingInterval
    }
    
//  MARK: MTLJSONSerializing

    public static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {

        return ["meetingDesc" : "description",
                "duration" : "duration",
                "peopleCount" : "peoplecount",
                "accepted" : "accepted",
                "declined" : "declined",
                "tentative" : "tentative",
                "price" : "price",
                "potentialPrice" : "potentional_price",
                "meetingId" : "id",
                "name" : "name",
                "start" : "start",
                "end" : "end",
                "organizer" : "organizer",
                "rating" : "rating",
                "locationName" : "location_name",
                "ratedByMe" : "rated_by_me"
        ]
    }

//    + (NSValueTransformer *)HTMLURLJSONTransformer {
//    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
//    }


//  MARK: Public

    public func attendeesRated() -> Array<Attende>? {
        var attendeesRated: Array<Attende> = Array<Attende>()
        guard let atts = attendees else {
            return attendeesRated
        }

        for attendee in atts {
            if attendee.rated() == true {
                attendeesRated.append(attendee)
            }
        }

        return attendeesRated
    }

    public func rateMeeting(rating: Int, ratingDesc: String, completion: @escaping (Bool) -> Swift.Void) {
        let url = URL(string: APIManager.BASE_API_URL)
        let params = String(format: "action=MobileApi&api_key=123456apikey&akce=rateMeeting&token=%@&meeting_id=%@&rating=%d&rating_description=%@", User.currentUser.token!, meetingId!, rating, ratingDesc)
        let body = params.data(using: .utf8)

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = body

        APIManager.callRequest(request: request) { (JSON) in
            DispatchQueue.main.async {
                let resultStr = JSON?["response"] as? NSString
                var result: Bool?
                if resultStr == nil {
                    result = false
                }

                result = resultStr?.boolValue
                completion(result!)
            }
        }
    }

    public static func loadMeetingDetail(meetingId: String, completion: @escaping (MeetingDetail?) -> Swift.Void) {
        let url = URL(string: APIManager.BASE_API_URL)
        
        let params = String(format: "action=MobileApi&api_key=123456apikey&akce=getMeetingInfo&token=%@&meeting_id=%@", User.currentUser.token!, meetingId)
        let body = params.data(using: .utf8)

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = body

        APIManager.callRequest(request: request) { (JSON) in
            let meetingInfoJSON = JSON?["meeting_info"] as? [AnyHashable : Any]
            let attendeesJSON = JSON?["attendees"] as? [Any]
            let meetingDetail = try! MTLJSONAdapter.model(of: MeetingDetail.self, fromJSONDictionary: meetingInfoJSON!) as? MeetingDetail
            meetingDetail?.attendees = try! MTLJSONAdapter.models(of: Attende.self, fromJSONArray: attendeesJSON!) as? Array<Attende>
            DispatchQueue.main.async {
                completion(meetingDetail)
            }
        }
    }
}
