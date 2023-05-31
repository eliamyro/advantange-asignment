//
//  AccountModel.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 27/5/23.
//

import Foundation

class AccountModel: CustomElementModel {
    var type: CustomElementType { .account }

    var id: String?
    var accountNumber: Int?
    var balance: String?
    var currencyCode: String?
    var accountType: String?
    var accountNickname: String?

    init(account: APIAccount) {
        self.id = account.id
        self.accountNumber = account.accountNumber
        self.balance = account.balance
        self.currencyCode = account.currencyCode
        self.accountType = account.accountType
        self.accountNickname = account.accountNickname
    }
}

extension AccountModel {
    var isFavorite: Bool {
        CoreDataManager.shared.isFavorite(id: id ?? "")
    }
}
