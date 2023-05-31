//
//  AccountDetailsViewController.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Combine
import UIKit

class AccountDetailsViewController: UIViewController {

    // MARK: - Properties

    let viewModel: AccountDetailsVM

    // MARK: - Views

    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .systemBlue
        indicator.translatesAutoresizingMaskIntoConstraints = false

        return indicator
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

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
        configureViews()
        registerCells()

        viewModel.fetchData()
    }

    // MARK: - Private Methods

    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Account Details"
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

        viewModel.$data
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
            .store(in: &viewModel.cancellables)

        viewModel.reloadAccountSubject
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }
            .store(in: &viewModel.cancellables)
    }

    private func registerCells() {
        tableView.register(AccountCell.self, forCellReuseIdentifier: CustomElementType.account.rawValue)
        tableView.register(AccountDetailsCell.self, forCellReuseIdentifier: CustomElementType.details.rawValue)
        tableView.register(TransactionCellTableViewCell.self, forCellReuseIdentifier: CustomElementType.transaction.rawValue)
    }
}

// NARK: - UITableViewDataSource, UITableViewDelegate

extension AccountDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        } else {
            return viewModel.data[section].elements.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = viewModel.data[indexPath.section].elements[indexPath.row]
        let cellIdentifier = cellModel.type.rawValue

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomElementCell else { return UITableViewCell() }

        if let accountCell = cell as? AccountCell {
            accountCell.favoriteSubject
                .receive(on: DispatchQueue.main)
                .sink { [weak self] accountCell in
                    guard let self = self, let indexPath = tableView.indexPath(for: accountCell) else { return }
                    self.viewModel.updateFavoriteToCoreData()
                }
                .store(in: &accountCell.cancellables)
        }
        
        cell.configure(with: cellModel)

        return cell as! UITableViewCell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 || section == 1 {
            return nil
        }

        return viewModel.data[section].title
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height

        if offsetY > (contentHeight - height) {
            viewModel.fetchNextPageTransactions()
        }
    }
}

// MARK: - Setup Constraints

extension AccountDetailsViewController {
    func configureViews() {
        configureTableView()
        configureIndicatorView()
    }

    private func configureTableView() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
