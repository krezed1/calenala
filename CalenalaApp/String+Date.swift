//
//  String+Date.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 10/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation

extension String {

    public func populateBaseDate() -> String {
        var populatedStr = ""

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        let calendar = Calendar.current

        let weekDay = dateFormatter.shortWeekdaySymbols[calendar.component(.weekday, from: date!)-1]
        let days = calendar.component(.day, from: date!)
        let months = dateFormatter.monthSymbols[calendar.component(.month, from: date!)-1]

        populatedStr = String(format: "%@, %@ %d", weekDay, months, days)
        return populatedStr
    }

    public func populateHours() -> String {
        var populatedStr = ""

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        let calendar = Calendar.current

        let hours = calendar.component(.hour, from: date!)
        let minutes = calendar.component(.minute, from: date!)

        populatedStr = String(format: "%d:%.2d", hours, minutes)
        return populatedStr
    }
}
