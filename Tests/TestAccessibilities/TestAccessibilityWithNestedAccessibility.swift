import Rafinad

final class TestAccessibilityWithNestedAccessibility: ViewAccessibility {

    final class FooBarAccessibility: ViewAccessibility {
        let foo = TextAccessibility()
        let bar = TestAccessibility()
    }

    let fooBar = FooBarAccessibility()
}
