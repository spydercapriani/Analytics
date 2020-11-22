//
//  NewRelicEventMapper.swift
//  
//
//  Created by Danny Gilbert on 11/22/20.
//

import Foundation

struct NewRelicEventMapper {

}

// MARK: - Analytics Event Mapper
extension NewRelicEventMapper: AnalyticsEventMapper {

    func domain(for event: AnalyticsEvent) -> AnalyticsDomain {
        event.logType == .error ? "AppError" : "AppLog"
    }

    func eventName(for event: AnalyticsEvent) -> AnalyticsEventName {
        event.name
    }

    func attributes(for event: AnalyticsEvent) -> [AnalyticsAttribute : Any]? {
        event.attributes?.compactMapValues { self.cleanAttribute($0) }
    }
}

// MARK: - Clean Attributes
extension NewRelicEventMapper {

    private func cleanAttribute(_ value: Any) -> Any? {
        switch value {
        case let collection as [AnyHashable]:
            guard !collection.isEmpty else { return nil }
            let description = collection.map { $0.description }
                .filter { !$0.isEmpty }
                .joined(separator: ", ")
            return cleanAttribute(description)

        case let text as String:
            guard !text.isEmpty else { return nil }
            return text

        case let bool as Bool:
            return bool.description

        default:
            return value
        }
    }
}
