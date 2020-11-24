//
//  LogEventName.swift
//  
//
//  Created by Danny Gilbert on 11/21/20.
//

import Foundation

public struct LogEventName {

    public let description: String

    public init(_ attribute: String) {
        self.description = attribute
    }
}

// MARK: - String Literal
extension LogEventName: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self.description = value
    }
}

// MARK: - CustomStringConvertible
extension LogEventName: CustomStringConvertible { }

// MARK: - Equatable
extension LogEventName: Equatable { }

// MARK: - Hashable
extension LogEventName: Hashable { }
