//
//  AnalyticsEventName.swift
//  
//
//  Created by Danny Gilbert on 11/21/20.
//

import Foundation

public struct AnalyticsEventName: RawRepresentable {

    public var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

// MARK: - String Literal
extension AnalyticsEventName: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self.rawValue = value
    }
}

// MARK: - CustomStringConvertible
extension AnalyticsEventName: CustomStringConvertible {

    public var description: String { rawValue }
}

// MARK: - Equatable
extension AnalyticsEventName: Equatable { }

// MARK: - Hashable
extension AnalyticsEventName: Hashable { }
