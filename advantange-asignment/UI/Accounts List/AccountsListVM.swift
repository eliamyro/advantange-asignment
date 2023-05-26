//
//  AccountsListVM.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Foundation

class AccountsListVM {
    var accounts: [APIAccount] = []

    func createDummyAccounts() {
        for _ in 0 ... 5 {
            accounts.append(APIAccount.fakeAccount)
        }
    }
}
