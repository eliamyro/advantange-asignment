//
//  AccountCell.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import UIKit

class AccountCell: UITableViewCell, CustomElementCell {

    // MARK: Views

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with elementModel: CustomElementModel) {
        guard let model = elementModel as? AccountModel else {
            print("Unable to cast model as AccountModel")
            return
        }

        configureViews()
        setup(model: model)
    }

    func setup(model: AccountModel) {
        titleLabel.text = model.accountNickname ?? "\(model.accountNumber ?? 0)"
        balanceLabel.text = "\(model.balance ?? "-") \(model.currencyCode ?? "")"
    }
}

// MARK: - Setup Constraints

extension AccountCell {
    func configureViews() {
        configureContainerView()
        configureTitleLabel()
        configureBalanceLabel()
    }

    private func configureContainerView() {
        contentView.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    private func configureTitleLabel() {
        containerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
        ])
    }

    private func configureBalanceLabel() {
        containerView.addSubview(balanceLabel)

        NSLayoutConstraint.activate([
            balanceLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            balanceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            balanceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
    }
}
