//
//  AccountsEndpoint.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Foundation

enum AccountsEndpoint {
    case accounts
    case accountDetails(accountId: String)
    case transactions(accountId: String, page: Int, fromDate: String?, toDate: String?)
}

extension AccountsEndpoint: Endpoint {
    var host: String {
        "ktor-env.eba-asssfhm8.eu-west-1.elasticbeanstalk.com"
    }

    var path: String {
        switch self {
        case .accounts:
            return "/accounts"
        case .accountDetails(let accountId):
            return "/account/details/\(accountId)"
        case .transactions(let accountId, _, _, _):
            return "/account/transactions/\(accountId)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .accounts, .accountDetails:
            return .get
        case .transactions:
            return .post
        }
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }

    var body: [String : Any]? {
        switch self {
        case .accounts, .accountDetails:
            return nil
        case .transactions(_, let page, let fromDate, let toDate):
            var dic = [String: Any]()
            dic["next_page"] = page
            if let fromDate = fromDate, let toDate = toDate {
                dic["from_date"] = fromDate
                dic["to_date"] = toDate
            }

            print(dic)
            return dic
        }
    }
}
