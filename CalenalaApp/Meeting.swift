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
    public var locationName: String?

    public var populatedMeetingInterval: String? {
        let meetingInterval = String(format:"%@, %@ - %@", start!.populateBaseDate(), start!.populateHours(), end!.populateHours())

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
                "locationName" : "location_name"
        ]
    }

//  MARK: Public

    public static func loadYourMeetings(completion: @escaping ([Any]?) -> Swift.Void) {
        let url = URL(string: APIManager.BASE_API_URL)
        // TODO: Pouzit login

        let params = String(format: "action=MobileApi&api_key=123456apikey&akce=getMeetings&token=%@", User.currentUser.token!)
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
            }

            DispatchQueue.main.async {
                completion(allMeetings)
            }
        }
    }
}
