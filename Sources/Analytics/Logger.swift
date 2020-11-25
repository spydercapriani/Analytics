//
//  Logger.swift
//  
//
//  Created by Danny Gilbert on 11/24/20.
//

import Foundation

public var Log = Logger(
    writers: [
        ConsoleWriter()
    ]
)

public typealias LogEventFilter = (LogEvent) -> Bool
open class Logger {

    public let logLevels: [LogLevel]
    public let logFilters: [LogEventFilter]
    public let writers: [LogWriter]
    public let executionMethod: ExecutionMethod

    private var startTimeByEvent = [LogName: TimeInterval]()

    public init(
        logLevels: [LogLevel] = LogLevel.allCases,
        logFilters: [LogEventFilter] = [],
        writers: [LogWriter],
        executionMethod: ExecutionMethod = .synchronous(lock: NSRecursiveLock())
    ) {
        self.logLevels = logLevels
        self.logFilters = logFilters
        self.writers = writers
        self.executionMethod = executionMethod
    }
}

// MARK: - Logger Actions
extension Logger {

    open func set(_ attribute: GlobalAttribute, withValue value: Any?) {
        self.execute {
            self.writers.forEach { $0.set(attribute, withValue: value) }
        }
    }

    open func report(_ event: LogEvent, level: LogLevel) {
        guard isAllowed(event, level: level) else { return }
        self.execute {
            self.writers.forEach { $0.report(event, level: level) }
        }
    }

    open func error(_ error: Error?) {
        guard let error = error else { return }
        self.execute {
            self.writers.forEach { $0.error(error) }
        }
    }

    open func logEventStarted(_ name: LogName) {
        startTimeByEvent[name] = CFAbsoluteTimeGetCurrent()
    }

    open func logEventFinished(_ event: LogEvent, level: LogLevel) {
        guard let startTime = startTimeByEvent.removeValue(forKey: event.name) else { return }
        let duration = CFAbsoluteTimeGetCurrent() - startTime
        var updatedEvent = event
        updatedEvent.attributes?[.duration] = NSNumber(value: duration)
        report(updatedEvent, level: level)
    }
}

// MARK: - Helper Actions
extension Logger {

    private func isAllowed(_ event: LogEvent, level: LogLevel) -> Bool {
        logFilters.reduce(logLevels.contains(level)) { $0 && $1(event) }
    }

    private func execute(_ handler: @escaping () -> ()) {
        switch executionMethod {
        case .synchronous(let lock):
            lock.lock() ; defer { lock.unlock() }
            handler()
        case .asynchronous(let queue):
            queue.async {
                handler()
            }
        }
    }
}

// MARK: - ExecutionMethod
extension Logger {

    /// Defines the two types of execution methods used when logging a message.
    ///
    /// Logging operations can be expensive operations when there are hundreds of messages being generated or when
    /// it is computationally expensive to compute the message to log. Ideally, one would use the synchronous method
    /// in development, and the asynchronous method in production. This allows for easier debugging in the development
    /// environment, and better performance in production.
    ///
    /// - synchronous:  Logs messages synchronously once the recursive lock is available in serial order.
    /// - asynchronous: Logs messages asynchronously on the dispatch queue in a serial order.
    public enum ExecutionMethod {
        case synchronous(lock: NSRecursiveLock)
        case asynchronous(queue: DispatchQueue)
    }
}
