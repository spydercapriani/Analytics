//
//  LogName.swift
//  
//
//  Created by Danny Gilbert on 11/21/20.
//

import Foundation

public struct LogName {

    public let description: String

    public init(_ attribute: String) {
        self.description = attribute
    }
}

extension LogName: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {

    public init(stringLiteral value: String) {
        self.description = value
    }

    public init(stringInterpolation: DefaultStringInterpolation) {
        self.description = stringInterpolation.description
    }
}

extension LogName: CustomStringConvertible { }
extension LogName: Equatable { }
extension LogName: Hashable { }
