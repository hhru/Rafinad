import Foundation

/// Протокол для accessibility-схемы, наделяющий UI-компоненты возможностью
/// выполнять жесты масштабирования двумя касаниями в тестах.
///
/// Если подписать accessibility-схему компонента под этот протокол,
/// то в тестах для его экземпляра ``TestingElement`` станет доступен дополнительный методы,
/// с помощью которого можно выполнять жесты масштабирования двумя касаниями.
///
///
/// ## Пример
///
/// ``` swift
/// // Accessibility-схема компонента с возможностью выполнять жесты поворота
/// class CropAccessibility:
///     ViewAccessibility,
///     PinchableAccessibility { }
///
/// // Выполнение жеста масштабирования в тестах
/// map.pinch(scale: 2, duration: 1)
/// ```
///
///
/// ## See Also
///
/// - ``ViewAccessibility``
/// - ``ScreenAccessibility``
/// - ``AccessibilityKey``
/// - ``TestingElement``
public protocol PinchableAccessibility: ViewAccessibility { }
