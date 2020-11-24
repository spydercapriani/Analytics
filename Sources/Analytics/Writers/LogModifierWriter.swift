//
//  LogModifierWriter.swift
//  
//
//  Created by Danny Gilbert on 11/24/20.
//

import Foundation

public protocol LogModifierWriter: LogWriter {

    var modifiers: [LogEventModifier] { get }
}

extension LogModifierWriter {

    public func modify(_ event: LogEvent, level: LogLevel) -> LogEvent {
        modifiers.reduce(event) {
            return $1.modify($0, level: level)
        }
    }
}
