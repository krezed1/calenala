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
    public var titleCell: TitleTableViewCell = TitleTableViewCell()
    public var locationCell: LocationTableViewCell = LocationTableViewCell()
    public var commentCell: CommentTableViewCell = CommentTableViewCell()
    public var dataSource: Array<Any>
    public var comments: Array<Any>

//  MARK: LifeCycles

    init(meeting: Meeting) {
        meetingDetail = MeetingDetail()
        meetingDetail?.meeting = meeting
        dataSource = [titleCell, locationCell, commentCell]
        comments = []
    }

//  MARK: UITableViewDataSource
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let count = meetingDetail?.attendeesRated()?.count, count > 0 else {
//            return 0
//        }
        if section == 0 {
            return dataSource.count
        } else {
            return comments.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let attende = meetingDetail?.attendeesRated()?[indexPath.row]
        
        if indexPath.section == 0 {
            let cell = dataSource[indexPath.row]
            
//            let cell: TitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.titleTableViewCellReuseIdentifier) as! TitleTableViewCell
            return cell as! UITableViewCell
        } else
        if indexPath.section == 1 {
            let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.commentTableViewCellReuseIdentifier) as! CommentTableViewCell
            return cell
        }
        else {
            let cell2: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.commentTableViewCellReuseIdentifier) as! CommentTableViewCell
            return cell2
        }
    }
}
