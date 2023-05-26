//
//  DInjection.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Foundation

class DIInitializer {
    static func setup() {
        DInjection.shared = DInjection()
    }
}

class DInjection: DependencyContainer {
    static var shared = DependencyContainer()

    init(empty: Bool = false) {
        super.init()

        if !empty { registerDependencies() }
    }

    func registerDependencies() {
        registerSources()
        registerRepositories()
        registerUseCases()
    }

    private func registerSources() {
        register(HTTPClient.self) { HTTPClientImp() }
    }

    private func registerRepositories() {
        register(AccountsRepo.self) { AccountsRepoImp() }
    }

    private func registerUseCases() {
        register(FetchAccountsUC.self) { FetchAccountsUCImp() }
    }
}
