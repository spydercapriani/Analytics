//
//  LogModifierWriter.swift
//  
//
//  Created by Danny Gilbert on 11/24/20.
//

import Foundation

open class LogModifierWriter {

    var modifiers: [LogModifier]

    public init(
        modifiers: [LogModifier]
    ) {
        self.modifiers = modifiers
    }
}

// MARK: - Writer Actions
extension LogModifierWriter: LogWriter {

    open func report(_ event: LogEvent, level: LogLevel) {
        // Implemented in child class.
    }

    open func set(_ attribute: GlobalAttribute, withValue value: Any?) {
        // Implemented in child class.
    }

    open func error(_ error: Error) {
        // Implemented in child class.
    }
}

extension LogModifierWriter {

    open func modify(_ event: LogEvent, level: LogLevel) -> LogEvent {
        modifiers.reduce(event) {
            return $1.modify($0, level: level)
        }
    }
}
