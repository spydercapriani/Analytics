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

extension LogAttribute: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {

    public init(stringLiteral value: String) {
        self.description = value
    }
}

extension LogAttribute: CustomStringConvertible { }
extension LogAttribute: Equatable { }
extension LogAttribute: Hashable { }

// MARK: - Defaults
extension LogAttribute {

    public static var emoji: LogAttribute = "emoji"
}
