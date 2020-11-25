//
//  TestError.swift
//  
//
//  Created by Danny Gilbert on 11/25/20.
//

import Foundation

enum TestError: LocalizedError {
    case testing
}

// MARK: - Localized Error
extension TestError {

    var errorDescription: String? {
        "Test Error"
    }

    var recoverySuggestion: String? {
        "Clear the cache"
    }

    var failureReason: String? {
        "Failed Manually"
    }

    var helpAnchor: String? {
        "Help Needed"
    }
}
