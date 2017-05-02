//
//  RatedMeetingsViewController.swift
//  CalenalaApp
//
//  Created by Daniel Krezelok on 21/03/2017.
//  Copyright © 2017 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class RatedMeetingsViewController: MeetingsViewController {
    let RATED_BAR_IMAGE: UIImage? = UIImage(named: "rated")
    
//  MARK: LifeCycles
    
    override init() {
        super.init()
        tabBarItem = UITabBarItem(title: NSLocalizedString("Rated", comment: "RATED_BAR_TITLE"),
                                  image: RATED_BAR_IMAGE,
                                  selectedImage: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = nil
        navigationItem.leftBarButtonItem = nil
    }
    
    override func initializeMeetings() {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .indeterminate
        
        weak var weakSelf = self
        Meeting.loadRatedMeetings { (meetings) in
            hud.hide(animated: true)
            weakSelf?.dataSource.meetings = meetings!
            weakSelf?.tableView.reloadData()
            weakSelf?.refreshControl?.endRefreshing()
        }
    }
}
