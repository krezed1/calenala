//
//  Attendees.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 05/01/17.
//  Copyright © 2017 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit

class AttendeesViewController: UITableViewController {

    var attendeesList: Array<Attende>?
    let ATTENDEES_IDENTIFIER = "ATTENDEES_IDENTIFIER"

//  MARK: LifeCycles

    init(attendees: Array<Attende>) {
        super.init(nibName: nil, bundle: nil)
        title = NSLocalizedString("Attendees", comment: "")
        attendeesList = attendees
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ATTENDEES_IDENTIFIER)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = attendeesList?.count else {
            return 0
        }

        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATTENDEES_IDENTIFIER)
        if let attende = attendeesList?[indexPath.row] {
            cell?.textLabel?.text = attende.email
        }

        return cell!
    }
}
