//
//  AnalyticsProvider.swift
//  
//
//  Created by Danny Gilbert on 11/21/20.
//

import Foundation

public var Log = AnalyticsProvider(
    [
        OSLogger()
    ]
)

public final class AnalyticsProvider {

    public var loggers: [LogProvider]

    private var startTimeByEvent = [AnalyticsEventName: TimeInterval]()

    init(_ loggers: [LogProvider]) {
        self.loggers = loggers
    }
}

// MARK: - Logger Actions
extension AnalyticsProvider {

    public func report(_ event: AnalyticsEvent) {
        loggers.forEach { $0.report(event) }
    }

    public func setGlobal(_ attribute: AnalyticsAttribute, withValue value: Any?) {
        loggers.forEach { $0.setGlobal(attribute, withValue: value) }
    }

    public func message(_ value: String, type: AnalyticsLogType) {
        loggers.forEach { $0.message(value, type: type) }
    }

    public func error(_ error: Error?) {
        guard let error = error else { return }
        loggers.forEach { $0.error(error) }
    }

    public func eventStarted(_ eventName: AnalyticsEventName) {
        startTimeByEvent[eventName] = CFAbsoluteTimeGetCurrent()
    }

    public func eventFinished(_ event: AnalyticsEvent) {
        guard let startTime = startTimeByEvent.removeValue(forKey: event.name) else { return }
        let duration = CFAbsoluteTimeGetCurrent() - startTime
        loggers.forEach { $0.eventFinished(event, duration: duration) }
    }
}
