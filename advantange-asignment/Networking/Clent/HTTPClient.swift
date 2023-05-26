//
//  HTTPClient.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Combine
import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseType: T.Type) -> AnyPublisher<T, RequestError>
}

class HTTPClientImp: HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseType: T.Type) -> AnyPublisher<T, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems

        guard let url = urlComponents.url else {
            print("Failed to get url from urlComponents")
            return Fail(error: RequestError.invalidURL).eraseToAnyPublisher()
        }

        print("URL: \(url)")

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .assumeHTTP()
            .responseData()
            .decoding(T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
