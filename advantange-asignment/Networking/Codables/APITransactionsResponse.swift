//
//  APITransactionsResponse.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Foundation

// MARK: - APITransactionsResponse
struct APITransactionsResponse: Codable {
    var transactions: [APITransaction]?
    var paging: APITransactionPaging?
}

// MARK: - APITransaction
class APITransaction: Codable, CustomElementModel {
    var type: CustomElementType { .transaction }


    var id: String?
    var date: String?
    var transactionAmount: String?
    var transactionType: String?
    var transactionDescription: String?
    var isDebit: Bool?

    enum CodingKeys: String, CodingKey {
        case id, date
        case transactionAmount = "transaction_amount"
        case transactionType = "transaction_type"
        case transactionDescription = "description"
        case isDebit = "is_debit"
    }
}

// MARK: - APITransactionPaging
struct APITransactionPaging: Codable {
    var pagesCount: Int?
    var totalItems: Int?
    var currentPage: Int?

    enum CodingKeys: String, CodingKey {
        case pagesCount = "pages_count"
        case totalItems = "total_items"
        case currentPage = "current_page"
    }
}
