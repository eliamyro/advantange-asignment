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
    var body: [String: Any]? { get }
}

extension Endpoint {
    var scheme: String {
        "http"
    }

    var header: [String: String]? {
        return ["Content-Type": "application/json; charset=UTF-8",
                "Connection": "keep-alivee",
                "Authorization": "Basic \(Authorization.authorization())"]
    }
}
