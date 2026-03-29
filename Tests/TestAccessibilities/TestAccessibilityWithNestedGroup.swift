import Rafinad

final class TestAccessibilityWithNestedGroup: ViewAccessibility {

    final class FooBarGroup {
        let foo = TextAccessibility()
        let bar = TestAccessibility()
    }

    let fooBar = FooBarGroup()
}
