//
//  TitleTableViewCell.swift
//  CalenalaApp
//
//  Created by Michael Pohl on 20.12.16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class TitleTableViewCell: UITableViewCell {
    
    static var titleTableViewCellReuseIdentifier = "titleTableViewCellReuseIdentifier"
    
    public var titleLabel: UILabel = UILabel()
    public var ratingView: RatingView = RatingView()
    private var bottomSeparatorView: UIView = UIView()
    
    private let VERTICAL_INSET = UIScreen.main.bounds.size.width * 20/320
    private let TEXT_COLOR = UIColor(colorLiteralRed: 153/255, green: 153/255, blue: 153/255, alpha: 1)
    private let SEPARATOR_COLOR = UIColor(colorLiteralRed: 223/255, green: 223/255, blue: 223/255, alpha: 1)
    
    public var meeting: Meeting? {
        didSet {
            
            if let name = meeting?.name,
                let organizer = meeting?.organizer {
                titleLabel.text = name + " - " + organizer
                if let rating = meeting?.rating?.intValue,
                    let ratedByMe = meeting?.ratedByMe?.boolValue,
                    ratedByMe == true {
                    ratingView.setRating(rating: rating)
                }
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViewItems()
        layoutView()
    }
    
    private func setupViewItems() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingView)
        contentView.addSubview(bottomSeparatorView)
        
        selectionStyle = .none
        backgroundColor = .white
        
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center

        ratingView.isUserInteractionEnabled = false
        
        bottomSeparatorView.backgroundColor = SEPARATOR_COLOR
    }
    
    private func layoutView() {
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16)

        ratingView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: VERTICAL_INSET)
        ratingView.autoAlignAxis(toSuperviewAxis: .vertical)
        ratingView.autoMatch(.height, to: .width, of: self, withMultiplier: 17/320)
        
        bottomSeparatorView.autoPinEdge(.top, to: .bottom, of: ratingView, withOffset: VERTICAL_INSET)
        bottomSeparatorView.autoSetDimension(.height, toSize: 1)
        bottomSeparatorView.autoAlignAxis(toSuperviewAxis: .vertical)
        bottomSeparatorView.autoMatch(.width, to: .width, of: self)
        bottomSeparatorView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
