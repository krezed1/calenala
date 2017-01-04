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
class  MeetingDetailViewController: UIViewController {

    var commentDataSource: CommentTableViewDataSource?
    public var meetingDelegate: MeetingDetailDelegate?
//    public var titleCell: TitleTableViewCell?
    private var detailView: MeetingDetailView? {
        return view as? MeetingDetailView
    }

//  MARK: LifeCycles

    init(meeting: Meeting) {
        super.init(nibName: nil, bundle: nil)
        title = NSLocalizedString("Rate the meeting", comment: "MEETING_DETAIL_TITLE")
        commentDataSource = CommentTableViewDataSource(meeting: meeting)
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
    
//        loadMeetingDetail()
//        detailView?.sendButton.addTarget(self, action: #selector(sendButtonDidPress), for: .touchUpInside)

        guard let rating = commentDataSource?.meetingDetail?.meeting?.rating?.intValue, rating > 0 else  {
            return
        }

        detailView?.titleCell?.ratingView.setRating(rating: rating)
//        detailView?.disableMessageView()
    }

//  MARK: UserActions

//    func sendButtonDidPress() {
//        let rating = detailView?.ratingView.getRating()
//        let ratingDesc = detailView?.messageView.text
//
//        let hud = MBProgressHUD.showAdded(to: detailView!, animated: true)
//        hud.mode = .indeterminate
//
//        weak var weakSelf = self
//        commentDataSource?.meetingDetail?.rateMeeting(rating: rating!, ratingDesc: ratingDesc!, completion: { (result) in
//            hud.hide(animated: false)
//            if result == true {
//                if weakSelf?.meetingDelegate != nil {
//                    weakSelf?.commentDataSource?.meetingDetail?.meeting?.rating = NSNumber(integerLiteral: rating!)
//                    weakSelf?.meetingDelegate?.meetingDidRate(value: rating!)
//                }
//
//                _ = weakSelf?.navigationController?.popViewController(animated: true)
//            } else {
//                let ok = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler: nil)
//                weakSelf?.showAlert(title: "Error", message: "Something went wrong", actions: [ok])
//            }
//        })
//    }

//  MARK: Private

    private func loadMeetingDetail() {
        weak var weakSelf = self
        MeetingDetail.loadMeetingDetail(meetingId: commentDataSource!.meetingDetail!.meeting!.meetingId!) { (meetingDetail) in
            meetingDetail?.meeting = weakSelf?.commentDataSource?.meetingDetail?.meeting
            weakSelf?.commentDataSource?.meetingDetail = meetingDetail
            weakSelf?.initializeMeetingDetail()
        }
    }

    private func initializeMeetingDetail() {
        detailView?.titleCell?.nameLabel.text = commentDataSource?.meetingDetail?.meeting?.name
//        detailView?.whenValueLabel.text = commentDataSource?.meetingDetail?.meeting?.populatedMeetingInterval
//        detailView?.whereValueLabel.text = commentDataSource?.meetingDetail?.meeting?.locationName
//        detailView?.titleCell?.organizerNameLabel.text = " - Zdeněk"
        detailView?.titleCell?.organizerNameLabel.text = commentDataSource?.meetingDetail?.meeting?.organizer
        detailView?.titleCell?.titleLabel.text = (detailView?.titleCell?.nameLabel.text)! + (detailView?.titleCell?.organizerNameLabel.text)!
//        detailView?.commentTableView.reloadData()
    }
}
