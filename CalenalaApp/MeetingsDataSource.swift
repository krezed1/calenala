//
//  MeetingsDataSource.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 04/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit

class MeetingsDataSource: NSObject, UITableViewDataSource {

//  MARK: LifeCycles

    public var meetings: [Any] = []

    public func meeting(forMeetingId: String) -> Meeting? {
        var foundMeeting: Meeting?
        
        guard let populatedMeetings = meetings as? [[Meeting]] else {
            return nil
        }
        
        for section in populatedMeetings {
            for meeting in section {
                if meeting.meetingId == forMeetingId {
                    foundMeeting = meeting
                    break
                }
            }
        }
        
        return foundMeeting
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return meetings.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let meetingsInDay:[Meeting]? = meetings[section] as? [Meeting]

        guard let count = meetingsInDay?.count, count > 0 else {
            return 0
        }

        return count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meetingsInDay:[Meeting]! = meetings[indexPath.section] as! [Meeting]
        let meeting: Meeting? = meetingsInDay[indexPath.row]
        let cell: MeetingCell = tableView.dequeueReusableCell(withIdentifier: MeetingCell.MEETING_CELL_IDENTIFIER) as! MeetingCell
        cell.meeting = meeting

        return cell
    }
}
