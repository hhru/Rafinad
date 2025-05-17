import Foundation

internal struct AccessibilityKeyContent: Hashable, @unchecked Sendable {

    private let keyPath: AnyKeyPath?
    private let rawValue: String?

    internal var identifier: String? {
        keyPath?.accessibilityIdentifier(item: rawValue)
            ?? rawValue
            ?? ""
    }

    private init(keyPath: AnyKeyPath?, rawValue: String?) {
        self.keyPath = keyPath
        self.rawValue = rawValue
    }
}

extension AccessibilityKeyContent {

    internal static func identifier(_ identifier: String) -> Self {
        Self(
            keyPath: nil,
            rawValue: identifier
        )
    }

    internal static func keyPath<Root: AnyObject, Value: ViewAccessibility>(
        _ keyPath: KeyPath<Root, Value>
    ) -> Self {
        Self(keyPath: keyPath, rawValue: nil)
    }

    internal static func keyPath<Root: AnyObject, Value: RangeReplaceableCollection>(
        _ keyPath: KeyPath<Root, Value>,
        item: String? = nil
    ) -> Self where Value.Element: ViewAccessibility {
        Self(keyPath: keyPath, rawValue: item)
    }
}
