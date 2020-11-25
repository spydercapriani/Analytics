//
//  LogLevelReporter.swift
//  
//
//  Created by Danny Gilbert on 11/25/20.
//

import Foundation

public struct LogLevelReporter {
    public init() { }
}

// MARK: - Log Modifier
extension LogLevelReporter: LogModifier {

    public func modify(_ event: LogEvent, level: LogLevel) -> LogEvent {
        var updatedAttributes = event.attributes
        updatedAttributes?["logLevel"] = level.rawValue
        return LogEvent(
            domain: event.domain,
            name: event.name,
            attributes: updatedAttributes
        )
    }
}
