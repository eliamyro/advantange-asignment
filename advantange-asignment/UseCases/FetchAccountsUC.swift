//
//  FetchAccountsUC.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Combine
import Foundation

protocol FetchAccountsUC {
    func execute() -> AnyPublisher<[APIAccount], RequestError>
}

class FetchAccountsUCImp: FetchAccountsUC {
    @Injected var repo: AccountsRepo

    func execute() -> AnyPublisher<[APIAccount], RequestError> {
        repo.fetchAccounts()
    }
}
