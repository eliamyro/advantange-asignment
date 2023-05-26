//
//  FetchTransactionsUC.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Combine
import Foundation

protocol FetchTransactionsUC {
    func execute(accountId: String, page: Int, fromDate: String, toDate: String) -> AnyPublisher<APITransactionsResponse, RequestError>
}

class FetchTransactionUCImp: FetchTransactionsUC {
    @Injected var repo: AccountsRepo

    func execute(accountId: String, page: Int, fromDate: String, toDate: String) -> AnyPublisher<APITransactionsResponse, RequestError> {
        repo.fetchTransactions(accountId: accountId, page: page, fromDate: fromDate, toDate: toDate)
    }
}
