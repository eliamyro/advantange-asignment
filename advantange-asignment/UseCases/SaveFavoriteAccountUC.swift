//
//  SaveFavoriteAccountUC.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 31/5/23.
//

import Combine
import Foundation

protocol SaveFavoriteAccountUC {
    func execute(account: AccountModel) -> AnyPublisher<Bool, Never>
}

class SaveFavoriteAccountUCImp: SaveFavoriteAccountUC {
    @Injected var repo: AccountsRepo

    func execute(account: AccountModel) -> AnyPublisher<Bool, Never> {
        repo.saveFavoriteAccount(account: account)
    }
}
