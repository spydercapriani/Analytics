//
//  GlobalAttribute.swift
//  
//
//  Created by Danny Gilbert on 11/22/20.
//

import Foundation

public struct GlobalAttribute {

    public let description: String

    public init(_ attribute: String) {
        self.description = attribute
    }
}

extension GlobalAttribute: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {

    public init(stringLiteral value: String) {
        self.description = value
    }

    public init(stringInterpolation: DefaultStringInterpolation) {
        self.description = stringInterpolation.description
    }
}

extension GlobalAttribute: CustomStringConvertible { }
extension GlobalAttribute: Equatable { }
extension GlobalAttribute: Hashable { }
