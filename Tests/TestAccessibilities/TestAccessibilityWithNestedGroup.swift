import Rafinad

final class TestAccessibilityWithNestedGroup: ViewAccessibility {

    final class FooBarGroup {
        let foo = TextAccessibility()
        let bar = ImageAccessibility()
    }

    let fooBar = FooBarGroup()
}
