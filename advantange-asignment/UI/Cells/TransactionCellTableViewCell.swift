//
//  TransactionCellTableViewCell.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 27/5/23.
//

import UIKit

class TransactionCellTableViewCell: UITableViewCell, CustomElementCell {

    // MARK: Views

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var transactionTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var transactionAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .right
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var transactionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
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
        guard let model = elementModel as? APITransaction else {
            print("Unable to cast model as APITransaction")
            return
        }

        configureViews()
        setup(model: model)
    }

    private func setup(model: APITransaction) {
        transactionTypeLabel.text = model.transactionType
        transactionAmountLabel.text = model.transactionAmount
        transactionDescriptionLabel.text = model.transactionDescription ?? "There is no description"
    }
}

// MARK: - Setup Constraints

extension TransactionCellTableViewCell {
    func configureViews() {
        configureContainerView()
        configureTransactionTypeLabel()
        configureTransactionAmountLabel()
        configureTransactionDescriptionLabel()
    }

    private func configureContainerView() {
        contentView.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    private func configureTransactionTypeLabel() {
        containerView.addSubview(transactionTypeLabel)

        NSLayoutConstraint.activate([
            transactionTypeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            transactionTypeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8)
        ])
    }

    private func configureTransactionAmountLabel() {
        containerView.addSubview(transactionAmountLabel)

        NSLayoutConstraint.activate([
            transactionAmountLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            transactionAmountLabel.leadingAnchor.constraint(equalTo: transactionTypeLabel.trailingAnchor, constant: 8),
            transactionAmountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
        ])
    }

    private func configureTransactionDescriptionLabel() {
        containerView.addSubview(transactionDescriptionLabel)

        NSLayoutConstraint.activate([
            transactionDescriptionLabel.topAnchor.constraint(equalTo: transactionTypeLabel.bottomAnchor, constant: 8),
            transactionDescriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            transactionDescriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            transactionDescriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
        ])
    }

}
