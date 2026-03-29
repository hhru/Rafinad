import XCTest
import Rafinad

@MainActor
final class AccessibilityKeyPrimitiveTests: XCTestCase {

    func testThatPrimitiveIsNilForRawIdentifier() {
        let foo = AccessibilityKey
            .identifier("foo")
            .isPrimitive

        let bar = AccessibilityKey
            .identifier("bar")
            .isPrimitive

        XCTAssertNil(foo)
        XCTAssertNil(bar)
    }

    func testThatPrimitiveIsCorrectForKeyPath() throws {
        let foo = AccessibilityKey
            .keyPath(\TestAccessibility.foo)
            .isPrimitive

        let bar = AccessibilityKey
            .keyPath(\TestAccessibility.bar)
            .isPrimitive

        XCTAssertTrue(try XCTUnwrap(foo))
        XCTAssertTrue(try XCTUnwrap(bar))
    }

    func testThatPrimitiveIsCorrectForNestedAccessibility() {
        let foo = AccessibilityKey
            .keyPath(\TestAccessibilityWithNestedAccessibility.FooBarAccessibility.foo)
            .isPrimitive

        let bar = AccessibilityKey
            .keyPath(\TestAccessibilityWithNestedAccessibility.FooBarAccessibility.bar)
            .isPrimitive

        XCTAssertTrue(try XCTUnwrap(foo))
        XCTAssertFalse(try XCTUnwrap(bar))
    }

    func testThatPrimitiveIsCorrectForNestedAccessibilityProperty() {
        let foo = AccessibilityKey
            .keyPath(\TestAccessibilityWithNestedAccessibility.fooBar.foo)
            .isPrimitive

        let bar = AccessibilityKey
            .keyPath(\TestAccessibilityWithNestedAccessibility.fooBar.bar)
            .isPrimitive

        XCTAssertTrue(try XCTUnwrap(foo))
        XCTAssertFalse(try XCTUnwrap(bar))
    }

    func testThatPrimitiveIsCorrectForNestedGroup() {
        let foo = AccessibilityKey
            .keyPath(\TestAccessibilityWithNestedGroup.FooBarGroup.foo)
            .isPrimitive

        let bar = AccessibilityKey
            .keyPath(\TestAccessibilityWithNestedGroup.FooBarGroup.bar)
            .isPrimitive

        XCTAssertTrue(try XCTUnwrap(foo))
        XCTAssertFalse(try XCTUnwrap(bar))
    }

    func testThatPrimitiveIsCorrectForNestedGroupProperty() {
        let foo = AccessibilityKey
            .keyPath(\TestAccessibilityWithNestedGroup.fooBar.foo)
            .isPrimitive

        let bar = AccessibilityKey
            .keyPath(\TestAccessibilityWithNestedGroup.fooBar.bar)
            .isPrimitive

        XCTAssertTrue(try XCTUnwrap(foo))
        XCTAssertFalse(try XCTUnwrap(bar))
    }

    func testThatPrimitiveIsCorrectForComputedProperty() {
        let foo = AccessibilityKey
            .keyPath(\TestAccessibilityWithComputedProperty.foo)
            .isPrimitive

        let bar = AccessibilityKey
            .keyPath(\TestAccessibilityWithComputedProperty.bar)
            .isPrimitive

        XCTAssertTrue(try XCTUnwrap(foo))
        XCTAssertFalse(try XCTUnwrap(bar))
    }

    func testThatPrimitiveIsCorrectForArray() {
        let foo = AccessibilityKey
            .keyPath(\TestAccessibilityWithArrays.foo)
            .isPrimitive

        let bar = AccessibilityKey
            .keyPath(\TestAccessibilityWithArrays.bar, item: "qwe")
            .isPrimitive

        XCTAssertTrue(try XCTUnwrap(foo))
        XCTAssertFalse(try XCTUnwrap(bar))
    }
}
