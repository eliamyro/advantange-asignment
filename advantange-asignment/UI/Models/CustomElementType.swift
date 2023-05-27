//
//  CustomElementType.swift
//  advantange-asignment
//
//  Created by Elias Myronidis on 27/5/23.
//

import Foundation

protocol CustomElementModel: AnyObject {
    var type: CustomElementType { get }
}

protocol CustomElementCell: AnyObject {
    func configure(with elementModel: CustomElementModel)
}

enum CustomElementType: String {
    case account
    case details
    case transaction
}
