//
//  AnalyticsEvent.swift
//  
//
//  Created by Danny Gilbert on 11/21/20.
//

import Foundation

public struct AnalyticsEvent {

    public var domain: AnalyticsDomain
    public var name: AnalyticsEventName
    public var attributes: [AnalyticsAttribute: Any]?
    public var logType: AnalyticsLogType
}

// MARK: - Initializer
extension AnalyticsEvent {

    public init(
        domain: AnalyticsDomain,
        eventName: AnalyticsEventName,
        attributes: [AnalyticsAttribute: Any]?,
        logType: AnalyticsLogType
    ) {
        self.domain = domain
        self.name = eventName
        self.attributes = attributes
        self.logType = logType
    }
}

// MARK: - Mapping
extension AnalyticsEvent {

    public func map(using mapper: AnalyticsEventMapper) -> AnalyticsEvent {
        AnalyticsEvent(
            domain: mapper.domain(for: self),
            name: mapper.eventName(for: self),
            attributes: mapper.attributes(for: self),
            logType: logType
        )
    }
}
