//
//  AccountsListViewController.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import UIKit

class AccountsListViewController: UIViewController {

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
    }

    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Accounts"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

