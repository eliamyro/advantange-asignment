//
//  APIAccount.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Foundation

// MARK: - APIAccount
struct APIAccount: Codable {
    var id: String?
    var accountNumber: Int?
    var balance: Double?
    var currencyCode: String?
    var accountType: String?
    var accountNickname: String?

    enum CodingKeys: String, CodingKey {
        case id, balance
        case accountNumber = "account_number"
        case currencyCode = "currency_code"
        case accountType = "account_type"
        case accountNickname = "account_nickname"
    }
}

extension APIAccount {
    static let fakeAccount = APIAccount(id: "1f34c76a-b3d1-43bc-af91-a82716f1bc2e",
                                        accountNumber: 12345,
                                        balance: 99.00,
                                        currencyCode: "EUR",
                                        accountType: "current",
                                        accountNickname: "My Salary")
}
