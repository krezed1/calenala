//
//  AttendeeesCell.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 04/01/17.
//  Copyright © 2017 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class AttendeeesCell: UITableViewCell {

    static var attendeeesCellReuseIdentifier = "attendeeesCellReuseIdentifier"
    private var titleLabel: UILabel = UILabel()
    private var bottomSeparatorView: UIView = UIView()
    private let SEPARATOR_COLOR = UIColor(colorLiteralRed: 223/255, green: 223/255, blue: 223/255, alpha: 1)

    public var attendes: Array<Attende>? {
        didSet {
            guard let allAttendees = attendes, allAttendees.count > 0 else {
                return
            }

            var fullString = ""
            for attende in allAttendees {
                if let email = attende.email {
                    fullString = fullString + email + ", "
                }
            }

            fullString = String(format: "Attendees (%d)", allAttendees.count)
            titleLabel.text = fullString
        }
    }

//    MARK: LifeCycles

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViewItems()
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    MARK: Private

    private func setupViewItems() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(bottomSeparatorView)

        accessoryType = .disclosureIndicator
        
        titleLabel.textColor = .lightGray
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.numberOfLines = 4

        bottomSeparatorView.backgroundColor = SEPARATOR_COLOR
    }

    private func layoutView() {
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 32)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        titleLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)

        bottomSeparatorView.autoPinEdge(toSuperviewEdge: .bottom)
        bottomSeparatorView.autoMatch(.width, to: .width, of: self)
        bottomSeparatorView.autoSetDimension(.height, toSize: 2)
    }
}
