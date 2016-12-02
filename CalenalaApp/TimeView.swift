//
//  TimeView.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 30/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit

class TimeView: UIView {

    public var startLabel: UILabel = UILabel()
    public var endLabel: UILabel = UILabel()
    public var lineView: UIView = UIView()

    // MARK: LifeCycles

    init() {
        super.init(frame: CGRect.zero)
        setUpCell()
        layoutView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private

    private func setUpCell() {
        addSubview(startLabel)
        addSubview(endLabel)
        addSubview(lineView)


        startLabel.textColor = UIColor.white
        endLabel.textColor = UIColor.white

        startLabel.font = UIFont.systemFont(ofSize: 10)
        endLabel.font = UIFont.systemFont(ofSize: 10)

        lineView.backgroundColor = UIColor.white
    }

    private func layoutView() {
        startLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        startLabel.autoAlignAxis(toSuperviewAxis: .vertical)

        endLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        endLabel.autoAlignAxis(toSuperviewAxis: .vertical)

        lineView.autoPinEdge(.top, to: .bottom, of: startLabel, withOffset: 4)
        lineView.autoPinEdge(.bottom, to: .top, of: endLabel, withOffset: -4)
        lineView.autoSetDimension(.width, toSize: 1)
        lineView.autoAlignAxis(toSuperviewAxis: .vertical)
   }
}
