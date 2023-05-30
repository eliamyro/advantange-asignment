//
//  CoreDataManager.swift
//  advantange-asignment
//
//  Created by Ilias Myronidis on 30/5/23.
//

import Combine
import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AdvantageDataModel")
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Loading of store failed: \(error.localizedDescription)")
            }
        }

        return container
    }()
}

extension CoreDataManager {
    func saveFavoriteAccount(account: AccountModel) -> AnyPublisher<Bool, Never> {
        let context = persistentContainer.viewContext
        let favoriteAccount = CDAccount(context: context)
        favoriteAccount.id = account.id ?? ""
        favoriteAccount.accountNumber = Int32(account.accountNumber ?? 0)
        favoriteAccount.balance = account.balance ?? ""
        favoriteAccount.currencyCode = account.currencyCode ?? ""
        favoriteAccount.accountType = account.accountType ?? ""
        favoriteAccount.accountNickname = account.accountNickname ?? ""

        if context.hasChanges {
            do {
                try context.save()
                return Just(true).eraseToAnyPublisher()
            } catch {
                print(error)
                return Just(false).eraseToAnyPublisher()
            }
        }

        return Just(false).eraseToAnyPublisher()
    }

    func deleteFavoriteAccount(id: String) -> AnyPublisher<Bool, Never> {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CDAccount> = CDAccount.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)

        do {
            let result = try context.fetch(fetchRequest)
            for object in result {
                context.delete(object)
            }

            if context.hasChanges {
                do {
                    try context.save()
                    return Just(true).eraseToAnyPublisher()
                } catch {
                    print(error)
                    return Just(false).eraseToAnyPublisher()
                }
            }

            return Just(false).eraseToAnyPublisher()
        } catch {
            print(error)
            return Just(false).eraseToAnyPublisher()
        }
    }
}
