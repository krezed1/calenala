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

    private var timeView: TimeView = TimeView()
    private var nameLabel: UILabel = UILabel()
    private var placeIconView: UIImageView = UIImageView()
    private var placeLabel: UILabel = UILabel()

    private var intervalIconView: UIImageView = UIImageView()
    private var intervalLabel: UILabel = UILabel()
    private var separatorView: UIView = UIView()
    private var ratingView: RatingView = RatingView()

    private var cellContentView: UIView = UIView()

    public var meeting: Meeting? {
        didSet {
            nameLabel.text = String(format: "%@ - %@", meeting!.name!, meeting!.organizer!)
            intervalLabel.text = meeting!.populatedMeetingInterval
            timeView.startLabel.text = meeting?.start?.populateHours()
            timeView.endLabel.text = meeting?.end?.populateHours()
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
        addSubview(cellContentView)
        addSubview(timeView)

        cellContentView.addSubview(nameLabel)
        cellContentView.addSubview(intervalIconView)
        cellContentView.addSubview(intervalLabel)

        cellContentView.addSubview(placeIconView)
        cellContentView.addSubview(placeLabel)

        cellContentView.addSubview(separatorView)
        cellContentView.addSubview(ratingView)

        selectionStyle = .none

        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear

        cellContentView.backgroundColor = UIColor.white

        nameLabel.font = UIFont.systemFont(ofSize: 15)
        nameLabel.textColor = UIColor(colorLiteralRed: 102/255, green: 102/255, blue: 102/255, alpha: 1)

        intervalLabel.font = UIFont.systemFont(ofSize: 15)
        intervalLabel.textColor = UIColor(colorLiteralRed: 153/255, green: 153/255, blue: 153/255, alpha: 1)

        intervalIconView.image = UIImage(named: "time-icon")

        placeLabel.font = UIFont.systemFont(ofSize: 15)
        placeLabel.textColor = UIColor(colorLiteralRed: 153/255, green: 153/255, blue: 153/255, alpha: 1)

        placeIconView.image = UIImage(named: "location-icon")
        placeLabel.text = "Big meeting room"

        separatorView.backgroundColor = UIColor(colorLiteralRed: 223/255, green: 223/255, blue: 223/255, alpha: 1)
    }

    private func layoutView() {
        nameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        nameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 16)

        ratingView.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        ratingView.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 8)
        ratingView.autoSetDimension(.height, toSize: 10)

        separatorView.autoSetDimension(.height, toSize: 1)
        separatorView.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        separatorView.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        separatorView.autoPinEdge(.top, to: .bottom, of: ratingView, withOffset: 16)

        placeIconView.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        placeIconView.autoPinEdge(.top, to: .bottom, of: separatorView, withOffset: 16)

        placeLabel.autoPinEdge(.left, to: .right, of: placeIconView, withOffset: 4)
        placeLabel.autoPinEdge(.top, to: .bottom, of: separatorView, withOffset: 14)

        intervalIconView.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        intervalIconView.autoPinEdge(.top, to: .bottom, of: placeLabel, withOffset: 16)

        intervalLabel.autoPinEdge(.left, to: .right, of: intervalIconView, withOffset: 4)
        intervalLabel.autoPinEdge(.top, to: .bottom, of: placeLabel, withOffset: 14)

        cellContentView.autoPinEdge(toSuperviewEdge: .left, withInset: 50)
        cellContentView.autoPinEdge(toSuperviewEdge: .right, withInset: 10)

        cellContentView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        cellContentView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 32)

        timeView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        timeView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 32)
        timeView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        timeView.autoPinEdge(.right, to: .left, of: cellContentView, withOffset: 0)
    }
}
