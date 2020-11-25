//
//  EmojiLogModifier.swift
//  
//
//  Created by Danny Gilbert on 11/24/20.
//

import Foundation

public struct EmojiLogModifier {
    public init() { }
}

extension EmojiLogModifier: LogModifier {

    public func modify(_ event: LogEvent, level: LogLevel) -> LogEvent {
        return LogEvent(
            domain: event.domain,
            name: "\(level.emoji) \(event.name)",
            attributes: event.attributes
        )
    }
}

// MARK: - Emojis
internal extension LogLevel {

    var emoji: Character {
        switch self {
        case .debug:
            return "◾️"
        case .info:
            return "🔷"
        case .warning:
            return "🔶"
        case .error:
            return "❌"

        default:
            return "◽️"
        }
    }
}
