//
//  TimestampLogModifier.swift
//  
//
//  Created by Danny Gilbert on 11/25/20.
//

import Foundation

public struct TimestampLogModifier {

    let formatter: DateFormatter

    public init(
        formatter: DateFormatter? = nil
    ) {
        let defaultFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
            return formatter
        }()
        self.formatter = formatter ?? defaultFormatter
    }
}

// MARK: - Log Modifications
extension TimestampLogModifier: LogModifier {

    public func modify(_ event: LogEvent, level: LogLevel) -> LogEvent {
        var updatedAttributes = event.attributes
        updatedAttributes?["timestamp"] = formatter.string(from: Date())
        return LogEvent(
            domain: event.domain,
            name: event.name,
            attributes: updatedAttributes
        )
    }
}
