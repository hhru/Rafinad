import Rafinad

final class TestAccessibilityWithComputedProperty: ViewAccessibility {

    final class BarAccessibility: ViewAccessibility { }
}

extension TestAccessibilityWithComputedProperty {

    var foo: TextAccessibility {
        TextAccessibility()
    }

    var bar: BarAccessibility {
        BarAccessibility()
    }
}
