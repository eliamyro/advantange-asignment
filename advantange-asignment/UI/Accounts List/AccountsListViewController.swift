//
//  AccountsListViewController.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import UIKit

class AccountsListViewController: UIViewController {

    // MARK: - Views

    private lazy var accountsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    // MARK: - Properties

    let viewModel: AccountsListVM

    // MARK: - Lifecycle

    init(viewModel: AccountsListVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setupUI()
        configureViews()
        viewModel.createDummyAccounts()
        registerCells()
    }

    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Accounts"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func registerCells() {
        accountsTableView.register(AccountCell.self, forCellReuseIdentifier: AccountCell.id)
    }
}


// MARK: - Setup Constraints

extension AccountsListViewController {
    func configureViews() {
        configureAccountsTableView()
    }

    private func configureAccountsTableView() {
        view.addSubview(accountsTableView)

        NSLayoutConstraint.activate([
            accountsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            accountsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            accountsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            accountsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate

extension AccountsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.accounts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountCell.id, for: indexPath)
                as? AccountCell else { return UITableViewCell() }

        let account = viewModel.accounts[indexPath.row]
        cell.setup(with: account)

        return cell
    }
}
