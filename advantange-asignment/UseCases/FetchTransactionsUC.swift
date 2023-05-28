//
//  FetchTransactionsUC.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Combine
import Foundation

protocol FetchTransactionsUC {
    func execute(accountId: String, page: Int, fromDate: String?, toDate: String?) -> AnyPublisher<TransactionsResponseModel?, RequestError>
}

class FetchTransactionUCImp: FetchTransactionsUC {
    @Injected var repo: AccountsRepo

    func execute(accountId: String, page: Int, fromDate: String?, toDate: String?) -> AnyPublisher<TransactionsResponseModel?, RequestError> {
        repo.fetchTransactions(accountId: accountId, page: page, fromDate: fromDate, toDate: toDate)
            .map { TransactionsResponseModel(transactionResponse: $0) }
            .eraseToAnyPublisher()
    }
}
