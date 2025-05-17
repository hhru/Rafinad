import Foundation

/// Протокол для accessibility-схемы, наделяющий UI-компоненты возможностью
/// обрабатывать выбранное состояние в тестах.
///
/// Если подписать accessibility-схему компонента под этот протокол,
/// то в тестах для его экземпляра ``TestingElement`` станут доступны дополнительные поля,
/// с помощью которых можно обрабатывать выбранное состояние компонента, например:
///
/// - `isSelected`: Индикатор выбранного состояние компонента.
/// - `assert(isSelected:)`: Проверяет, что выбранное состояние компонента равно указанному.
/// - `waitForSelected(timeout:failing:)`: Ждет указанное время, пока компонент не станет выбранным.
/// - `waitForDeselected(timeout:failing:)`: Ждет указанное время, пока компонент не перестанет быть выбранным.
///
/// > Tip: Полный и актуальный список полей доступен в документации ``TestingElement``.
///
///
/// ## Пример
///
/// ``` swift
/// // Accessibility-схема компонента с возможностью быть выбранным
/// class CheckboxAccessibility:
///     ViewAccessibility,
///     SelectableAccessibility { }
///
/// // Проверка и переключение выбранного состояния компонента в тесте
/// checkbox
///     .assert(isSelected: false)
///     .tap()
///     .assert(isSelected: true)
/// ```
///
///
/// ## See Also
///
/// - ``ViewAccessibility``
/// - ``ScreenAccessibility``
/// - ``AccessibilityKey``
/// - ``TestingElement``
public protocol SelectableAccessibility: ViewAccessibility { }
