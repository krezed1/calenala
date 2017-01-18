//
//  CommentTableViewCell.swift
//  CalenalaApp
//
//  Created by Michael Pohl on 05.12.16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class CommentTableViewCell: UITableViewCell {
    
    static var commentTableViewCellReuseIdentifier = "commentTableViewCellReuseIdentifier"
    
    public var ratingView: RatingView = RatingView()
    public var timeAgoLabel: UILabel = UILabel()
    public var commentLabel: UILabel = UILabel()
    
    private let VERTICAL_SPACING = UIScreen.main.bounds.size.width * 15/320
    private let TIME_FONT_AND_SIZE = UIFont.systemFont(ofSize: 14)
    private let COMMENT_FONT_AND_SIZE = UIFont.systemFont(ofSize: 12)
    private let TEXT_COLOR = UIColor(colorLiteralRed: 153/255, green: 153/255, blue: 153/255, alpha: 1)
    
    public var attende: Attende? {
        didSet {
            
        if let rating = attende?.rating,
            let ratingDesc = attende?.ratingDesc,
            let numericRating = Int(rating) {
            ratingView.setRating(rating: numericRating)
            commentLabel.text = ratingDesc
//            timeAgoLabel.text = "4 hours ago" // TODO: změnit podle API
            }
        }
    }

//    MARK: LifeCycles

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViewItems()
        layoutView()
    }

//    MARK: Private

    private func setupViewItems() {
        contentView.addSubview(ratingView)
        contentView.addSubview(timeAgoLabel)
        contentView.addSubview(commentLabel)
        
        selectionStyle = .none
        backgroundColor = .white

        ratingView.isUserInteractionEnabled = false
        timeAgoLabel.text = NSLocalizedString("4 hours ago", comment: "")
        timeAgoLabel.font = TIME_FONT_AND_SIZE
        timeAgoLabel.textColor = TEXT_COLOR
        timeAgoLabel.textAlignment = .right
        
        commentLabel.text = NSLocalizedString("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nulla turpis magna, cursus sit amet, suscipit a, interdum id, felis. Donec iaculis gravida nulla. Nunc auctor. Integer pellentesque quam vel velit.", comment: "")
        commentLabel.font = COMMENT_FONT_AND_SIZE
        commentLabel.numberOfLines = 0
        commentLabel.textColor = TEXT_COLOR
    }
    
    private func layoutView() {
        ratingView.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        ratingView.autoPinEdge(toSuperviewEdge: .leading)
        ratingView.autoMatch(.height, to: .width, of: self, withMultiplier: 15/320)
        ratingView.autoPinEdge(toSuperviewEdge: .left, withInset: 40)

        timeAgoLabel.autoPinEdge(toSuperviewEdge: .trailing)
        timeAgoLabel.autoAlignAxis(.baseline, toSameAxisOf: ratingView)
        timeAgoLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 40)

        commentLabel.autoPinEdge(toSuperviewEdge: .leading)
        commentLabel.autoPinEdge(.top, to: .bottom, of: ratingView, withOffset: VERTICAL_SPACING)
        commentLabel.autoMatch(.width, to: .width, of: self, withMultiplier: 240/320)
        commentLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        commentLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
