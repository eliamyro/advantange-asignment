//
//  FetchAccountDetailsUC.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Combine
import Foundation

protocol FetchAccountDetailsUC {
    func execute(accountId: String) -> AnyPublisher<APIAccountDetails, RequestError>
}

class FetchAccountDetailsUCImp: FetchAccountDetailsUC {
    @Injected var repo: AccountsRepo

    func execute(accountId: String) -> AnyPublisher<APIAccountDetails, RequestError> {
        repo.fetchAccountDetails(accountId: accountId)
    }
}
