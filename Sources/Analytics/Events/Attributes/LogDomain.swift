//
//  LogDomain.swift
//  
//
//  Created by Danny Gilbert on 11/22/20.
//

import Foundation

public struct LogDomain: OptionSet {

    public let rawValue: UInt
    static var descriptions: [UInt: String] = [:]

    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }

    public init(rawValue: UInt, description: String) {
        self.rawValue = rawValue
        Self.descriptions[rawValue] = description
    }
}

// MARK: - Domains
extension LogDomain {

    public static let `default` = LogDomain(rawValue: 0 << 0)
}

extension LogDomain: Equatable { }
extension LogDomain: Hashable { }

// MARK: - Description
extension LogDomain: CustomStringConvertible {
    public var description: String {
        Self.descriptions[rawValue] ?? "Unknown"
    }
}
