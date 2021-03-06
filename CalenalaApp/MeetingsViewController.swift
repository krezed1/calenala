//
//  MainViewController.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 04/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class MeetingsViewController: UITableViewController, MeetingDetailDelegate {
    let BAR_IMAGE: UIImage? = UIImage(named: "list")
    let dataSource: MeetingsDataSource = MeetingsDataSource()

//  MARK: LifeCycles

    init() {
        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showPushedDetailIfNeeded),
                                               name: NSNotification.Name.UIApplicationDidBecomeActive,
                                               object: nil)
        tabBarItem = UITabBarItem(title: NSLocalizedString("Meetings", comment: "MEETINGS_BAR_TITLE"),
                                  image: BAR_IMAGE,
                                  selectedImage: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(colorLiteralRed: 66/255, green: 189/255, blue: 216/255, alpha: 1)
        tableView.register(MeetingCell.self, forCellReuseIdentifier: MeetingCell.MEETING_CELL_IDENTIFIER)
        tableView.register(MeetingHeaderView.self, forHeaderFooterViewReuseIdentifier: MeetingHeaderView.MEETING_HEADER_IDENTIFIER)
        tableView.separatorStyle = .none
        tableView.dataSource = dataSource
        tableView.rowHeight = 182
        tableView.sectionHeaderHeight = 40

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(initializeMeetings), for: .valueChanged)

        let settingsButton = UIBarButtonItem(title: NSLocalizedString("Settings", comment: ""),
                                             style: .plain,
                                             target: self,
                                           	action: #selector(settingsButtonDidPress))
        
        let logoutButton = UIBarButtonItem(title: NSLocalizedString("Logout", comment: ""),
                                           style: .plain,
                                           target: self,
                                           action: #selector(logoutButtonDidPress))

        navigationItem.rightBarButtonItem = logoutButton
        navigationItem.leftBarButtonItem = settingsButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initializeMeetings()
    }
    
//  MARK: MeetingDetailDelegate

    func meetingDidRate(value: Int) {        
        tableView.reloadData()
    }

//  MARK: UserActions

    func settingsButtonDidPress() {
        let settingsViewController = SettingsViewController()
        let navigationController = UINavigationController(rootViewController: settingsViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    func logoutButtonDidPress() {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "password")

        dismiss(animated: true, completion: nil)
    }

//  MARK: Private

    func initializeMeetings() {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .indeterminate

        weak var weakSelf = self
        Meeting.loadYourMeetings { (meetings) in
            hud.hide(animated: true)
            
            weakSelf?.dataSource.meetings = meetings!
            weakSelf?.tableView.reloadData()
            weakSelf?.refreshControl?.endRefreshing()
            weakSelf?.showPushedDetailIfNeeded()
        }
    }

    func showPushedDetailIfNeeded() {
        if let pushedMeetingId = UserDefaults.standard.string(forKey: "meeting_id"), dataSource.meetings.count > 0 {
            showMeetingDetailWithId(meetingId: pushedMeetingId)
        }
    }
    
    func showMeetingDetailWithId(meetingId: String) {
        UserDefaults.standard.removeObject(forKey: "meeting_id")
        UserDefaults.standard.synchronize()
        
        let meetingDetailController = MeetingDetailViewController(meetingId: meetingId)
        meetingDetailController.meetingDelegate = self
        navigationController?.pushViewController(meetingDetailController, animated: true)
    }
    
//  MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let meetingsInDay:[Meeting]? = dataSource.meetings[section] as? [Meeting]
        let title: String? = meetingsInDay?.first?.start?.populateBaseDate()

        let headerView: MeetingHeaderView? = tableView.dequeueReusableHeaderFooterView(withIdentifier: MeetingHeaderView.MEETING_HEADER_IDENTIFIER) as? MeetingHeaderView
        headerView?.titleLabel.text = title

        return headerView
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meetings: [Meeting]? = dataSource.meetings[indexPath.section] as? [Meeting]
        guard let meeting = meetings?[indexPath.row] else {
            return
        }
        
        if let meetingId = meeting.meetingId {
            showMeetingDetailWithId(meetingId: meetingId)
        }
    }
}
