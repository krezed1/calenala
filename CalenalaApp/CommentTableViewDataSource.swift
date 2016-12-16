//
//  CommentTableViewDataSource.swift
//  CalenalaApp
//
//  Created by Michael Pohl on 15.12.16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import UIKit

class CommentTableViewDataSource: NSObject, UITableViewDataSource {
    
    public var attende: [Attende] = []
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let comment = attende[indexPath.row]
        let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.commentTableViewCellReuseIdentifier) as! CommentTableViewCell
//        cell.attende = comment
        
        return cell
    }
}
