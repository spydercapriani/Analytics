//
//  AnalyticsDomain.swift
//  
//
//  Created by Danny Gilbert on 11/21/20.
//

import Foundation

public struct AnalyticsDomain: RawRepresentable {

    public var rawValue: String

    public init?(rawValue: String) {
        self.rawValue = rawValue
    }
}

// MARK: - String Literal
extension AnalyticsDomain: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self.rawValue = value
    }
}

// MARK: - CustomStringConvertible
extension AnalyticsDomain: CustomStringConvertible {

    public var description: String { rawValue }
}
