import Foundation

/// Направление жеста свайпа в тестах.
///
/// ## See Also
///
/// - ``TestingElement``
/// - ``SwipeableAccessibility``
public enum TestingSwipeDirection: Equatable, Sendable {

    /// Направление жеста свайпа вверх.
    case up

    /// Направление жеста свайпа вниз.
    case down

    /// Направление жеста свайпа влево.
    case left

    /// Направление жеста свайпа вправо.
    case right
}
