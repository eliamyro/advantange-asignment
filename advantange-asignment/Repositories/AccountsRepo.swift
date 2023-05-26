//
//  AccountsRepo.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Combine
import Foundation

protocol AccountsRepo {
    func fetchAccounts() -> AnyPublisher<[APIAccount], RequestError>
}

class AccountsRepoImp: AccountsRepo {
    @Injected var client: HTTPClient

    func fetchAccounts() -> AnyPublisher<[APIAccount], RequestError> {
        client.sendRequest(endpoint: AccountsEndpoint.accounts, responseType: [APIAccount].self)
    }
}
