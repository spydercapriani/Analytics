//
//  LogModifier.swift
//  
//
//  Created by Danny Gilbert on 11/22/20.
//

import Foundation

public protocol LogModifier {

    func modify(_ event: LogEvent, level: LogLevel) -> LogEvent
}
