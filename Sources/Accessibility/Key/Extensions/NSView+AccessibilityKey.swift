#if canImport(AppKit) && os(macOS)
import AppKit

extension NSView {

    /// Устанавливает accessibility-ключ UI-компонента для его поиска в тестах.
    ///
    /// - Parameter keyPath: Accessibility-ключ UI-компонента.
    public func setAccessibilityKey(_ accessibilityKey: AccessibilityKey?) {
        setAccessibilityIdentifier(accessibilityKey?.identifier)
    }

    /// Устанавливает accessibility-ключ UI-компонента для его поиска в тестах.
    ///
    /// - Returns: Accessibility-ключ UI-компонента.
    public func accessibilityKey() -> AccessibilityKey? {
        let accessibilityIdentifier = accessibilityIdentifier()

        guard !accessibilityIdentifier.isEmpty else {
            return nil
        }

        return .identifier(accessibilityIdentifier)
    }
}
#endif
