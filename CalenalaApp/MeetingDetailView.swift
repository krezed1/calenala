//
//  MeetingDetailView.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 09/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit

class MeetingDetailView: UIScrollView {
    
    public var centerView: UIView = UIView()

    public var titleLabel: UILabel = UILabel()
    public var nameLabel: UILabel = UILabel()
    public var organizerNameLabel: UILabel = UILabel()
    public var ratingView: RatingView = RatingView()
    private var firstSeparatorView: UIView = UIView()
    
    private var whereIcon: UIImageView = UIImageView()
    public var whenValueLabel: UILabel = UILabel()

    private var whenIcon: UIImageView = UIImageView()
    public var whereValueLabel: UILabel = UILabel()
    private var secondSeparatorView: UIView = UIView()
    
    private var attendeesLabel: UILabel = UILabel()
    public var emailStackView: EmailStackView = EmailStackView()
    private var thirdSeparatorView: UIView = UIView()
    
    public var commentsLabel: UILabel = UILabel()
    public var commentViewLayout: CommentViewLayout = CommentViewLayout()

    public var organizerValueLabel: UILabel = UILabel()

    private var messageLabel: UILabel = UILabel()
    public var messageView: UITextView = UITextView()
    public var sendButton: UIButton = UIButton(type: .custom)

    static let LABEL_FONT = UIFont.systemFont(ofSize: 14)
    
    private let VERTICAL_INSET = UIScreen.main.bounds.size.width * 20/320
    private let HORIZONTAL_INSET = UIScreen.main.bounds.size.width * 30/320
    private let SEPARATOR_COLOR = UIColor(colorLiteralRed: 223/255, green: 223/255, blue: 223/255, alpha: 1)
    private let BACKGROUND_BLUE_COLOR = UIColor(colorLiteralRed: 66/255, green: 189/255, blue: 216/255, alpha: 1)
    private let SEND_BUTTON_COLOR = UIColor(colorLiteralRed: 239/255, green: 214/255, blue: 100/255, alpha: 1)
    private let WHERE_IMAGE = UIImage(named: "location-icon")
    private let WHEN_IMAGE = UIImage(named: "time-icon")

//  MARK: LifeCycles

    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = BACKGROUND_BLUE_COLOR
        setUpView()
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: Public

    public func disableMessageView() {
        ratingView.isUserInteractionEnabled = false
    }

// MARK: Private

    private func setUpView() {
        addSubview(centerView)
        centerView.addSubview(titleLabel)
        centerView.addSubview(nameLabel)
        centerView.addSubview(organizerNameLabel)
        centerView.addSubview(firstSeparatorView)
        centerView.addSubview(whereIcon)
        centerView.addSubview(whereValueLabel)
        centerView.addSubview(whenIcon)
        centerView.addSubview(whenValueLabel)
        centerView.addSubview(secondSeparatorView)
        centerView.addSubview(attendeesLabel)
        centerView.addSubview(emailStackView)
        centerView.addSubview(thirdSeparatorView)
        centerView.addSubview(commentsLabel)
        centerView.addSubview(commentViewLayout)
        centerView.addSubview(organizerValueLabel)
        centerView.addSubview(ratingView)
        centerView.addSubview(messageLabel)
        centerView.addSubview(messageView)
        centerView.addSubview(sendButton)
        
        centerView.backgroundColor = UIColor.white
        
        firstSeparatorView.backgroundColor = SEPARATOR_COLOR

        messageLabel.text = NSLocalizedString("Message (optional)", comment: "MESSAGE_LABEL")
        
        whereIcon.image = WHERE_IMAGE
        
        whereValueLabel.textColor = UIColor.gray
        
        whenIcon.image = WHEN_IMAGE
        
        whenValueLabel.textColor = UIColor.gray
        
        secondSeparatorView.backgroundColor = SEPARATOR_COLOR
        
        attendeesLabel.text = NSLocalizedString("Attendees", comment: "")
        attendeesLabel.textColor = UIColor.gray
        
        thirdSeparatorView.backgroundColor = SEPARATOR_COLOR
        
        commentsLabel.text = NSLocalizedString("Comments", comment: "")
        commentsLabel.textColor = UIColor.gray
        
        sendButton.backgroundColor = SEND_BUTTON_COLOR
        sendButton.setTitle(NSLocalizedString("Send comment", comment: "SEND_BUTTON"), for: .normal)
        sendButton.setTitleColor(UIColor.black, for: .normal)

        messageView.layer.borderColor = SEPARATOR_COLOR.cgColor
        messageView.layer.borderWidth = 2
        messageView.layer.cornerRadius = 5
        messageView.placeholderText = NSLocalizedString("Write your comment here", comment: "")
        messageView.textColor = UIColor.lightGray

        titleLabel.font = UIFont.systemFont(ofSize: 20)
        whenValueLabel.font = MeetingDetailView.LABEL_FONT
        whereValueLabel.font = MeetingDetailView.LABEL_FONT
        attendeesLabel.font = MeetingDetailView.LABEL_FONT
        commentsLabel.font = MeetingDetailView.LABEL_FONT
        organizerValueLabel.font = MeetingDetailView.LABEL_FONT
        messageLabel.font = MeetingDetailView.LABEL_FONT
        messageView.font = MeetingDetailView.LABEL_FONT
    }

