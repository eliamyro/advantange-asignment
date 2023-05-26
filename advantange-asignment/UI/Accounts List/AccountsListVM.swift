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

    @Published var accounts: [APIAccount] = []
    var cancellables = Set<AnyCancellable>()

    func fetchAccounts() {
        fetchAccountsUC.execute()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                guard case .failure(let error) = completion else { return }
                print(error.description)
            } receiveValue: { [weak self] accounts in
                guard let self = self else { return }
                self.accounts = accounts
            }
            .store(in: &cancellables)
    }
}
