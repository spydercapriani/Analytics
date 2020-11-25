//
//  LogType.swift
//  
//
//  Created by Danny Gilbert on 11/22/20.
//

import Foundation
import OSLog

public enum LogLevel: String, CaseIterable {
    case verbose
    case debug
    case info
    case warning
    case error
}

// MARK: - OSLogType
internal extension LogLevel {

    var osLogType: OSLogType {
        switch self {
        case .debug:
            return .debug
        case .info:
            return .info
        case .warning:
            return .fault
        case .error:
            return .error

        default:
            return .default
        }
    }
}
