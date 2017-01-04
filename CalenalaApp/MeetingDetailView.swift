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

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setUpView()
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: Public

    public func disableMessageView() {
    }

// MARK: Private

    private func setUpView() {
        layer.borderWidth = 10
        layer.borderColor = BACKGROUND_COLOR.cgColor
        backgroundColor = .white
        separatorStyle = .none
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = 100
        register(CommentTableViewCell.self,
                 forCellReuseIdentifier: CommentTableViewCell.commentTableViewCellReuseIdentifier)
        register(TitleTableViewCell.self,
                 forCellReuseIdentifier: TitleTableViewCell.titleTableViewCellReuseIdentifier)
        register(LocationTableViewCell.self,
                 forCellReuseIdentifier: LocationTableViewCell.locationTableViewCellReuseIdentifier)
        

    }

    private func layoutView() {

   }

// messageView placeholder settings
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if messageView.textColor == UIColor.lightGray {
//            messageView.text = nil
//            messageView.textColor = UIColor.black
//            messageView.font = UIFont.systemFont(ofSize: 16)
//        }
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if messageView.text.isEmpty {
//            messageView.text = NSLocalizedString("Write your comment here", comment: "")
//            messageView.font = UIFont.systemFont(ofSize: 10)
//            messageView.textColor = UIColor.lightGray
//        }
//    }
}
