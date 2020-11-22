//
//  AnalyticsAttribute.swift
//  
//
//  Created by Danny Gilbert on 11/21/20.
//

import Foundation

public struct AnalyticsAttribute: RawRepresentable {

    public var rawValue: String

    public init?(rawValue: String) {
        self.rawValue = rawValue
    }
}

// MARK: - String Literal
extension AnalyticsAttribute: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self.rawValue = value
    }
}

// MARK: - CustomStringConvertible
extension AnalyticsAttribute: CustomStringConvertible {

    public var description: String { rawValue }
}

// MARK: - Hashable
extension AnalyticsAttribute: Hashable { }
