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
    let repo = AccountsRepoImp()

    func execute() -> AnyPublisher<[APIAccount], RequestError> {
        repo.fetchAccounts()
    }
}
