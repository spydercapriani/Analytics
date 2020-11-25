import XCTest
@testable import Analytics

final class AnalyticsTests: XCTestCase {

    func testExample() {
        Log.set("Default", withValue: "Hello World")
        Log.set("Default", withValue: nil)
        Log.error(TestError.testing)
        let event = LogEvent(
            domain: "Default",
            name: "Test Event",
            attributes: [
                "Hello": "World",
                "Testing": 123,
                "isIt": true
            ]
        )
        Log.report(event, level: .warning)
        Log.logEventStarted(event.name)
        Log.logEventFinished(event, level: .verbose)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
