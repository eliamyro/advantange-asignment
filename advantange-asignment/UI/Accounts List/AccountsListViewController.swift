//
//  AccountsListViewController.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import UIKit

class AccountsListViewController: UIViewController {

    // MARK: - Views

    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .systemBlue
        indicator.translatesAutoresizingMaskIntoConstraints = false

        return indicator
    }()

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
        accountsTableView.register(AccountCell.self, forCellReuseIdentifier: CustomElementType.account.rawValue)
    }

    private func bind() {
        viewModel.loaderSubject.sink { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
        .store(in: &viewModel.cancellables)

        viewModel.$accounts
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.accountsTableView.reloadData()
            }
            .store(in: &viewModel.cancellables)
    }

    func navigateToDetails(with account: AccountModel) {
        let detailsVM = AccountDetailsVM(account: account)
        let accountDetailsController = AccountDetailsViewController(viewModel: detailsVM)
        accountDetailsController.viewModel.reloadAccountSubject
            .receive(on: DispatchQueue.main)
            .sink { model in
                self.viewModel.accounts = self.viewModel.accounts.sortAccounts()
            }.store(in: &viewModel.cancellables)
        navigationController?.show(accountDetailsController, sender: nil)
    }
}


// MARK: - Setup Constraints

extension AccountsListViewController {
    func configureViews() {
        configureAccountsTableView()
        configureIndicatorView()
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

    private func configureIndicatorView() {
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.heightAnchor.constraint(equalToConstant: 100),
            activityIndicator.widthAnchor.constraint(equalToConstant: 100),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate

extension AccountsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.accounts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = viewModel.accounts[indexPath.row]
        let cellIdentifier = cellModel.type.rawValue
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                as? CustomElementCell else { return UITableViewCell() }

        let account = viewModel.accounts[indexPath.row]

        if let accountCell = cell as? AccountCell {
            accountCell.favoriteSubject
                .receive(on: DispatchQueue.main)
                .sink { [weak self] accountCell in
                    guard let self = self, let indexPath = tableView.indexPath(for: accountCell) else { return }
                    self.viewModel.updateFavoriteToCoreData(indexPath: indexPath)
                }
                .store(in: &accountCell.cancellables)
        }

        cell.configure(with: account)

        return cell as! UITableViewCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let account = viewModel.accounts[indexPath.row]
        navigateToDetails(with: account)
    }
}


