//
//  FetchAccountsUC.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Combine
import Foundation

protocol FetchAccountsUC {
    func execute() -> AnyPublisher<[AccountModel], RequestError>
}

class FetchAccountsUCImp: FetchAccountsUC {
    @Injected var repo: AccountsRepo

    func execute() -> AnyPublisher<[AccountModel], RequestError> {
        repo.fetchAccounts()
            .map { apiAccounts in
                apiAccounts.map { apiAccount in
                    AccountModel(account: apiAccount)
                }
            }
            .eraseToAnyPublisher()
    }
}
