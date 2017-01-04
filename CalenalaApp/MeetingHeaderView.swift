//
//  MeetingHeaderView.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 29/12/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit

class MeetingHeaderView: UITableViewHeaderFooterView {
    static let MEETING_HEADER_IDENTIFIER = "MEETING_HEADER_IDENTIFIER"
    public var titleLabel: UILabel = UILabel()

// MARK: LifeCycles

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setUpCell()
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: Private

    private func setUpCell() {
        self.backgroundView = UIView()
        self.backgroundView?.backgroundColor = UIColor(colorLiteralRed: 66/255, green: 189/255, blue: 216/255, alpha: 1)

        contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 22)
    }

    private func layoutView() {
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
    }
}
