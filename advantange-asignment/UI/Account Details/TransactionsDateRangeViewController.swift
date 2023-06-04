//
//  TransactionsDateRangeViewController.swift
//  advantange-asignment
//
//  Created by Ilias Myronidis on 1/6/23.
//

import Combine
import Foundation

import UIKit

class TransactionsDateRangeViewController: UIViewController {

    // MARK: - Properties

    var dateRange = PassthroughSubject<(from: String?, to: String?), Never>()
    var cancellable = Set<AnyCancellable>()
    var transactionsFromDate: String?
    var transactionToDate: String?

    // MARK: Views

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "Select date range"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var fromDatePicker: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false

        return picker
    }()

    private lazy var toDatePicker: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false

        return picker
    }()

    private lazy var pickersStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fromDatePicker, toDatePicker])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("OK", for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.4)

        configureUI()
        setPickerDates()
    }

    private func setPickerDates() {
        fromDatePicker.setDate(transactionsFromDate?.toDate() ?? Date(), animated: true)
        toDatePicker.date = transactionToDate?.toDate() ?? Date()
    }

    @objc private func dismissView() {
        handleDateRanges()
        self.dismiss(animated: true)
    }


    func handleDateRanges() {
        let selectedDate1 = fromDatePicker.date
        let selectedDate2 = toDatePicker.date

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

        let formattedDate1 = dateFormatter.string(from: selectedDate1)
        let formattedDate2 = dateFormatter.string(from: selectedDate2)

        dateRange.send((from: formattedDate1, to: formattedDate2))

        print("Selected Date 1: \(formattedDate1)")
        print("Selected Date 2: \(formattedDate2)")
    }
}

// MARK: - Setup Constraints

extension TransactionsDateRangeViewController {
    func configureUI() {
        configureContainerView()
        configureTitleLabel()
        configurePickersStackView()
        configureOKButton()
    }

    private func configureContainerView() {
        view.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 200)
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

    private func configurePickersStackView() {
        containerView.addSubview(pickersStackView)

        NSLayoutConstraint.activate([
            pickersStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            pickersStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            pickersStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureOKButton() {
        containerView.addSubview(okButton)

        NSLayoutConstraint.activate([
            okButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            okButton.topAnchor.constraint(equalTo: fromDatePicker.bottomAnchor, constant: 16),
            okButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            okButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
