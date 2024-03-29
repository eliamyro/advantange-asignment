//
//  AccountDetailsVM.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Combine
import Foundation

struct Section {
    var title: String?
    var elements: [CustomElementModel]
}

class AccountDetailsVM {
    @Injected var fetchAccountDetailsUC: FetchAccountDetailsUC
    @Injected var fetchTransactionsUC: FetchTransactionsUC
    @Injected var saveFavoriteAccountUC: SaveFavoriteAccountUC
    @Injected var deleteAllFavoriteAccountsUC: DeleteAllFavoriteAccountsUC

    var loaderSubject = CurrentValueSubject<Bool, Never>(false)
    var reloadAccountSubject = PassthroughSubject<AccountModel, Never>()
    @Published var data = [Section]()
    var cancellables = Set<AnyCancellable>()

    var account: AccountModel
    var page = 0
    var pagesCount = 0
    var transactionFromDate: String?
    var transactionToDate: String?

    init(account: AccountModel) {
        self.account = account
    }

    func fetchData() {
        loaderSubject.send(true)

        self.data.append(Section(elements: [self.account]))
        
        Publishers.CombineLatest(fetchAccountDetails(), fetchTransactions())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] details, transactionsResponse in
                guard let self = self else { return }
                self.loaderSubject.send(false)
                if let details = details {
                    details.accountType = self.account.accountType
                    self.data.append(Section(elements: [details]))
                }

                if let response = transactionsResponse {
                    self.appendTransactions(transactionsResponse: response)
                }
            }
            .store(in: &cancellables)
    }

    func appendTransactions(transactionsResponse: TransactionsResponseModel) {
        if let pagesCount = transactionsResponse.pagesCount {
            self.pagesCount = pagesCount
            self.page += 1
        }

        if let transactions = transactionsResponse.transactions {
            _ = transactions.sorted { $0.date ?? "" > $1.date ?? "" }
            transactions.forEach { transaction in
                if !self.data.contains(where: { $0.title == transaction.date?.toMonthYearFormat() }) {
                    self.data.append(Section(title: transaction.date?.toMonthYearFormat() ?? "", elements: [transaction]))
                } else {
                    guard let index = self.data.firstIndex(where: { $0.title == transaction.date?.toMonthYearFormat() }) else { return }
                    self.data[index].elements.append(transaction)
                }
            }
        }
    }

    func fetchAccountDetails() -> AnyPublisher<AccountDetailsModel?, Never> {
        return fetchAccountDetailsUC.execute(accountId: account.id ?? "")
            .catch { error -> Just<AccountDetailsModel?> in
                print(error)
                return Just(nil)
            }
            .eraseToAnyPublisher()
    }

    func fetchTransactions() -> AnyPublisher<TransactionsResponseModel?, Never> {
        return fetchTransactionsUC.execute(accountId: account.id ?? "", page: page, fromDate: transactionFromDate, toDate: transactionToDate)
            .catch { error -> Just<TransactionsResponseModel?> in
                print(error)
                return Just(nil)
            }
            .eraseToAnyPublisher()
    }

    func fetchNextPageTransactions() {
        guard page < pagesCount - 1  else { return }
        loaderSubject.send(true)

        fetchTransactions()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] transactionsResponse in
                guard let self = self else { return }
                self.loaderSubject.send(false)
                if let response = transactionsResponse {
                    self.appendTransactions(transactionsResponse: response)
                }
            }
            .store(in: &cancellables)
    }

    func updateFavoriteToCoreData() {
        let isFavorite = account.isFavorite

        deleteAllFavoriteAccountsUC.execute()
            .sink { [weak self] isDeleted in
                guard let self = self else { return }
                if isDeleted {
                    if isFavorite {
                        self.reloadAccountSubject.send(self.account)
                    } else {
                        self.saveFavoriteAccountUC.execute(account: self.account)
                            .sink(receiveValue: { isSaved in
                                if isSaved { self.reloadAccountSubject.send(self.account) }
                            })
                            .store(in: &self.cancellables)
                    }
                }
            }
            .store(in: &cancellables)
    }

    func fetchTransactionsWithDateRange(fromDate: String? = nil, toDate: String? = nil) {
        // Initialize values
        pagesCount = 0
        page = 0

        self.transactionFromDate = fromDate
        self.transactionToDate = toDate

        // Remove the existing transactions
        if 2 < data.count {
            data.removeSubrange(2...)
        }

        self.loaderSubject.send(true)

        fetchTransactions()
            .receive(on: DispatchQueue.main)
            .sink { transactionsResponse in
                self.loaderSubject.send(false)

                if let response = transactionsResponse {
                    self.appendTransactions(transactionsResponse: response)
                }
            }
            .store(in: &cancellables)
    }
}
