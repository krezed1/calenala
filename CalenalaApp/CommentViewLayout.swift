//
//  CommentViewLayout.swift
//  CalenalaApp
//
//  Created by Michael Pohl on 05.12.16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import UIKit
import PureLayout

class CommentViewLayout: UIView {
    
    private var ratingView: RatingView = RatingView()
    private var timeAgoLabel: UILabel = UILabel()
    public var commentLabel: UILabel = UILabel()
    
    private let VERTICAL_SPACING = UIScreen.main.bounds.size.width * 15/320
    private let TIME_FONT_AND_SIZE = UIFont.systemFont(ofSize: 14)
    private let COMMENT_FONT_AND_SIZE = UIFont.systemFont(ofSize: 12)
    private let TEXT_COLOR = UIColor(colorLiteralRed: 153/255, green: 153/255, blue: 153/255, alpha: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupViewItems()
        layoutView()
    }
    
    private func setupViewItems() {
        addSubview(ratingView)
        addSubview(timeAgoLabel)
        addSubview(commentLabel)
        
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
        ratingView.autoPinEdge(toSuperviewEdge: .top)
        ratingView.autoPinEdge(toSuperviewEdge: .leading)
        ratingView.autoMatch(.height, to: .width, of: self, withMultiplier: 15/320)
        
        timeAgoLabel.autoPinEdge(toSuperviewEdge: .trailing)
        timeAgoLabel.autoAlignAxis(.baseline, toSameAxisOf: ratingView)
        
        commentLabel.autoPinEdge(toSuperviewEdge: .leading)
        commentLabel.autoPinEdge(.top, to: .bottom, of: ratingView, withOffset: VERTICAL_SPACING)
        commentLabel.autoMatch(.width, to: .width, of: self, withMultiplier: 240/320)
        commentLabel.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
