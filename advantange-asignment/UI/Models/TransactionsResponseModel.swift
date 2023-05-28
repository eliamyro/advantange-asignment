//
//  TransactionsResponseModel.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 27/5/23.
//

import Foundation

class TransactionsResponseModel {
    var pagesCount: Int?
    var currentPage: Int?
    var transactions: [TransactionModel]? = []

    init(transactionResponse: APITransactionsResponse) {
        self.pagesCount = transactionResponse.paging?.pagesCount
        self.currentPage = transactionResponse.paging?.currentPage
        for transaction in transactionResponse.transactions ?? [] {
            transactions?.append(TransactionModel(transaction: transaction))
        }
    }
}

class TransactionModel: CustomElementModel {
    var type: CustomElementType { .transaction }

    var id: String?
    var date: String?
    var transactionAmount: String?
    var transactionType: String?
    var transactionDescription: String?
    var isDebit: Bool?

    init(transaction: APITransaction) {
        self.id = transaction.id
        self.date = transaction.date
        self.transactionType = transaction.transactionType
        self.transactionAmount = transaction.transactionAmount
        self.transactionDescription = transaction.transactionDescription
        self.isDebit = transaction.isDebit
    }
}
