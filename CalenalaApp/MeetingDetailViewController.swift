//
//  MeetingDetailViewController.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 09/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

protocol MeetingDetailDelegate {
    func meetingDidRate(value: Int)
}
class  MeetingDetailViewController: UIViewController, UITableViewDelegate {
    var commentDataSource: CommentTableViewDataSource?
    public var meetingDelegate: MeetingDetailDelegate?
    private var detailView: MeetingDetailView? {
        return view as? MeetingDetailView
    }

//  MARK: LifeCycles
    
    init(meetingId: String) {
        super.init(nibName: nil, bundle: nil)
        title = NSLocalizedString("Rate the meeting", comment: "MEETING_DETAIL_TITLE")
        commentDataSource = CommentTableViewDataSource(meetingId: meetingId)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = MeetingDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .white
        edgesForExtendedLayout = UIRectEdge.bottom
        detailView?.dataSource = commentDataSource
        detailView?.delegate = self

        loadMeetingDetail()
        detailView?.sendButton.addTarget(self, action: #selector(sendButtonDidPress), for: .touchUpInside)
    }

//  MARK: UserActions

    func sendButtonDidPress() {
        guard let rating = commentDataSource?.titleCell?.ratingView.getRating(),
            let ratingDesc = commentDataSource?.createCommentCell?.comment(),
            rating > 0 else {
                let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""),
                                             style: .cancel,
                                             handler: nil)
                self.showAlert(title: "Warrning", message: "Please rate the meeting", actions: [okAction])
                return
        }

        let hud = MBProgressHUD.showAdded(to: detailView!, animated: true)
        hud.mode = .indeterminate

        weak var weakSelf = self
        commentDataSource?.meetingDetail?.rateMeeting(rating: rating, ratingDesc: ratingDesc, completion: { (result) in
            hud.hide(animated: false)
            if result == true {
                if weakSelf?.meetingDelegate != nil {
                    weakSelf?.commentDataSource?.meetingDetail?.rating = NSNumber(integerLiteral: rating)
                    weakSelf?.commentDataSource?.meetingDetail?.ratedByMe = 1
                    weakSelf?.meetingDelegate?.meetingDidRate(value: rating)
                }

                _ = weakSelf?.navigationController?.popViewController(animated: true)
            } else {
                let ok = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler: nil)
                weakSelf?.showAlert(title: "Error", message: "Something went wrong", actions: [ok])
            }
        })
    }

//  MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            if let attendees = commentDataSource?.meetingDetail?.attendees, attendees.count > 0 {
                let attendeesViewController = AttendeesViewController(attendees: attendees)
                navigationController?.pushViewController(attendeesViewController, animated: true)
            }
        }
    }

//  MARK: Private

    private func loadMeetingDetail() {
        weak var weakSelf = self
        MeetingDetail.loadMeetingDetail(meetingId: commentDataSource!.meetingDetail!.meetingId!) { (meetingDetail) in
            weakSelf?.commentDataSource?.meetingDetail = meetingDetail
            weakSelf?.detailView?.reloadData()
            
            if let rating = weakSelf?.commentDataSource?.meetingDetail?.ratedByMe?.boolValue, rating == true {                
                weakSelf?.detailView?.sendButton.isHidden = true
            } else {
                weakSelf?.detailView?.sendButton.isHidden = false
            }

        }
    }

}
