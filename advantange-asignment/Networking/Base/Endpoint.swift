//
//  Endpoint.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var header: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        "http"
    }

    var header: [String: String]? {
        return ["Accept": "application/json",
                "Authorization": "Basic QWR2YW50YWdlOm1vYmlsZUFzc2lnbm1lbnQ=",
                "username": "Advantage",
                "password": "mobileAssignment"]
    }
}
