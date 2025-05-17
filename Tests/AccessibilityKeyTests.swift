import XCTest
import Rafinad

@MainActor
final class AccessibilityKeyTests: XCTestCase {

    func testThatIdentifierIsCorrect() {
        let foo = AccessibilityKey
            .keyPath(\TestAccessibility.foo)
            .identifier

        let bar = AccessibilityKey
            .keyPath(\TestAccessibility.bar)
            .identifier

        XCTAssertEqual(foo, "TestAccessibility.foo")
        XCTAssertEqual(bar, "TestAccessibility.bar")
    }

    func testThatIdentifierIsCorrectForNestedAccessibility() {
        let foo = AccessibilityKey
            .keyPath(\TestAccessibilityWithNestedAccessibility.FooBarAccessibility.foo)
            .identifier

        let bar = AccessibilityKey
            .keyPath(\TestAccessibilityWithNestedAccessibility.FooBarAccessibility.bar)
            .identifier

        XCTAssertEqual(foo, "TestAccessibilityWithNestedAccessibility.FooBarAccessibility.foo")
        XCTAssertEqual(bar, "TestAccessibilityWithNestedAccessibility.FooBarAccessibility.bar")
    }

    func testThatIdentifierIsCorrectForNestedAccessibilityProperty() {
        let foo = AccessibilityKey
            .keyPath(\TestAccessibilityWithNestedAccessibility.fooBar.foo)
            .identifier

        let bar = AccessibilityKey
            .keyPath(\TestAccessibilityWithNestedAccessibility.fooBar.bar)
            .identifier

        XCTAssertEqual(foo, "TestAccessibilityWithNestedAccessibility.fooBar.foo")
        XCTAssertEqual(bar, "TestAccessibilityWithNestedAccessibility.fooBar.bar")
    }

    func testThatIdentifierIsCorrectForNestedGroup() {
        let foo = AccessibilityKey
            .keyPath(\TestAccessibilityWithNestedGroup.FooBarGroup.foo)
            .identifier

        let bar = AccessibilityKey
            .keyPath(\TestAccessibilityWithNestedGroup.FooBarGroup.bar)
            .identifier

        XCTAssertEqual(foo, "TestAccessibilityWithNestedGroup.FooBarGroup.foo")
        XCTAssertEqual(bar, "TestAccessibilityWithNestedGroup.FooBarGroup.bar")
    }

    func testThatIdentifierIsCorrectForNestedGroupProperty() {
        let foo = AccessibilityKey
            .keyPath(\TestAccessibilityWithNestedGroup.fooBar.foo)
            .identifier

        let bar = AccessibilityKey
            .keyPath(\TestAccessibilityWithNestedGroup.fooBar.bar)
            .identifier

        XCTAssertEqual(foo, "TestAccessibilityWithNestedGroup.fooBar.foo")
        XCTAssertEqual(bar, "TestAccessibilityWithNestedGroup.fooBar.bar")
    }
}
