# Analytics

Analytics is a powerful, yet lightweight logging library written in Swift.

- [Features](#features)
- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
- [Usage](#usage)
    - [Creating a Logger](#creating-a-logger)
    - [Synchronous and Asynchronous Logging](#synchronous-and-asynchronous-logging)
    - [Log Modifiers](#log-modifiers)
    - [Log Writers](#log-writers)
- [Creators](#creators)

## Features

- [X] Default Log Levels
- [X] Configurable Synchronous or Asynchronous Execution
- [X] Thread-Safe Logging Output (No Log Mangling)
- [X] Custom Writers through Dependency Injection
- [X] Custom Modifiers through Dependency Injection per Writer
- [X] Supports Multiple Simultaneous Writers

## Requirements

- iOS 12.0+
- Xcode 12+
- Swift 5.0+

## Communication

- Need help? 
- Have a feature request? 
- Found a bug? 
- Want to contribute?

Slack `dev-mobile` channel or Submit a PR.

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding Analytics as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/spydercapriani/Analytics.git", majorVersion: "1.0.0")
]
```

---

## Usage

### Creating a Logger

```swift
import Analytics

let defaultLogger = Logger(writers: [ConsoleWriter()])
```

The `Logger` initializer takes four parameters to customize the behavior of the logger instance.

- `logLevels: [LogLevel]` - The log message levels that should be processed.
Events that don't match the current log level are not processed.

- `logFilters: [LogEventFilter]` - Filters for specifying which events should be processed.
Events that don't pass the filters are not processed.

- `writers: [LogWriter]` - The array of writers to write to.
Writers can be used to log output to a specific destination such as the console, a file, or an external service like New Relic / Firebase.

- `executionMethod: ExecutionMethod = .synchronous(lock: NSRecursiveLock())` - The execution method used when writing messages.

`Logger` objects can only be customized during initialization.
If you need to change a `Logger` at runtime, it is advised to create an additional logger with a custom configuration to fit your needs.
It is perfectly acceptable to have many different `Logger` instances running simultaneously.

#### Log Events

Events are structured data with a domain, name, and an optional dictionary of attributes.
- `Domain` should generally describe the category or area to which the event pertains. If none provided, it is automatically assigned `Default` domain.
-  `Name` should be something which best describes the event itself. It can also just be a message you wish to log.
- `Attributes` should include any specific details which might pertain to the event itself. (Optional)

`LogEvent`'s are a good choice if you want to provide context information along with the log text (e.g. routing log information to an external system like New Relic).


### Synchronous and Asynchronous Logging

Logging can greatly affect the runtime performance of your application or library.
Analytics makes it very easy to log messages synchronously or asynchronously.
You can define this behavior when creating the `LoggerConfiguration` for your `Logger` instance.

```swift
let queue = DispatchQueue(label: "serial.queue", qos: .utility)
let log = Logger(writers: [ConsoleWriter()], executionMethod: .asynchronous(queue: queue))
```

#### Synchronous Logging

Synchronous logging is very helpful when you are developing your application or library.
The log operation will be completed before executing the next line of code.
This can be very useful when stepping through the debugger.
The downside is that this can seriously affect performance if logging on the main thread.

#### Asynchronous Logging

Asynchronous logging should be used for deployment builds of your application or library.
This will offload the logging operations to a separate dispatch queue that will not affect the performance of the main thread.
This allows you to still capture logs in the manner that the `Logger` is configured, yet not affect the performance of the main thread operations.

> These are large generalizations about the typical use cases for one approach versus the other.
> Before making a final decision about which approach to use when, you should really break down your use case in detail.

### Log Writers

Writing log messages to various locations is an essential feature of any robust logging library.
This is made possible in `Analytics` through the `LogWriter` protocol.

```swift
public protocol LogWriter: class {

    func report(_ event: LogEvent, level: LogLevel)
    func set(_ attribute: GlobalAttribute, withValue value: Any?)
    func error(_ error: Error)
}
```

Again, this is an extremely lightweight design to allow for ultimate flexibility.
As long as your `LogWriter` classes conform, you can do anything with those log messages that you want.
You could write the message to the console, append it to a file, send it to a server, etc.
Here's a quick look at a simple write that writes to the console.

```swift
class PrintWriter: LogWriter {
    
    func report(_ event: LogEvent, level: LogLevel) {
        print("\(level) - \(event)"
    }
    
    func set(_ attribute: GlobalAttribute, withValue value: Any?) {
        print("Global Attribute set: \(attribute) = \(value)")
    }
    
    func error(_ error: Error) {
        print(error)
    }
}
```

### Log Modifiers

Log message customization is something that `Analytics` specializes in.
Some devs want to add a prefix to their library output, some want different timestamp formats, some even want an emoji!
Sometimes it may even be necessary to clean up your event before sending it off to an external service.
There's no way to predict all the types of custom formatting we are going to want to use.
This is where `LogModifier` objects come in.

```swift
public protocol LogModifier {

    func modify(_ event: LogEvent, level: LogLevel) -> LogEvent
}
```

The `LogModifier` protocol has only a single API.
It receives the `event` and `logLevel` and returns a newly formatted `LogEvent`.
This is about as flexible as you can get.

As an added layer of convenience, writers intending to output strings (e.g. writing to the console, files, etc.) can conform to the `ModifiedLogWriter` protocol.
The `ModifiedLogWriter` protocol adds an array of `LogModifier` objects to the `LogWriter` that can be applied to the message before it is output using the `modify(_:logLevel)` API in the extension.

Let's walk through a simple example for changing domain to store log level details.

```swift
struct DomainLevelModifier: LogModifier {

    func modify(_ event: LogEvent, level: LogLevel) -> LogEvent {
        LogEvent(
            domain: "\(level)",
            name: event.name,
            attributes: event.attributes
        )
    }
}

let modifiers = [DomainLevelModifier()]
let writers = [ConsoleWriter(modifiers: modifiers)]
let log = Logger(writers: writers)
```

#### Multiple Modifiers

Multiple `LogModifier` objects can be stacked together onto a single log level to perform multiple actions.
`Analytics` doesn't have any hard limits on the total number of `LogModifier` objects that can be applied to a single log level.
Just keep in mind that performance is key.

> NOTE: The `Writer` will execute the modifiers in the same order they were added into the `Array`.

#### Multiple Writers

So what about logging to both a file and the console at the same time? No problem.
You can pass multiple `LogWriter` objects into the `Logger` initializer.
The `Logger` will execute each `LogWriter` in the order it was passed in.

> `LogWriter` objects can also be selective about which modifiers they want to run for a particular log level.

---

## Creators

- [Danny Gilbert](https://github.com/spydercapriani)

Special shoutout to the creators of [Willow](https://github.com/Nike-Inc/Willow) for much of the inspiration behind this package.
