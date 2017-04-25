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
    public var titleCell: TitleTableViewCell?
    public var createCommentCell: CreateCommentCell?
//  MARK: LifeCycles

    init(meeting: Meeting) {
        super.init()
        meetingDetail = MeetingDetail()
        meetingDetail?.meeting = meeting
    }

//  MARK: UITableViewDataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 3
        if let ratingValue = meetingDetail?.meeting?.rating?.intValue, ratingValue > 0 && meetingDetail?.meeting?.ratedByMe?.boolValue == true {
            if let commentsCount = meetingDetail?.attendeesRated()?.count {
                count += commentsCount
            }
        } else {
            count += 1            
        }

        return count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: TitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.titleTableViewCellReuseIdentifier) as! TitleTableViewCell
            cell.meeting = meetingDetail?.meeting
            titleCell = cell
            if let ratingValue = meetingDetail?.meeting?.ratedByMe?.boolValue, ratingValue == true {
                cell.ratingView.isUserInteractionEnabled = false
            } else {
                cell.ratingView.isUserInteractionEnabled = true
            }

            return cell
        } else if indexPath.row == 1 {
            let cell: LocationTableViewCell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.locationTableViewCellReuseIdentifier) as! LocationTableViewCell
            cell.meeting = meetingDetail?.meeting

            return cell

        } else if indexPath.row == 2 {
            let cell: AttendeeesCell = tableView.dequeueReusableCell(withIdentifier: AttendeeesCell.attendeeesCellReuseIdentifier) as! AttendeeesCell
            cell.attendes = meetingDetail?.attendees
            return cell
        } else if indexPath.row == 3 && meetingDetail?.meeting?.ratedByMe?.boolValue == false {
            let cell: CreateCommentCell = tableView.dequeueReusableCell(withIdentifier: CreateCommentCell.createCommentCellReuseIdentifier) as! CreateCommentCell
            createCommentCell = cell
            
            return cell
            
        } else {
            let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.commentTableViewCellReuseIdentifier) as! CommentTableViewCell
            if let count = meetingDetail?.attendeesRated()?.count, count > (indexPath.row - 3) {
                if let attende = meetingDetail?.attendeesRated()?[indexPath.row - 3] {
                    cell.attende = attende
                }
            }
            
            return cell
        }
    }
}

//if let ratingValue = meetingDetail?.meeting?.ratedByMe?.boolValue, ratingValue == true {
//    let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.commentTableViewCellReuseIdentifier) as! CommentTableViewCell
//    if let count = meetingDetail?.attendeesRated()?.count, count > (indexPath.row - 3) {
//        if let attende = meetingDetail?.attendeesRated()?[indexPath.row - 3] {
//            cell.attende = attende
//        }
//    }
//
//    return cell
//} else {
//    let cell: CreateCommentCell = tableView.dequeueReusableCell(withIdentifier: CreateCommentCell.createCommentCellReuseIdentifier) as! CreateCommentCell
//    createCommentCell = cell
//    
//    return cell
//}
