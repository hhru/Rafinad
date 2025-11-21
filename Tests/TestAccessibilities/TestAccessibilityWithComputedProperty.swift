import Rafinad

final class TestAccessibilityWithComputedProperty: ViewAccessibility {

    var foo: TextAccessibility {
        TextAccessibility()
    }

    var bar: TestAccessibility {
        TestAccessibility()
    }
}
