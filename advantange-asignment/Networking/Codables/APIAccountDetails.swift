//
//  APIAccountDetails.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Foundation

// MARK: - APIAccountDetails
struct APIAccountDetails: Codable {
    var productName: String?
    var openedDate: String?
    var branch: String?
    var beneficiaries: [String]?

    enum CodingKeys: String, CodingKey {
        case branch, beneficiaries
        case productName = "product_name"
        case openedDate = "opened_date"
    }
}
