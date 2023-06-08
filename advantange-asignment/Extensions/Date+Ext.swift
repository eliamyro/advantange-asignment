//
//  Date+Ext.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 8/6/23.
//

import Foundation

extension Date {
    func formatedDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

        return dateFormatter.string(from: self)
    }
}
