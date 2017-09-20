//
//  MeetingDetailView.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 09/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit

class MeetingDetailView: UITableView, UITextViewDelegate {
    
    private let BACKGROUND_COLOR = UIColor(colorLiteralRed: 66/255, green: 189/255, blue: 216/255, alpha: 1)
    private let BUTTON_BACKGROUND_COLOR = UIColor(colorLiteralRed: 238/255 , green: 215/255, blue: 75/255, alpha: 1)

    public let sendButton: UIButton = UIButton(type: .custom)

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setUpView()
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


// MARK: Private

    private func setUpView() {
        
        addSubview(sendButton)
        bringSubview(toFront: sendButton)
        layer.borderWidth = 10
        layer.borderColor = BACKGROUND_COLOR.cgColor
        backgroundColor = .white
        separatorStyle = .none
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = 100
        register(CreateCommentCell.self,
                 forCellReuseIdentifier: CreateCommentCell.createCommentCellReuseIdentifier)
        register(AttendeeesCell.self,
                 forCellReuseIdentifier: AttendeeesCell.attendeeesCellReuseIdentifier)
        register(CommentTableViewCell.self,
                 forCellReuseIdentifier: CommentTableViewCell.commentTableViewCellReuseIdentifier)
        register(TitleTableViewCell.self,
                 forCellReuseIdentifier: TitleTableViewCell.titleTableViewCellReuseIdentifier)
        register(LocationTableViewCell.self,
                 forCellReuseIdentifier: LocationTableViewCell.locationTableViewCellReuseIdentifier)
        contentInset = UIEdgeInsetsMake(0, 0, 60, 0)

        sendButton.isHidden = true
        sendButton.setTitle("Send comment", for: .normal)
        sendButton.setTitleColor(UIColor.black, for: .normal)
        sendButton.backgroundColor = BUTTON_BACKGROUND_COLOR
    }

    private func layoutView() {
//        TODO: Pouzit purelayout
        sendButton.frame = CGRect(x: 10, y: UIScreen.main.bounds.height - 134, width: UIScreen.main.bounds.width - 20, height: 60)
//        sendButton.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
//        sendButton.autoMatch(.width, to: .width, of: self)
//        sendButton.autoPinEdge(toSuperviewEdge: .bottom, withInset:0)
//        sendButton.autoSetDimension(.height, toSize: 60)
   }

}
