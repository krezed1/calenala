//
//  RatingView.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 11/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation
import UIKit

class RatingView: UIStackView {

    private static let BUTTON_OFF: UIImage = UIImage(named: "star-empty", in: nil, compatibleWith: nil)!
    private static let BUTTON_1: UIImage = UIImage(named: "star1-icon", in: nil, compatibleWith: nil)!
    private static let BUTTON_2: UIImage = UIImage(named: "star2-icon", in: nil, compatibleWith: nil)!
    private static let BUTTON_3: UIImage = UIImage(named: "star3-icon", in: nil, compatibleWith: nil)!
    private static let BUTTON_4: UIImage = UIImage(named: "star4-icon", in: nil, compatibleWith: nil)!
    private static let BUTTON_5: UIImage = UIImage(named: "star5-icon", in: nil, compatibleWith: nil)!
//    private static let BUTTON_SIZE: CGSize = CGSize(width: 64, height: 64)

    private var button1: UIButton = UIButton(type: .custom)
    private var button2: UIButton = UIButton(type: .custom)
    private var button3: UIButton = UIButton(type: .custom)
    private var button4: UIButton = UIButton(type: .custom)
    private var button5: UIButton = UIButton(type: .custom)

    init() {
        super.init(frame: CGRect.zero)
        alignment = .center
        axis = .horizontal
        spacing = -8

        setUpView()
        layoutView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: Public

    public func setRating(rating: Int) {
        switch rating {
        case 1:
            button1DidPress()
            break
        case 2:
            button2DidPress()
            break
        case 3:
            button3DidPress()
            break
        case 4:
            button4DidPress()
            break
        case 5:
            button5DidPress()
            break
        default:
            break
        }
    }

    public func getRating() -> Int {
        if button5.isSelected == true {
            return 5
        } else if button4.isSelected == true {
            return 4
        } else if button3.isSelected == true {
            return 3
        } else if button2.isSelected == true {
            return 2
        } else if button1.isSelected == true {
            return 1
        }

        return 0
    }

// MARK: Private

    private func setUpView() {
        addArrangedSubview(button1)
        addArrangedSubview(button2)
        addArrangedSubview(button3)
        addArrangedSubview(button4)
        addArrangedSubview(button5)

        button1.setImage(RatingView.BUTTON_OFF, for: .normal)
        button2.setImage(RatingView.BUTTON_OFF, for: .normal)
        button3.setImage(RatingView.BUTTON_OFF, for: .normal)
        button4.setImage(RatingView.BUTTON_OFF, for: .normal)
        button5.setImage(RatingView.BUTTON_OFF, for: .normal)

        button1.setImage(RatingView.BUTTON_1, for: .selected)
        button2.setImage(RatingView.BUTTON_2, for: .selected)
        button3.setImage(RatingView.BUTTON_3, for: .selected)
        button4.setImage(RatingView.BUTTON_4, for: .selected)
        button5.setImage(RatingView.BUTTON_5, for: .selected)

        button1.addTarget(self, action: #selector(button1DidPress), for: .touchUpInside)
        button2.addTarget(self, action: #selector(button2DidPress), for: .touchUpInside)
        button3.addTarget(self, action: #selector(button3DidPress), for: .touchUpInside)
        button4.addTarget(self, action: #selector(button4DidPress), for: .touchUpInside)
        button5.addTarget(self, action: #selector(button5DidPress), for: .touchUpInside)
    }

    private func layoutView() {
        button1.imageView?.autoMatch(.height, to: .height, of: self)
        button1.imageView?.autoMatch(.width, to: .height, of: self)
        button2.imageView?.autoMatch(.height, to: .height, of: self)
        button2.imageView?.autoMatch(.width, to: .height, of: self)
        button3.imageView?.autoMatch(.height, to: .height, of: self)
        button3.imageView?.autoMatch(.width, to: .height, of: self)
        button4.imageView?.autoMatch(.height, to: .height, of: self)
        button4.imageView?.autoMatch(.width, to: .height, of: self)
        button5.imageView?.autoMatch(.height, to: .height, of: self)
        button5.imageView?.autoMatch(.width, to: .height, of: self)

//        button1.autoSetDimensions(to: RatingView.BUTTON_SIZE)
//        button2.autoSetDimensions(to: RatingView.BUTTON_SIZE)
//        button3.autoSetDimensions(to: RatingView.BUTTON_SIZE)
//        button4.autoSetDimensions(to: RatingView.BUTTON_SIZE)
//        button5.autoSetDimensions(to: RatingView.BUTTON_SIZE)
    }

// MARK: UserActions

    func button1DidPress() {
        button1.isSelected = true
        button2.isSelected = false
        button3.isSelected = false
        button4.isSelected = false
        button5.isSelected = false
    }

    func button2DidPress() {
        button1.isSelected = true
        button2.isSelected = true
        button3.isSelected = false
        button4.isSelected = false
        button5.isSelected = false
    }

    func button3DidPress() {
        button1.isSelected = true
        button2.isSelected = true
        button3.isSelected = true
        button4.isSelected = false
        button5.isSelected = false
    }

    func button4DidPress() {
        button1.isSelected = true
        button2.isSelected = true
        button3.isSelected = true
        button4.isSelected = true
        button5.isSelected = false
    }

    func button5DidPress() {
        button1.isSelected = true
        button2.isSelected = true
        button3.isSelected = true
        button4.isSelected = true
        button5.isSelected = true
    }
}
