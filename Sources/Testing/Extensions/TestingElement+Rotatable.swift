import XCTest

#if !DOCUMENTATION
import Rafinad
#endif

#if os(iOS)
extension TestingElement where Accessibility: RotatableAccessibility {

    /// Выполняет жест поворота на указанный угол в радианах.
    ///
    /// Система сделает все возможное для выполнения требуемого поворота, но точность не гарантируется.
    /// Некоторые значения могут быть недоступны из-за размера элемента, и это приведет к падению теста.
    ///
    /// - Parameters:
    ///   - radians: Угол поворота в радианах.
    ///   - velocity: Скорость поворота в радианах в секунду.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func rotate(radians: CGFloat, velocity: CGFloat) -> Self {
        element.rotate(radians, withVelocity: velocity)

        return self
    }

    /// Выполняет жест поворота на указанный угол в радианах.
    ///
    /// Система сделает все возможное для выполнения требуемого поворота, но точность не гарантируется.
    /// Некоторые значения могут быть недоступны из-за размера элемента, и это приведет к падению теста.
    ///
    /// - Parameters:
    ///   - radians: Угол поворота в радианах.
    ///   - duration: Продолжительность выполнения жеста в секундах.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func rotate(radians: CGFloat, duration: TimeInterval) -> Self {
        rotate(
            radians: radians,
            velocity: radians / duration
        )
    }

    /// Выполняет жест поворота на указанный угол в градусах.
    ///
    /// Система сделает все возможное для выполнения требуемого поворота, но точность не гарантируется.
    /// Некоторые значения могут быть недоступны из-за размера элемента, и это приведет к падению теста.
    ///
    /// - Parameters:
    ///   - degrees: Угол поворота в градусах.
    ///   - velocity: Скорость поворота в градусах в секунду.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func rotate(degrees: CGFloat, velocity: CGFloat) -> Self {
        rotate(
            radians: degrees * 180.0 / .pi,
            velocity: velocity * 180.0 / .pi
        )
    }

    /// Выполняет жест поворота на указанный угол в градусах.
    ///
    /// Система сделает все возможное для выполнения требуемого поворота, но точность не гарантируется.
    /// Некоторые значения могут быть недоступны из-за размера элемента, и это приведет к падению теста.
    ///
    /// - Parameters:
    ///   - degrees: Угол поворота в градусах.
    ///   - duration: Продолжительность выполнения жеста в секундах.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func rotate(degrees: CGFloat, duration: TimeInterval) -> Self {
        rotate(
            degrees: degrees,
            velocity: degrees / duration
        )
    }
}
#endif
