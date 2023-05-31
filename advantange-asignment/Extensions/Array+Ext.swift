//
//  Array+Ext.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 31/5/23.
//

import Foundation

extension Array where Element == AccountModel {
    func sortAccounts() -> [AccountModel] {
        self.sorted { (item1, item2) in
            if item1.isFavorite && !item2.isFavorite {
                return true
            } else if !item1.isFavorite && item2.isFavorite {
                return false
            } else {
                return item1.id ?? "" < item2.id ?? ""
            }
        }
    }
}
