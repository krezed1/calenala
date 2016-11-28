//
//  MeetingDetailView.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 09/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit

class MeetingDetailView: UIView {

    public var nameLabel: UILabel = UILabel()
    private var whenLabel: UILabel = UILabel()
    public var whenValueLabel: UILabel = UILabel()

    private var whereLabel: UILabel = UILabel()
    public var whereValueLabel: UILabel = UILabel()

    private var whoLabel: UILabel = UILabel()
    public var whoValueLabel: UILabel = UILabel()

    private var oraganizerLabel: UILabel = UILabel()
    public var oraganizerValueLabel: UILabel = UILabel()

    public var ratingView: RatingView = RatingView()

    private var messageLabel: UILabel = UILabel()
    public var messageView: UITextView = UITextView()
    public var sendButton: UIButton = UIButton(type: .custom)

    static let LABEL_FONT = UIFont.systemFont(ofSize: 14)

//  MARK: LifeCycles

    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.white

        setUpView()
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: Public

    public func disableMessageView() {
        messageLabel.isHidden = true
        messageView.isHidden = true
        ratingView.isUserInteractionEnabled = false
        sendButton.isHidden = true
    }

// MARK: Private

    private func setUpView() {
        addSubview(nameLabel)
        addSubview(whenLabel)
        addSubview(whenValueLabel)
        addSubview(whereLabel)
        addSubview(whereValueLabel)
        addSubview(whoLabel)
        addSubview(whoValueLabel)
        addSubview(oraganizerLabel)
        addSubview(oraganizerValueLabel)
        addSubview(ratingView)
        addSubview(messageLabel)
        addSubview(messageView)
        addSubview(sendButton)

        messageLabel.text = NSLocalizedString("Message (optional)", comment: "MESSAGE_LABEL")
        whenLabel.text = NSLocalizedString("When", comment: "WHEN_LABEL")
        whereLabel.text = NSLocalizedString("Where", comment: "WHERE_LABEL")
        whoLabel.text = NSLocalizedString("Who", comment: "WHO_LABEL")
        oraganizerLabel.text = NSLocalizedString("Organizer", comment: "ORGANIZER_LABEL")

        sendButton.backgroundColor = UIColor.darkGray
        sendButton.setTitle(NSLocalizedString("Send", comment: "SEND_BUTTON"), for: .normal)
        sendButton.setTitleColor(UIColor.white, for: .normal)

        messageView.layer.borderColor = UIColor.black.cgColor
        messageView.layer.borderWidth = 1
        messageView.layer.cornerRadius = 12

        nameLabel.font = UIFont.systemFont(ofSize: 20)
        whenLabel.font = MeetingDetailView.LABEL_FONT
        whenValueLabel.font = MeetingDetailView.LABEL_FONT
        whereLabel.font = MeetingDetailView.LABEL_FONT
        whereValueLabel.font = MeetingDetailView.LABEL_FONT
        whoLabel.font = MeetingDetailView.LABEL_FONT
        whoValueLabel.font = MeetingDetailView.LABEL_FONT
        oraganizerLabel.font = MeetingDetailView.LABEL_FONT
        oraganizerValueLabel.font = MeetingDetailView.LABEL_FONT
        messageLabel.font = MeetingDetailView.LABEL_FONT
        messageView.font = MeetingDetailView.LABEL_FONT
    }

    private func layoutView() {

        nameLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 70)

        whenLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 16)
        whenLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)

        whenValueLabel.autoPinEdge(.top, to: .bottom, of: whenLabel, withOffset: 0)
        whenValueLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 48)

        whereLabel.autoPinEdge(.top, to: .bottom, of: whenValueLabel, withOffset: 8)
        whereLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)

        whereValueLabel.autoPinEdge(.top, to: .bottom, of: whereLabel, withOffset: 0)
        whereValueLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 48)

        whoLabel.autoPinEdge(.top, to: .bottom, of: whereValueLabel, withOffset: 8)
        whoLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)

        whoValueLabel.autoPinEdge(.top, to: .bottom, of: whoLabel, withOffset: 0)
        whoValueLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 48)

        oraganizerLabel.autoPinEdge(.top, to: .bottom, of: whoValueLabel, withOffset: 8)
        oraganizerLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)

        oraganizerValueLabel.autoPinEdge(.top, to: .bottom, of: oraganizerLabel, withOffset: 0)
        oraganizerValueLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 48)

        ratingView.autoPinEdge(.top, to: .bottom, of: oraganizerValueLabel, withOffset: 40)
        ratingView.autoAlignAxis(toSuperviewAxis: .vertical)
        ratingView.autoSetDimension(.height, toSize: 64)

        messageLabel.autoPinEdge(.top, to: .bottom, of: ratingView, withOffset: 40)
        messageLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)

        messageView.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        messageView.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        messageView.autoPinEdge(.top, to: .bottom, of: messageLabel, withOffset: 4)
        messageView.autoSetDimension(.height, toSize: 160)

        sendButton.autoMatch(.width, to: .width, of: self)
        sendButton.autoSetDimension(.height, toSize: 60)
        sendButton.autoPinEdge(.bottom, to: .bottom, of: self)
   }
}
