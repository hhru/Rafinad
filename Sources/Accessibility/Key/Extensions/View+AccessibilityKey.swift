import SwiftUI

extension View {

    /// Модифицирует UI-компонент accessibility-ключом.
    ///
    /// - Parameter accessibilityKey: Accessibility-ключ.
    /// - Returns: Новый модифицированный UI-компонент.
    public nonisolated func accessibilityKey(
        _ accessibilityKey: AccessibilityKey
    ) -> ModifiedContent<Self, AccessibilityKey> {
        modifier(accessibilityKey)
    }

    /// Модифицирует UI-компонент accessibility-ключом в виде key-path поля из accessibility-схемы.
    ///
    /// - Parameter keyPath: Key-path поля из accessibility-схемы.
    /// - Returns: Новый модифицированный UI-компонент.
    public nonisolated func accessibilityKey<Root: AnyObject, Value: ViewAccessibility>(
        _ keyPath: KeyPath<Root, Value>
    ) -> ModifiedContent<Self, AccessibilityKey> {
        accessibilityKey(.keyPath(keyPath))
    }

    /// Модифицирует UI-компонент accessibility-ключом в виде key-path массива из accessibility-схемы
    /// и уточняющей строки элемента этого массива.
    ///
    /// - Parameters:
    ///   - keyPath: Key-path массива из accessibility-схемы.
    ///   - item: Уточняющая строка элемента массива.
    ///           По умолчанию равен `nil`.
    /// - Returns: Новый модифицированный UI-компонент.
    public nonisolated func accessibilityKey<Root: AnyObject, Value: RangeReplaceableCollection>(
        _ keyPath: KeyPath<Root, Value>,
        item: String? = nil
    ) -> ModifiedContent<Self, AccessibilityKey> where Value.Element: ViewAccessibility {
        accessibilityKey(.keyPath(keyPath, item: item))
    }
}
