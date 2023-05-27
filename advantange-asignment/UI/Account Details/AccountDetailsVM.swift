//
//  AccountDetailsVM.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Combine
import Foundation

struct SectionElement {
    var title: String
    var element: CustomElementModel
}

class AccountDetailsVM {
    @Injected var fetchAccountDetailsUC: FetchAccountDetailsUC
    @Injected var fetchTransactionsUC: FetchTransactionsUC

    var account: AccountModel
    @Published var accountDetails: APIAccountDetails?
    @Published var elements: [CustomElementModel] = []
    @Published var sections = [SectionElement]()
    var cancellables = Set<AnyCancellable>()

    init(account: AccountModel) {
        self.account = account
    }

    func fetchData() {
        self.elements.append(self.account)
        
        Publishers.CombineLatest(fetchAccountDetails(), fetchTransactions())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] details, transaction in
                guard let self = self else { return }
                if let details = details {
                    details.accountType = self.account.accountType
                    self.elements.append(details)
                }

                if let transactions = transaction?.transactions {
                    self.elements.append(contentsOf: transactions)
                }
            }
            .store(in: &cancellables)
    }

    func fetchAccountDetails() -> AnyPublisher<AccountDetailsModel?, Never> {
        return fetchAccountDetailsUC.execute(accountId: account.id ?? "")
            .catch { error -> Just<AccountDetailsModel?> in
                print(error)
                return Just(nil)
            }
            .eraseToAnyPublisher()
    }

    func fetchTransactions() -> AnyPublisher<APITransactionsResponse?, Never> {
        return fetchTransactionsUC.execute(accountId: account.id ?? "", page: 0, fromDate: nil, toDate: nil)
            .catch { error -> Just<APITransactionsResponse?> in
                print(error)
                return Just(nil)
            }
            .eraseToAnyPublisher()
    }
}
