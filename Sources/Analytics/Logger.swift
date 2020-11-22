//
//  Logger.swift
//  
//
//  Created by Danny Gilbert on 11/21/20.
//

import Foundation

public protocol Logger {
    func report(_ event: AnalyticsEvent)
    func setGlobal(_ attribute: AnalyticsAttribute, withValue value: Any?)
    func message(_ value: String, type: AnalyticsLogType)
    func eventFinished(_ event: AnalyticsEvent, duration: TimeInterval)
}
