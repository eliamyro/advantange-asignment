//
//  AccountsListVM.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Combine
import Foundation

class AccountsListVM {
    
    @Injected var fetchAccountsUC: FetchAccountsUC
    @Injected var saveFavoriteAccountUC: SaveFavoriteAccountUC
    @Injected var deleteAllFavoriteAccountsUC: DeleteAllFavoriteAccountsUC

    @Published var accounts: [AccountModel] = []
    var loaderSubject = CurrentValueSubject<Bool, Never>(false)
    var cancellables = Set<AnyCancellable>()

    func fetchAccounts() {
        loaderSubject.send(true)

        fetchAccountsUC.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.loaderSubject.send(false)
                guard case .failure(let error) = completion else { return }
                print(error.description)
            } receiveValue: { [weak self] accounts in
                guard let self = self else { return }
                self.loaderSubject.send(false)
                self.accounts = accounts.sortAccounts()
            }
            .store(in: &cancellables)
    }

    func updateFavoriteToCoreData(indexPath: IndexPath) {
        let isFavorite = accounts[indexPath.row].isFavorite
        let account = accounts[indexPath.row]

        deleteAllFavoriteAccountsUC.execute()
            .sink { [weak self] isDeleted in
                guard let self = self else { return }
                if isDeleted {
                    if isFavorite {
                        self.accounts = self.accounts.sortAccounts()
                    } else {
                        self.saveFavoriteAccountUC.execute(account: account)
                            .sink(receiveValue: { isSaved in
                                if isSaved {
                                    self.accounts = self.accounts.sortAccounts()
                                }
                            })
                            .store(in: &self.cancellables)
                    }
                }
            }
            .store(in: &cancellables)
    }
}
