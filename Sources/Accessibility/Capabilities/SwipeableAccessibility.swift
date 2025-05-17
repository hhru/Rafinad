import Foundation

/// Протокол для accessibility-схемы, наделяющий UI-компоненты возможностью
/// выполнять жесты свайпа в тестах.
///
/// Если подписать accessibility-схему компонента под этот протокол,
/// то в тестах для его экземпляра ``TestingElement`` станут доступны дополнительные методы,
/// с помощью которых можно выполнять жесты свайпа и перетягивания, например:
///
/// - `swipeLeft(velocity:)`: Выполняет жест свайпа влево с указанной скоростью.
/// - `swipeRight(velocity:)`: Выполняет жест свайпа вправо с указанной скоростью.
/// - `swipeUp(velocity:)`: Выполняет жест свайпа вверх с указанной скоростью.
/// - `swipeDown(velocity:)`: Выполняет жест свайпа вниз с указанной скоростью.
/// - `drag(from:to:)`: Выполняет жест перетягивания.
/// - `drag(deltaX:deltaY:)`: Выполняет жест перетягивания с указанной относительной длиной.
///
/// > Tip: Полный и актуальный список полей доступен в документации ``TestingElement``.
///
///
/// ## Пример
///
/// ``` swift
/// // Accessibility-схема компонента с возможностью выполнять жесты свайпа
/// class ChatsAccessibility:
///     ViewAccessibility,
///     SwipeableAccessibility { }
///
/// // Выполнение жеста свайпа вверх в тесте
/// chats.swipeUp()
/// ```
///
///
/// ## See Also
///
/// - ``ViewAccessibility``
/// - ``ScreenAccessibility``
/// - ``AccessibilityKey``
/// - ``TestingElement``
public protocol SwipeableAccessibility: ViewAccessibility { }
