//
//  LogDomain.swift
//  
//
//  Created by Danny Gilbert on 11/22/20.
//

import Foundation

public struct LogDomain {

    public let description: String

    public init(_ attribute: String) {
        self.description = attribute
    }
}

extension LogDomain: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {

    public init(stringLiteral value: String) {
        self.description = value
    }

    public init(stringInterpolation: DefaultStringInterpolation) {
        self.description = stringInterpolation.description
    }
}

extension LogDomain: CustomStringConvertible { }
extension LogDomain: Equatable { }
extension LogDomain: Hashable { }

// MARK: - Default Domain
extension LogDomain {

    public static var `default`: LogDomain = "Default"
    public static var globalAttribute: LogDomain = "Global Attribute"
}
