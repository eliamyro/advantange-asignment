//
//  AccountsEndpoint.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Foundation

enum AccountsEndpoint {
    case accounts
}

extension AccountsEndpoint: Endpoint {
    var host: String {
        "ktor-env.eba-asssfhm8.eu-west-1.elasticbeanstalk.com"
    }

    var path: String {
        switch self {
        case .accounts:
            return "/accounts"
        }
    }

    var method: RequestMethod {
        switch self {
        case .accounts:
            return .get
        }
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }
}
