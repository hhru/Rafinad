import Foundation

/// Протокол для accessibility-схемы, наделяющий UI-компоненты возможностью
/// обрабатывать отключенное состояние в тестах.
///
/// Если подписать accessibility-схему компонента под этот протокол,
/// то в тестах для его экземпляра ``TestingElement`` станут доступны дополнительные поля,
/// с помощью которых можно обрабатывать отключенное состояние компонента, например:
///
/// - `isEnabled`: Индикатор включенного состояние компонента.
/// - `assert(isEnabled:)`: Проверяет, что включенное состояние компонента равно указанному.
/// - `waitForDisabled(timeout:failing:)`: Ждет указанное время, пока компонент не станет отключенным.
/// - `waitForEnabled(timeout:failing:)`: Ждет указанное время, пока компонент не станет отключенным.
///
/// > Tip: Полный и актуальный список полей доступен в документации ``TestingElement``.
///
///
/// ## Пример
///
/// ``` swift
/// // Accessibility-схема компонента с возможностью быть отключенным
/// class RadioAccessibility:
///     ViewAccessibility,
///     DisableableAccessibility { }
///
/// // Проверка отключенного состояния компонента в тесте
/// radio.assert(isEnabled: true)
/// ```
///
/// ## See Also
///
/// - ``ViewAccessibility``
/// - ``ScreenAccessibility``
/// - ``AccessibilityKey``
/// - ``TestingElement``
public protocol DisableableAccessibility: ViewAccessibility { }
