//
//  Meeting.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 04/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import Mantle

class Meeting: MTLModel, MTLJSONSerializing {

    public var meetingId: String?
    public var name: String?
    public var start: String?
    public var end: String?
    public var organizer: String?
    public var rating: NSNumber?
    public var ratedByMe: NSNumber?
    public var locationName: String?

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
        return ["meetingId" : "meeting_id",
                "name" : "name",
                "start" : "start",
                "end" : "end",
                "organizer" : "organizer",
                "rating" : "rating",
                "locationName" : "location_name",
                "ratedByMe" : "rated_by_me"
        ]
    }

//  MARK: Public

    public static func loadRatedMeetings(completion: @escaping ([Any]?) -> Swift.Void) {
        let params = String(format: "action=MobileApi&api_key=123456apikey&akce=getRatedMeetings&token=%@", User.currentUser.token!)
        Meeting.loadMeetings(params: params, completion: completion)
    }
    
    public static func loadYourMeetings(completion: @escaping ([Any]?) -> Swift.Void) {
        let params = String(format: "action=MobileApi&api_key=123456apikey&akce=getMeetings&token=%@", User.currentUser.token!)
        Meeting.loadMeetings(params: params, completion: completion)
    }
    
    public static func loadMeetings(params: String, completion: @escaping ([Any]?) -> Swift.Void) {
        let url = URL(string: APIManager.BASE_API_URL)
        
        let body = params.data(using: .utf8)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = body
        
        APIManager.callRequest(request: request) { (JSON) in
            let meetingsJSON = JSON?["meetings"] as? [Any]
            let result: [Meeting]? = try! MTLJSONAdapter.models(of: Meeting.self, fromJSONArray: meetingsJSON) as? [Meeting]
            
            guard let meetings = result, meetings.count > 0 else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                
                return
            }
            
            var allMeetings: [Any] = []
            var meetingsInDay: [Meeting] = []
            var prevMeeting: Meeting? = meetings.first
            for meeting in meetings {
                if meeting.start?.isInSameDay(date: prevMeeting?.start) == false {
                    allMeetings.append(meetingsInDay)
                    meetingsInDay.removeAll()
                }
                
                meetingsInDay.append(meeting)
                prevMeeting = meeting;
                
                if meetings.index(of: meeting) == meetings.count - 1 {
                    allMeetings.append(meetingsInDay)
                }
            }
            
            DispatchQueue.main.async {
                completion(allMeetings)
            }
        }
    }
}
