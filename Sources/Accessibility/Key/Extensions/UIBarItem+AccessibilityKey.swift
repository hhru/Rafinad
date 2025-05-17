#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

extension UIBarItem {

    /// Accessibility-ключ UI-компонента для его поиска в тестах.
    public var accessibilityKey: AccessibilityKey? {
        get { accessibilityIdentifier.map(AccessibilityKey.identifier(_:)) }
        set { accessibilityIdentifier = newValue?.identifier }
    }
}
#endif
