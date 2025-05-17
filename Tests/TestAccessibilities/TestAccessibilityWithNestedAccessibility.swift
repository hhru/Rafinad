import Rafinad

final class TestAccessibilityWithNestedAccessibility: ViewAccessibility {

    final class FooBarAccessibility: ViewAccessibility {
        let foo = TextAccessibility()
        let bar = ImageAccessibility()
    }

    let fooBar = FooBarAccessibility()
}
