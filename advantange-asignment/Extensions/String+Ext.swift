//
//  String+Ext.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 28/5/23.
//

import Foundation

extension String {
    
    func toMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let date = dateFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMMM yyyy"
            outputFormatter.locale = Locale.current
            let formattedDate = outputFormatter.string(from: date)
            return formattedDate
        } else { return "" }
    }
}
