//
//  LogWriter.swift
//  
//
//  Created by Danny Gilbert on 11/22/20.
//

import Foundation

public protocol LogWriter: class {

    func report(_ event: LogEvent, level: LogLevel)
    func set(_ attribute: GlobalAttribute, withValue value: Any?)
    func error(_ error: Error)
}
