//
//  EmailStackView.swift
//  CalenalaApp
//
//  Created by Michael Pohl on 05.12.16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import UIKit

class EmailStackView: UIStackView {
    
    private var firstEmailButton: UIButton = UIButton(type: .custom)
    private var secondEmailButton: UIButton = UIButton(type: .custom)
    private var LIGHT_GRAY_COLOR = UIColor(colorLiteralRed: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    
    private let CORNER_RADIUS: CGFloat = 5
    private let BORDER_WIDTH: CGFloat = 2

    init() {
        super.init(frame: CGRect.zero)
        alignment = .leading
        axis = .horizontal
        distribution = .fillProportionally
        spacing = 5
        
        setUpView()
    }
    
    private func setUpView() {
        addArrangedSubview(firstEmailButton)
        addArrangedSubview(secondEmailButton)
        
        firstEmailButton.layer.cornerRadius = CORNER_RADIUS
        firstEmailButton.layer.borderWidth = BORDER_WIDTH
        firstEmailButton.layer.borderColor = LIGHT_GRAY_COLOR.cgColor
        firstEmailButton.setTitle("zdenek.podhursky@gmail.com", for: .normal)
        firstEmailButton.setTitleColor(LIGHT_GRAY_COLOR, for: .normal)
        firstEmailButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        secondEmailButton.layer.cornerRadius = CORNER_RADIUS
        secondEmailButton.layer.borderWidth = BORDER_WIDTH
        secondEmailButton.layer.borderColor = LIGHT_GRAY_COLOR.cgColor
        secondEmailButton.setTitle("petr.riha@gmail.com", for: .normal)
        secondEmailButton.setTitleColor(LIGHT_GRAY_COLOR, for: .normal)
        secondEmailButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
