//
//  MeetingCell.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 04/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit

class MeetingCell: UITableViewCell {
    static let MEETING_CELL_IDENTIFIER = "MEETING_CELL_IDENTIFIER"

    private var nameLabel: UILabel = UILabel()
    private var intervalLabel: UILabel = UILabel()
    private var oraganizerLabel: UILabel = UILabel()
    private var separatorView: UIView = UIView()
    private var ratingView: RatingView = RatingView()

    public var meeting: Meeting? {
        didSet {
            nameLabel.text = meeting!.name
            intervalLabel.text = meeting!.populatedMeetingInterval
            oraganizerLabel.text = meeting!.organizer

            if meeting!.rating != nil && meeting!.rating!.intValue > 0 {
                ratingView.setRating(rating: meeting!.rating!.intValue)
                ratingView.isHidden = false
            } else {
                ratingView.isHidden = true
            }
        }
    }

// MARK: LifeCycles

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: Private

    private func setUpCell() {
        selectionStyle = .none
        contentView.addSubview(nameLabel)
        contentView.addSubview(intervalLabel)
        contentView.addSubview(oraganizerLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(ratingView)

        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: 0.8)
        intervalLabel.font = UIFont.systemFont(ofSize: 14, weight: 0.2)
        oraganizerLabel.font = UIFont.systemFont(ofSize: 14, weight: 0.2)
        separatorView.backgroundColor = UIColor.black
    }

    private func layoutView() {

        nameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        nameLabel.autoPinEdge(.right, to: .left, of: ratingView, withOffset: 16)

        intervalLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        intervalLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 2)

        oraganizerLabel.autoPinEdge(.top, to: .bottom, of: intervalLabel, withOffset: 20)
        oraganizerLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        oraganizerLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)

        separatorView.autoSetDimension(.height, toSize: 1)
        separatorView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        separatorView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        separatorView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)

        ratingView.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        ratingView.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
        ratingView.autoSetDimension(.height, toSize: 15)
    }
}
