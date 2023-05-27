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
    @Injected var fetchTransactionsUC: FetchTransactionsUC

    var account: AccountModel
    @Published var accountDetails: APIAccountDetails?
    var cancellables = Set<AnyCancellable>()

    init(account: AccountModel) {
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

    func fetchTransactions() {
        guard let accountId = account.id else { return }
        fetchTransactionsUC.execute(accountId: accountId, page: 0, fromDate: "2018-05-16T13:15:30+03:00", toDate: "2018-05-16T13:15:30+03:00")
            .receive(on: DispatchQueue.main)
            .sink { completion in
                guard case .failure(let error) = completion else { return }
                print(error.description)
            } receiveValue: { transactionsResponse in
//                guard let self = self else { return }
                print("Fetch transactions: \(transactionsResponse.paging?.pagesCount ?? 0)")
            }
            .store(in: &cancellables)
    }
}
