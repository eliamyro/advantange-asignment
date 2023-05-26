//
//  AccountDetailsVM.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Combine
import Foundation

class AccountDetailsVM {
    @Injected var fetchAccountDetailsUC: FetchAccountDetailsUC

    var account: APIAccount
    @Published var accountDetails: APIAccountDetails?
    var cancellables = Set<AnyCancellable>()

    init(account: APIAccount) {
        self.account = account
    }

    func fetchAccountDetails() {
        guard let accountId = account.id else { return }
        fetchAccountDetailsUC.execute(accountId: accountId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                guard case .failure(let error) = completion else { return }
                print(error.description)
            } receiveValue: { [weak self] accountDetails in
                guard let self = self else { return }
                self.accountDetails = accountDetails
            }
            .store(in: &cancellables)
    }
}
