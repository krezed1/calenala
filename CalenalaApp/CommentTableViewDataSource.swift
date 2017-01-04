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
    public var comments: Array<Any>

//  MARK: LifeCycles

    init(meeting: Meeting) {
        meetingDetail = MeetingDetail()
        meetingDetail?.meeting = meeting
        comments = []
    }

//  MARK: UITableViewDataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: TitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.titleTableViewCellReuseIdentifier) as! TitleTableViewCell

            return cell
        } else if indexPath.row == 1 {
            let cell: LocationTableViewCell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.locationTableViewCellReuseIdentifier) as! LocationTableViewCell

            return cell

        } else {
            let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.commentTableViewCellReuseIdentifier) as! CommentTableViewCell
            return cell
        }
    }
}
