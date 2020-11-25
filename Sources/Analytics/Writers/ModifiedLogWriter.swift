//
//  ModifiedLogWriter.swift
//  
//
//  Created by Danny Gilbert on 11/24/20.
//

import Foundation

public protocol ModifiedLogWriter: LogWriter {

    var modifiers: [LogModifier] { get }
}

extension ModifiedLogWriter {

    public func modify(_ event: LogEvent, level: LogLevel) -> LogEvent {
        modifiers.reduce(event) {
            return $1.modify($0, level: level)
        }
    }
}
