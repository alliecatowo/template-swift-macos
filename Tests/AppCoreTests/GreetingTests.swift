import XCTest

@testable import AppCore

final class GreetingTests: XCTestCase {
  func testGreetsByName() throws {
    XCTAssertEqual(try greet(" Allie "), "Hello, Allie!")
  }

  func testRejectsEmptyName() {
    XCTAssertThrowsError(try greet("  ")) { error in
      XCTAssertEqual(error as? GreetingError, .emptyName)
    }
  }
}