    private func layoutView() {
        
        centerView.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        centerView.autoMatch(.width, to: .width, of: self, withMultiplier: 0.95)
        centerView.autoAlignAxis(toSuperviewAxis: .vertical)
        centerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)

        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        titleLabel.autoPinEdge(.top, to: .top, of: centerView, withOffset: VERTICAL_INSET)
        
        ratingView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: VERTICAL_INSET)
        ratingView.autoAlignAxis(toSuperviewAxis: .vertical)
        ratingView.autoMatch(.height, to: .width, of: self, withMultiplier: 17/320)
        
        firstSeparatorView.autoPinEdge(.top, to: .bottom, of: ratingView, withOffset: VERTICAL_INSET)
        firstSeparatorView.autoSetDimension(.height, toSize: 2)
        firstSeparatorView.autoMatch(.width, to: .width, of: centerView)
        firstSeparatorView.autoAlignAxis(toSuperviewAxis: .vertical)
        
        whereIcon.autoPinEdge(.top, to: .bottom, of: firstSeparatorView, withOffset: VERTICAL_INSET * 1.5)
        whereIcon.autoAlignAxis(.vertical, toSameAxisOf: centerView, withMultiplier: 0.3)
        whereIcon.autoMatch(.width, to: .width, of: self, withMultiplier: 10/320)
        whereIcon.autoMatch(.height, to: .width, of: whereIcon, withMultiplier: 15/10)
        
        whereValueLabel.autoAlignAxis(.horizontal, toSameAxisOf: whereIcon)
        whereValueLabel.autoPinEdge(.leading, to: .trailing, of: whereIcon, withOffset: 10)
        
        whenIcon.autoAlignAxis(.vertical, toSameAxisOf: whereIcon)
        whenIcon.autoPinEdge(.top, to: .bottom, of: whereIcon, withOffset: VERTICAL_INSET)
        whenIcon.autoMatch(.width, to: .width, of: self, withMultiplier: 13/320)
        whenIcon.autoMatch(.height, to: .width, of: whenIcon)
        
        whenValueLabel.autoAlignAxis(.horizontal, toSameAxisOf: whenIcon)
        whenValueLabel.autoPinEdge(.leading, to: .leading, of: whereValueLabel)
        
        secondSeparatorView.autoPinEdge(.top, to: .bottom, of: whenIcon, withOffset: VERTICAL_INSET * 1.5)
        secondSeparatorView.autoSetDimension(.height, toSize: 2)
        secondSeparatorView.autoMatch(.width, to: .width, of: centerView)
        secondSeparatorView.autoAlignAxis(toSuperviewAxis: .vertical)

        attendeesLabel.autoPinEdge(.top, to: .bottom, of: secondSeparatorView, withOffset: VERTICAL_INSET)
        attendeesLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        emailStackView.autoAlignAxis(toSuperviewAxis: .vertical)
        emailStackView.autoPinEdge(.top, to: .bottom, of: attendeesLabel, withOffset: VERTICAL_INSET)
        emailStackView.autoMatch(.width, to: .width, of: self, withMultiplier: 260/320)
        
        thirdSeparatorView.autoPinEdge(.top, to: .bottom, of: emailStackView, withOffset: VERTICAL_INSET)
        thirdSeparatorView.autoSetDimension(.height, toSize: 2)
        thirdSeparatorView.autoMatch(.width, to: .width, of: centerView)
        thirdSeparatorView.autoAlignAxis(toSuperviewAxis: .vertical)
        
        commentsLabel.autoPinEdge(.top, to: .bottom, of: thirdSeparatorView, withOffset: VERTICAL_INSET)
        commentsLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        commentViewLayout.autoPinEdge(.top, to: .bottom, of: commentsLabel, withOffset: VERTICAL_INSET)
        commentViewLayout.autoMatch(.width, to: .width, of: self, withMultiplier: 240/320)
        commentViewLayout.autoAlignAxis(toSuperviewAxis: .vertical)

        messageView.autoMatch(.width, to: .width, of: commentViewLayout)
        messageView.autoAlignAxis(toSuperviewAxis: .vertical)
        messageView.autoPinEdge(.top, to: .bottom, of: commentViewLayout, withOffset: VERTICAL_INSET)
        messageView.autoMatch(.height, to: .width, of: self, withMultiplier: 85/320)

        sendButton.autoPinEdge(.top, to: .bottom, of: messageView, withOffset: VERTICAL_INSET)
        sendButton.autoMatch(.width, to: .width, of: centerView)
        sendButton.autoMatch(.height, to: .width, of: self, withMultiplier: 50/320)
        sendButton.autoAlignAxis(toSuperviewAxis: .vertical)
        sendButton.autoPinEdge(.bottom, to: .bottom, of: centerView)
   }
}
