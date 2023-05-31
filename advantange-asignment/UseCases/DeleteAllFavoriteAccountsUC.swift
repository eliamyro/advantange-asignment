//
//  DeleteAllFavoriteAccountsUC.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 31/5/23.
//

import Combine
import Foundation

protocol DeleteAllFavoriteAccountsUC {
    func execute() -> AnyPublisher<Bool, Never>
}

class DeleteAllFavoriteAccountsUCImp: DeleteAllFavoriteAccountsUC {
    @Injected var repo: AccountsRepo

    func execute() -> AnyPublisher<Bool, Never> {
        repo.deleteAllFavoriteAccounts()
    }
}

