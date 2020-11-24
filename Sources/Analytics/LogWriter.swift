//
//  LogWriter.swift
//  
//
//  Created by Danny Gilbert on 11/22/20.
//

import Foundation

public protocol LogWriter {

    func report(_ event: LogEvent, level: LogLevel)
    func set(_ attribute: GlobalAttribute, withValue value: Any?)
    func recordError(_ error: Error)
}

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
