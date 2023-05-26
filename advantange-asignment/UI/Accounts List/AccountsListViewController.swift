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

        bind()
        setupUI()
        configureViews()
        registerCells()

        viewModel.fetchAccounts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Accounts"
    }

    private func registerCells() {
        accountsTableView.register(AccountCell.self, forCellReuseIdentifier: AccountCell.id)
    }

    private func bind() {
        viewModel.$accounts
            .receive(on: DispatchQueue.main)
            .sink { _ in
            self.accountsTableView.reloadData()
        }
        .store(in: &viewModel.cancellables)
    }

    func navigateToDetails(with account: APIAccount) {
        let viewModel = AccountDetailsVM(account: account)
        let accountDetailsController = AccountDetailsViewController(viewModel: viewModel)
        navigationController?.show(accountDetailsController, sender: nil)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let account = viewModel.accounts[indexPath.row]
        navigateToDetails(with: account)
    }
}
