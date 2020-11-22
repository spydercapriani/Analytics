//
//  OSLogger.swift
//  
//
//  Created by Danny Gilbert on 11/21/20.
//

import Foundation
import os.log

public struct OSLogger {

}

extension OSLogger: LogProvider {

    public func report(_ event: AnalyticsEvent) {
        var value = "\(event.domain) Event at \(Date())\n"
        value.append("----------------------\(event.name)-----------------------\n")
        if let attributes = event.attributes?
            .reduce("", { $0 + "\($1.key): \($1.value)\n" }) {
            value.append(attributes)
        }
        message(value, type: event.logType)
    }

    public func setGlobal(_ attribute: AnalyticsAttribute, withValue value: Any?) {
        if let value = value {
            message("Global Attribute set: \(attribute) = \(String(describing: value))", type: .info)
        } else {
            message("Global Attribute removed: \(attribute)", type: .info)
        }
    }

    public func error(_ error: Error) {
        let nsError = error as NSError

        let attributes: [AnalyticsAttribute: String] = [
            "description": nsError.localizedDescription,
            "reason": nsError.localizedFailureReason,
            "suggestion": nsError.localizedRecoverySuggestion
        ]
        .compactMapValues { $0 }

        let event = AnalyticsEvent(
            domain: AnalyticsDomain(rawValue: nsError.domain),
            name: "Error",
            attributes: attributes,
            logType: .error
        )
        report(event)
    }

    public func message(_ value: String, type: AnalyticsLogType) {
        os_log(type.osLogType, "%@", value)
    }

    public func eventFinished(_ event: AnalyticsEvent, duration: TimeInterval) {
        var updatedEvent = event
        updatedEvent.name = AnalyticsEventName(rawValue: "\(event.name)(\(duration))")
        report(updatedEvent)
    }
}

internal extension AnalyticsLogType {

    var osLogType: OSLogType {
        switch self {
        case .debug:    return .debug
        case .info:     return .info
        case .warning:  return .fault
        case .error:    return .error

        default: return .default
        }
    }
}
