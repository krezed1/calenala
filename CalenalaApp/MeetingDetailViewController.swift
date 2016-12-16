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

    let commentDataSource: CommentTableViewDataSource = CommentTableViewDataSource()
    public var commentTableViewCell: CommentTableViewCell?
    public var meetingDelegate: MeetingDetailDelegate?
    private var meetingDetail: MeetingDetail?
    private var detailView: MeetingDetailView? {
        return view as? MeetingDetailView
    }

//  MARK: LifeCycles

    init(meeting: Meeting) {
        super.init(nibName: nil, bundle: nil)
        title = NSLocalizedString("Rate the meeting", comment: "MEETING_DETAIL_TITLE")

        meetingDetail = MeetingDetail()
        meetingDetail?.meeting = meeting
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = MeetingDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        detailView?.commentTableView.dataSource = commentDataSource

        loadMeetingDetail()
        detailView?.sendButton.addTarget(self, action: #selector(sendButtonDidPress), for: .touchUpInside)
        if meetingDetail?.meeting?.rating != nil && meetingDetail!.meeting!.rating!.intValue > 0 {
            detailView?.ratingView.setRating(rating: meetingDetail!.meeting!.rating!.intValue)
            detailView?.disableMessageView()
        }
    }

//  MARK: UserActions

    func sendButtonDidPress() {
        let rating = detailView?.ratingView.getRating()
        let ratingDesc = detailView?.messageView.text

        let hud = MBProgressHUD.showAdded(to: detailView!, animated: true)
        hud.mode = .indeterminate

        weak var weakSelf = self
        meetingDetail?.rateMeeting(rating: rating!, ratingDesc: ratingDesc!, completion: { (result) in
            hud.hide(animated: false)
            if result == true {
                if weakSelf?.meetingDelegate != nil {
                    weakSelf?.meetingDetail?.meeting?.rating = NSNumber(integerLiteral: rating!)
                    weakSelf?.meetingDelegate?.meetingDidRate(value: rating!)
                }

                _ = weakSelf?.navigationController?.popViewController(animated: true)
            } else {
                let ok = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler: nil)
                weakSelf?.showAlert(title: "Error", message: "Something went wrong", actions: [ok])
            }
        })
    }

//  MARK: Private

    private func loadMeetingDetail() {
        weak var weakSelf = self
        MeetingDetail.loadMeetingDetail(meetingId: meetingDetail!.meeting!.meetingId!) { (meetingDetail) in
            meetingDetail?.meeting = weakSelf?.meetingDetail?.meeting
            weakSelf?.meetingDetail = meetingDetail
            weakSelf?.initializeMeetingDetail()
        }
    }

    private func initializeMeetingDetail() {
        detailView?.nameLabel.text = meetingDetail?.meeting?.name
        detailView?.whenValueLabel.text = meetingDetail?.meeting?.populatedMeetingInterval
        detailView?.whereValueLabel.text = meetingDetail?.meeting?.locationName
        detailView?.organizerNameLabel.text = " - Zdeněk"
        detailView?.organizerValueLabel.text = meetingDetail?.meeting?.organizer
        detailView?.titleLabel.text = (detailView?.nameLabel.text)! + (detailView?.organizerNameLabel.text)!
    }
}
