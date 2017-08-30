//
//  LocationTableViewCell.swift
//  CalenalaApp
//
//  Created by Michael Pohl on 20.12.16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class LocationTableViewCell: UITableViewCell {
    
    static var locationTableViewCellReuseIdentifier = "locationTableViewCellReuseIdentifier"
    
    private var whereIcon: UIImageView = UIImageView()
    public var whenValueLabel: UILabel = UILabel()

    private var whenIcon: UIImageView = UIImageView()
    public var whereValueLabel: UILabel = UILabel()
    private var bottomSeparatorView: UIView = UIView()
    
    static let LABEL_FONT = UIFont.systemFont(ofSize: 14)
    private let WHERE_IMAGE = UIImage(named: "location-icon")
    private let WHEN_IMAGE = UIImage(named: "time-icon")
    private let VERTICAL_INSET = UIScreen.main.bounds.size.width * 20/320
    private let TEXT_COLOR = UIColor(colorLiteralRed: 153/255, green: 153/255, blue: 153/255, alpha: 1)
    private let SEPARATOR_COLOR = UIColor(colorLiteralRed: 223/255, green: 223/255, blue: 223/255, alpha: 1)
    
    public var meeting: MeetingDetail? {
        didSet {

            if let meetingRoom = meeting?.locationName, meetingRoom.characters.count > 0 {
                whereValueLabel.text = meetingRoom
            } else {
                whereValueLabel.text = NSLocalizedString("None", comment: "")
            }

            if let timeInterval = meeting?.populatedMeetingInterval {
                whenValueLabel.text = timeInterval
            }
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViewItems()
        layoutView()
    }
    
    private func setupViewItems() {
        contentView.addSubview(whereIcon)
        contentView.addSubview(whereValueLabel)
        contentView.addSubview(whenIcon)
        contentView.addSubview(whenValueLabel)
        contentView.addSubview(bottomSeparatorView)
        
        selectionStyle = .none
        backgroundColor = .white
        
        whereIcon.image = WHERE_IMAGE

        whereValueLabel.textColor = UIColor.gray
        whereValueLabel.font = LocationTableViewCell.LABEL_FONT

        whenIcon.image = WHEN_IMAGE

        whenValueLabel.textColor = UIColor.gray
        whenValueLabel.font = LocationTableViewCell.LABEL_FONT
        
        bottomSeparatorView.backgroundColor = SEPARATOR_COLOR
    }
    
    private func layoutView() {
        whereIcon.autoPinEdge(toSuperviewEdge: .top, withInset: VERTICAL_INSET * 1.5)
        whereIcon.autoAlignAxis(.vertical, toSameAxisOf: self, withMultiplier: 0.3)

        whereValueLabel.autoAlignAxis(.horizontal, toSameAxisOf: whereIcon)
        whereValueLabel.autoPinEdge(.leading, to: .trailing, of: whereIcon, withOffset: 10)

        whenIcon.autoAlignAxis(.vertical, toSameAxisOf: whereIcon)
        whenIcon.autoPinEdge(.top, to: .bottom, of: whereIcon, withOffset: VERTICAL_INSET)

        whenValueLabel.autoAlignAxis(.horizontal, toSameAxisOf: whenIcon)
        whenValueLabel.autoPinEdge(.leading, to: .leading, of: whereValueLabel)
        whenValueLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: VERTICAL_INSET * 1.5)

        bottomSeparatorView.autoPinEdge(toSuperviewEdge: .bottom)
        bottomSeparatorView.autoMatch(.width, to: .width, of: self)
        bottomSeparatorView.autoSetDimension(.height, toSize: 1)

        whenValueLabel.autoSetDimension(.height, toSize: 18)
        whereValueLabel.autoSetDimension(.height, toSize: 18)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
