//
//  GlobalAttribute.swift
//  
//
//  Created by Danny Gilbert on 11/22/20.
//

import Foundation

public struct GlobalAttribute: OptionSet {

    public let rawValue: UInt
    static var descriptions: [UInt: String] = [:]

    public init(rawValue: UInt) {
        assert(false, "Please provide description!")
        self.rawValue = rawValue
    }
    
    public init(rawValue: UInt, description: String) {
        self.rawValue = rawValue
        Self.descriptions[rawValue] = description
    }
}

extension GlobalAttribute: Equatable { }
extension GlobalAttribute: Hashable { }

// MARK: - Description
extension GlobalAttribute: CustomStringConvertible {

    public var description: String {
        Self.descriptions[rawValue]!
    }
}
