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
                self.accounts = accounts
            }
            .store(in: &cancellables)
    }
}
