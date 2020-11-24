//
//  LogEvent.swift
//  
//
//  Created by Danny Gilbert on 11/22/20.
//

import Foundation

public struct LogEvent {

    public var domain: LogDomain = .default
    public var name: LogEventName
    public var attributes: [LogAttribute: Any]? = nil
}
