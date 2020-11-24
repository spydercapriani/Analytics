//
//  LogEvent.swift
//  
//
//  Created by Danny Gilbert on 11/22/20.
//

import Foundation

public struct LogEvent {

    public var domain: LogDomain
    public var name: LogName
    public var attributes: [LogAttribute: Any]?
}

// MARK: - Initializer
extension LogEvent {

    public init(
        name: LogName,
        attributes: [LogAttribute: Any]? = nil,
        domain: LogDomain = .default
    ) {
        self.domain = domain
        self.name = name
        self.attributes = attributes
    }
}
