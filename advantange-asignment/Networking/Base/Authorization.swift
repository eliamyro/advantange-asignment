//
//  Authorization.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 26/5/23.
//

import Foundation

struct Authorization {
    static func authorization() -> String {
        let username = "Advantage"
        let password = "mobileAssignment"
        let loginString = "\(username):\(password)"

        guard let loginData = loginString.data(using: .utf8) else {
            return ""
        }

        let base64LoginString = loginData.base64EncodedString()
        return base64LoginString
    }
}
