//
//  AccountDetailsModel.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 27/5/23.
//

import Foundation

class AccountDetailsModel: CustomElementModel {
    var type: CustomElementType { .details }

    var accountType: String?
    var productName: String?
    var openedDate: String?
    var branch: String?
    var beneficiaries: [String]?

    init() {}

    init(accountDetails: APIAccountDetails) {
        self.productName = accountDetails.productName
        self.openedDate = accountDetails.openedDate
        self.branch = accountDetails.branch
        self.beneficiaries = accountDetails.beneficiaries
    }
}
