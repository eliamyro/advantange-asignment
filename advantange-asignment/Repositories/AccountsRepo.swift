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
    func fetchAccountDetails(accountId: String) -> AnyPublisher<APIAccountDetails, RequestError>
    func fetchTransactions(accountId: String, page: Int, fromDate: String, toDate: String) -> AnyPublisher<APITransactionsResponse, RequestError>
}

class AccountsRepoImp: AccountsRepo {
    @Injected var client: HTTPClient

    func fetchAccounts() -> AnyPublisher<[APIAccount], RequestError> {
        client.sendRequest(endpoint: AccountsEndpoint.accounts, responseType: [APIAccount].self)
    }

    func fetchAccountDetails(accountId: String) -> AnyPublisher<APIAccountDetails, RequestError> {
        client.sendRequest(endpoint: AccountsEndpoint.accountDetails(accountId: accountId), responseType: APIAccountDetails.self)
    }

    func fetchTransactions(accountId: String, page: Int, fromDate: String, toDate: String) -> AnyPublisher<APITransactionsResponse, RequestError> {
        client.sendRequest(endpoint: AccountsEndpoint.transactions(accountId: accountId, page: page, fromDate: fromDate, toDate: toDate), responseType: APITransactionsResponse.self)
    }
}
