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

    public var meetings: [Meeting] = []

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetings.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meeting = meetings[indexPath.row]
        let cell: MeetingCell = tableView.dequeueReusableCell(withIdentifier: MeetingCell.MEETING_CELL_IDENTIFIER) as! MeetingCell
        cell.meeting = meeting

        return cell
    }
}
