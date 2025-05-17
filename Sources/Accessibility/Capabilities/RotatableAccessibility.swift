import Foundation

/// Протокол для accessibility-схемы, наделяющий UI-компоненты возможностью
/// выполнять жесты поворота двумя касаниями в тестах.
///
/// Если подписать accessibility-схему компонента под этот протокол,
/// то в тестах для его экземпляра ``TestingElement`` станет доступен дополнительный методы,
/// с помощью которого можно выполнять жесты поворота двумя касаниями.
///
///
/// ## Пример
///
/// ``` swift
/// // Accessibility-схема компонента с возможностью выполнять жесты поворота
/// class MapAccessibility:
///     ViewAccessibility,
///     RotatableAccessibility { }
///
/// // Выполнение жеста поворота в тестах
/// map.rotate(degrees: 45, duration: 1)
/// ```
///
///
/// ## See Also
///
/// - ``ViewAccessibility``
/// - ``ScreenAccessibility``
/// - ``AccessibilityKey``
/// - ``TestingElement``
public protocol RotatableAccessibility: ViewAccessibility { }
