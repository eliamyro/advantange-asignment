//
//  AccountDetailsCell.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 27/5/23.
//

import UIKit

class AccountDetailsCell: UITableViewCell, CustomElementCell {

    // MARK: Views

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var openedDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var branchLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var beneficiariesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
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
        guard let model = elementModel as? AccountDetailsModel else {
            print("Unable to cast model as AccountDetailsModel")
            return
        }

        configureViews()
        setup(model: model)
    }

    private func setup(model: AccountDetailsModel) {
        typeLabel.text = "Type: \(model.accountType ?? "")"
        productNameLabel.text = "Product Name: \(model.productName ?? "")"
        openedDateLabel.text = "Opened Date: \(model.openedDate ?? "")"
        branchLabel.text = "Branch: \(model.branch ?? "")"
        if let beneficiaries = model.beneficiaries {
            let benString = beneficiaries.joined(separator: ", ")
            beneficiariesLabel.text = "Beneficiaries: \(benString)"
        }
    }
}

// MARK: - Setup Constraints

extension AccountDetailsCell {
    func configureViews() {
        configureContainerView()
        configureTypeLabel()
        configureProductNameLabel()
        configureOpenedDateLabel()
        configureBranchLabel()
        configureBeneficiariesLabel()
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

    private func configureTypeLabel() {
        containerView.addSubview(typeLabel)

        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            typeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            typeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
        ])
    }

    private func configureProductNameLabel() {
        containerView.addSubview(productNameLabel)

        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 8),
            productNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            productNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
        ])
    }

    private func configureOpenedDateLabel() {
        containerView.addSubview(openedDateLabel)

        NSLayoutConstraint.activate([
            openedDateLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 8),
            openedDateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            openedDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
        ])
    }

    private func configureBranchLabel() {
        containerView.addSubview(branchLabel)

        NSLayoutConstraint.activate([
            branchLabel.topAnchor.constraint(equalTo: openedDateLabel.bottomAnchor, constant: 8),
            branchLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            branchLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
        ])
    }

    private func configureBeneficiariesLabel() {
        containerView.addSubview(beneficiariesLabel)

        NSLayoutConstraint.activate([
            beneficiariesLabel.topAnchor.constraint(equalTo: branchLabel.bottomAnchor, constant: 8),
            beneficiariesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            beneficiariesLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            beneficiariesLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
        ])
    }
}

