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
        name: AnalyticsEventName,
        attributes: [AnalyticsAttribute: Any]? = nil,
        type: AnalyticsLogType
    ) {
        self.domain = domain
        self.name = name
        self.attributes = attributes
        self.logType = type
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

// MARK: - Identifiable
extension AnalyticsEvent: Identifiable {

    public var id: AnalyticsEventName {
        name
    }
}

// MARK: - Equatable
extension AnalyticsEvent: Equatable {

    public static func == (lhs: AnalyticsEvent, rhs: AnalyticsEvent) -> Bool {
        func compareAttributes(lhs: [AnalyticsAttribute: Any]?, rhs: [AnalyticsAttribute: Any]?) -> Bool {
            let lhsKeys = lhs?.keys
            let rhsKeys = rhs?.keys
            let lhsValues = lhs?.values.map { "\($0)" }
            let rhsValues = rhs?.values.map { "\($0)" }
            return lhsKeys == rhsKeys &&
                lhsValues == rhsValues
        }

        return lhs.domain == rhs.domain &&
            lhs.name == rhs.name &&
            compareAttributes(lhs: lhs.attributes, rhs: rhs.attributes) &&
            lhs.logType == rhs.logType
    }
}
