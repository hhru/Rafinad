import XCTest

#if !DOCUMENTATION
import Rafinad
#endif

#if os(iOS)
extension TestingElement where Accessibility: PinchableAccessibility {

    /// Выполняет жест масштабирования на указанный множитель.
    ///
    /// Система сделает все возможное для выполнения требуемого масштабирования, но точность не гарантируется.
    /// Некоторые значения могут быть недоступны из-за размера элемента, и это приведет к падению теста.
    ///
    /// - Parameters:
    ///   - scale: Коэффициент масштабирования.
    ///            Значения от 0 до 1 используются для уменьшения масштаба и больше 1 - для увеличения.
    ///   - velocity: Скорость поворота в коэффициенте масштабирования в секунду.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func pinch(scale: CGFloat, velocity: CGFloat) -> Self {
        element.pinch(withScale: scale, velocity: velocity)

        return self
    }

    /// Выполняет жест масштабирования на указанный множитель.
    ///
    /// Система сделает все возможное для выполнения требуемого масштабирования, но точность не гарантируется.
    /// Некоторые значения могут быть недоступны из-за размера элемента, и это приведет к падению теста.
    ///
    /// - Parameters:
    ///   - scale: Коэффициент масштабирования.
    ///            Значения от 0 до 1 используются для уменьшения масштаба и больше 1 - для увеличения.
    ///   - duration: Продолжительность выполнения жеста в секундах.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func pinch(scale: CGFloat, duration: TimeInterval) -> Self {
        pinch(
            scale: scale,
            velocity: scale / duration
        )

        return self
    }
}
#endif
