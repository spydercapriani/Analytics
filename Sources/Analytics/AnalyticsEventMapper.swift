//
//  AnalyticsEventMapper.swift
//  
//
//  Created by Danny Gilbert on 11/21/20.
//

import Foundation

public protocol AnalyticsEventMapper {

    func domain(for event: AnalyticsEvent) -> AnalyticsDomain
    func eventName(for event: AnalyticsEvent) -> AnalyticsEventName
    func attributes(for event: AnalyticsEvent) -> [AnalyticsAttribute: Any]?
}
