//
//  String+Date.swift
//  CalenalaApp
//
//  Created by Krezelok, Daniel (Ext) on 10/11/16.
//  Copyright © 2016 Krezelok, Daniel. All rights reserved.
//

import Foundation

extension String {

    public func isInSameDay(date: String?) -> Bool {
        let dateFormatter = String.formatter()
        let calendar = Calendar.current

        guard let dateStr = date else {
            return false
        }

        guard let selfDate = dateFormatter.date(from: self) else {
            return false
        }

        guard let toDate = dateFormatter.date(from: dateStr) else {
            return false
        }

        let selfDay = calendar.component(.day, from: selfDate)
        let selfMonth = calendar.component(.month, from: selfDate)
        let selfYear = calendar.component(.year, from: selfDate)

        let toDay = calendar.component(.day, from: toDate)
        let toMonth = calendar.component(.month, from: toDate)
        let toYear = calendar.component(.year, from: toDate)

        if selfDay == toDay && selfMonth == toMonth && selfYear == toYear {
            return true
        }

        return false
    }

    public func populateBaseDate() -> String {
        var populatedStr = ""

        let dateFormatter = String.formatter()
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

        let dateFormatter = String.formatter()
        let date = dateFormatter.date(from: self)
        let calendar = Calendar.current

        let hours = calendar.component(.hour, from: date!)
        let minutes = calendar.component(.minute, from: date!)

        populatedStr = String(format: "%d:%.2d", hours, minutes)
        return populatedStr
    }

    public static func formatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return dateFormatter
    }
}
