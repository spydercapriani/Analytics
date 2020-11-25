import XCTest
@testable import Analytics

final class AnalyticsTests: XCTestCase {

    func testExample() {
        let writer = ConsoleWriter()
        writer.set("Default", withValue: "Hello World")
        writer.set("Default", withValue: nil)
        writer.error(TestError.testing)
        let event = LogEvent(
            domain: "Default",
            name: "Test Event",
            attributes: [
                "Hello": "World",
                "Testing": 123,
                "isIt": true
            ]
        )
        writer.report(event, level: .warning)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
