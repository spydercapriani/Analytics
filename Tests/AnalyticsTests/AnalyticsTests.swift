import XCTest
@testable import Analytics

final class AnalyticsTests: XCTestCase {
    func testExample() {
        Log.message("Hello World!", type: .info)
        let event = AnalyticsEvent(
            domain: "Default",
            eventName: "Test Event",
            attributes: [
                "Hello": "World",
                "Testing": 123,
                "isIt": true
            ],
            logType: .warning
        )
        Log.report(event)
        Log.setGlobal("Attribute", withValue: "Hello World!")
        Log.eventStarted("Test Event")
        Log.eventFinished(event)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
