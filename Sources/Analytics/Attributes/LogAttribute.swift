//
//  LogAttribute.swift
//  
//
//  Created by Danny Gilbert on 11/21/20.
//

import Foundation

public struct LogAttribute {

    public let description: String

    public init(_ attribute: String) {
        self.description = attribute
    }
}

// MARK: - String Literal
extension LogAttribute: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self.description = value
    }
}

// MARK: - CustomStringConvertible
extension LogAttribute: CustomStringConvertible { }

// MARK: - Equatable
extension LogAttribute: Equatable { }

// MARK: - Hashable
extension LogAttribute: Hashable { }
