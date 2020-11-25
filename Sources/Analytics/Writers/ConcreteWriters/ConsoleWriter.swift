//
//  ConsoleWriter.swift
//  
//
//  Created by Danny Gilbert on 11/24/20.
//

import Foundation
import OSLog
import os.log

public final class ConsoleWriter {

    public var modifiers: [LogModifier]
    var loggers: [LogDomain: OSLog] = [:]

    public init(
        modifiers: [LogModifier] = [EmojiLogModifier(), TimestampLogModifier()]
    ) {
        self.modifiers = modifiers
    }
}

// MARK: - Writer Actions
extension ConsoleWriter: ModifiedLogWriter {

    public func report(_ event: LogEvent, level: LogLevel) {
        let log = logger(for: event)
        let modifiedEvent = modify(event, level: level)
        let logType = level.osLogType

        if modifiedEvent.domain == .globalAttribute {
            os_log("%@", log: log, type: logType, modifiedEvent.name.description)
        } else {
            var message = modifiedEvent.name.description
            if let attributes = modifiedEvent.attributes?
                .reduce("", { $0 + "\($1.key): \($1.value)\n" }) {
                message.append("\n\(attributes)")
            }
            os_log("%@", log: log, type: logType, message)
        }
    }

    public func set(_ attribute: GlobalAttribute, withValue value: Any?) {
        let message: String = {
            if let value = value {
                return "\(attribute) = \(value)"
            } else {
                return "\(attribute) = nil"
            }
        }()
        let event = LogEvent(
            domain: .globalAttribute,
            name: "\(message)",
            attributes: nil
        )
        report(event, level: .info)
    }

    public func error(_ error: Error) {
        let nsError = error as NSError

        let domain = nsError.domain
            .split(separator: ".")
            .dropFirst()
            .joined(separator: ".")
        let attributes: [LogAttribute: String] = [
            "errorDescription": error.localizedDescription,
            "errorDomain": nsError.domain,
            "errorCode": nsError.code.description,
            "reason": nsError.localizedFailureReason,
            "suggestion": nsError.localizedRecoverySuggestion,
            "help": nsError.helpAnchor
        ]
        .compactMapValues { $0 }
        let event = LogEvent(
            domain: "\(domain)",
            name: "\(domain) - \(nsError.code)",
            attributes: attributes
        )
        report(event, level: .error)
    }
}

// MARK: - Helpers
extension ConsoleWriter {

    private func logger(for event: LogEvent) -> OSLog {
        loggers[event.domain] ?? newLogger(for: event)
    }

    private func newLogger(for event: LogEvent) -> OSLog {
        let subsystem = Bundle.main.bundleIdentifier ?? "com.app.name"
        let logger = OSLog(
            subsystem: subsystem,
            category: event.domain.description
        )
        loggers[event.domain] = logger
        return logger
    }
}
