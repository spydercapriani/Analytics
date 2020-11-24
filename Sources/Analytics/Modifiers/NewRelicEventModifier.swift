//
//  NewRelicEventModifier.swift
//  
//
//  Created by Danny Gilbert on 11/22/20.
//

import Foundation

public struct NewRelicEventModifier: LogEventModifier {

    public func modify(_ event: LogEvent, level: LogLevel) -> LogEvent {
        LogEvent(
            domain: event.domain,
            name: event.name,
            attributes: event.attributes?.compactMapValues(cleanAttribute(_:))
        )
    }
}

// MARK: - Clean Attributes
extension NewRelicEventModifier {

    private func cleanAttribute(_ value: Any) -> Any? {
        switch value {
        case let collection as [AnyHashable]:
            guard !collection.isEmpty else { return nil }
            let description = collection.map { $0.description }
                .filter { !$0.isEmpty }
                .joined(separator: ", ")
            return cleanAttribute(description)

        case let text as String:
            guard !text.isEmpty else { return nil }
            return text

        case let bool as Bool:
            return bool.description

        default:
            return value
        }
    }
}
