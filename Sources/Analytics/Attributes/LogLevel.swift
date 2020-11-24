//
//  LogType.swift
//  
//
//  Created by Danny Gilbert on 11/22/20.
//

import Foundation

public struct LogLevel: OptionSet, Equatable, Hashable {

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

// MARK: - Default Log Levels
extension LogLevel {
    private static let offBitmask: RawValue = 0b00000000_00000000_00000000_00000000
    private static let allBitmask: RawValue = 0b11111111_11111111_11111111_11111111
    public static let off = LogLevel(rawValue: offBitmask)
    public static let all = LogLevel(rawValue: allBitmask)

    public static let verbose = LogLevel(rawValue: 1 << 0, description: "VERBOSE")
    public static let debug = LogLevel(rawValue: 1 << 1, description: "DEBUG")
    public static let info = LogLevel(rawValue: 1 << 2, description: "INFO")
    public static let warning = LogLevel(rawValue: 1 << 3, description: "WARNING")
    public static let error = LogLevel(rawValue: 1 << 4, description: "ERROR")
}

// MARK: - CustomStringConvertible
extension LogLevel: CustomStringConvertible {

    public var description: String {
        Self.descriptions[self.rawValue] ?? "Unknown"
    }
}
