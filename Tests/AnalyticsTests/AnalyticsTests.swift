import XCTest
@testable import Analytics

final class AnalyticsTests: XCTestCase {

    func testExample() {
//        Log.message("Hello World!", type: .info)
//        let event = AnalyticsEvent(
//            domain: "Default",
//            name: "Test Event",
//            attributes: [
//                "Hello": "World",
//                "Testing": 123,
//                "isIt": true
//            ]
//        )
//        Log.report(event, type: .warning)
//        Log.setGlobal("Attribute", withValue: "Hello World!")
//        Log.setGlobal("Attribute", withValue: nil)
//        Log.eventStarted("Test Event")
//        Log.eventFinished(event)
//        Log.error(TestError.testing)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

enum TestError: Error {
    case testing
}
