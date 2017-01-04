//
//  CreateCommentCell.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 04/01/17.
//  Copyright © 2017 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class CreateCommentCell: UITableViewCell, UITextViewDelegate {

    static var createCommentCellReuseIdentifier = "createCommentCellReuseIdentifier"
    public let textView: UITextView = UITextView()

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
        contentView.addSubview(textView)

        selectionStyle = .none

        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.textColor = UIColor.lightGray
        textView.text = NSLocalizedString("Write your comment here", comment: "")
        textView.delegate = self
    }

    private func layoutView() {
        textView.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
        textView.autoPinEdge(toSuperviewEdge: .right, withInset: 40)
        textView.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        textView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        textView.autoSetDimension(.height, toSize: 150)
    }

//    MARK: UITextViewDelegate

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
            textView.font = UIFont.systemFont(ofSize: 16)
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = NSLocalizedString("Write your comment here", comment: "")
            textView.font = UIFont.systemFont(ofSize: 10)
            textView.textColor = UIColor.lightGray
        }
    }
}
