//
//  CommentTableViewDataSource.swift
//  CalenalaApp
//
//  Created by Michael Pohl on 15.12.16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import UIKit

class CommentTableViewDataSource: NSObject, UITableViewDataSource {
    
    public var meetingDetail: MeetingDetail?

//  MARK: LifeCycles

    init(meeting: Meeting) {
        meetingDetail = MeetingDetail()
        meetingDetail?.meeting = meeting
    }

//  MARK: UITableViewDataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = meetingDetail?.attendeesRated()?.count, count > 0 else {
            return 0
        }

        return count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let attende = meetingDetail?.attendeesRated()?[indexPath.row]
        let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.commentTableViewCellReuseIdentifier) as! CommentTableViewCell
        cell.attende = attende

        return cell
    }
}
