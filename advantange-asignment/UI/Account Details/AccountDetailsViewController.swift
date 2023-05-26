//
//  AccountDetailsViewController.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import UIKit

class AccountDetailsViewController: UIViewController {

    // MARK: - Properties

    let viewModel: AccountDetailsVM

    // MARK: - Lifecycle

    init(viewModel: AccountDetailsVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupUI()
//        viewModel.fetchAccountDetails()
        viewModel.fetchTransactions()
    }

    // MARK: - Private Methods

    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Account Details"
    }

    private func bind() {
        viewModel.$accountDetails
            .receive(on: DispatchQueue.main)
            .sink { accountDetails in
                print("AccountDetails: \(accountDetails?.productName ?? "")")
            }
            .store(in: &viewModel.cancellables)
    }
}
