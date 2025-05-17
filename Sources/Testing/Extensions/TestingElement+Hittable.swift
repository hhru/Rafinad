import XCTest

#if !DOCUMENTATION
import Rafinad
#endif

extension TestingElement where Accessibility: ViewAccessibility {

    /// Доступность компонента для касаний.
    ///
    /// Равен `false` в случае, если компонент не найден.
    public var isHittable: Bool {
        element.isHittable
    }

    /// Проверяет, что доступность компонента для касаний равна указанной.
    ///
    /// - Parameters:
    ///   - isHittable: Доступность для касаний.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func assert(
        isHittable: Bool,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertEqual(
            self.isHittable,
            isHittable,
            file: file,
            line: line
        )

        return self
    }

    /// Ждет указанное время, пока компонент не станет доступным для касаний.
    ///
    /// - Parameters:
    ///   - timeout: Время ожидания доступности компонента для касаний в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForHittable(
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        if !element.wait(for: \.isHittable, toEqual: true, timeout: timeout), failing {
            XCTFail(
                "Element \(element) was not hittable within \(timeout) seconds",
                file: file,
                line: line
            )
        }

        return self
    }

    /// Ждет указанное время, пока компонент не перестанет быть доступным для касаний.
    ///
    /// - Parameters:
    ///   - timeout: Время ожидания недоступности компонента для касаний в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForUnhittable(
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        if !element.wait(for: \.isHittable, toEqual: false, timeout: timeout), failing {
            XCTFail(
                "Element \(element) was hittable within \(timeout) seconds",
                file: file,
                line: line
            )
        }

        return self
    }

    #if os(iOS)
    /// Тапает на компонент указанное количество раз, используя указанное количество точек касаний.
    ///
    /// - Parameters:
    ///   - count: Количество тапов.
    ///   - touchCount: Количество точек касания.
    ///                 По умолчанию равен 1.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func tap(count: Int, touchCount: Int = 1) -> Self {
        element.tap(
            withNumberOfTaps: count,
            numberOfTouches: touchCount
        )

        return self
    }
    #endif

    #if os(iOS) || os(macOS)
    /// Тапает на центр компонента.
    ///
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func tap() -> Self {
        element.tap()

        return self
    }

    /// Тапает по указанным координатам компонента.
    ///
    /// - Parameters:
    ///   - x: Относительная координата по горизонтали.
    ///   - y: Относительная координата по вертикали.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func tap(x: CGFloat, y: CGFloat) -> Self {
        element
            .coordinate(withNormalizedOffset: CGVector(dx: x, dy: y))
            .tap()

        return self
    }

    /// Дважды тапает на центр компонента.
    ///
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func doubleTap() -> Self {
        element.doubleTap()

        return self
    }

    /// Дважды тапает по указанным координатам компонента.
    ///
    /// - Parameters:
    ///   - x: Относительная координата по горизонтали.
    ///   - y: Относительная координата по вертикали.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func doubleTap(x: CGFloat, y: CGFloat) -> Self {
        element
            .coordinate(withNormalizedOffset: CGVector(dx: x, dy: y))
            .doubleTap()

        return self
    }

    /// Удерживает касание по центру компонента на указанное время.
    ///
    /// - Parameter duration: Продолжительность касания в секундах.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func press(duration: TimeInterval) -> Self {
        element.press(forDuration: duration)

        return self
    }

    /// Удерживает касание по указанным координатам компонента на указанное время.
    ///
    /// - Parameters:
    ///   - duration: Продолжительность касания в секундах.
    ///   - x: Относительная координата по горизонтали.
    ///   - y: Относительная координата по вертикали.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func press(duration: TimeInterval, x: CGFloat, y: CGFloat) -> Self {
        element
            .coordinate(withNormalizedOffset: CGVector(dx: x, dy: y))
            .press(forDuration: duration)

        return self
    }

    /// Удерживает касание по центру компонента на время распознования жеста по умолчанию.
    ///
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func longPress() -> Self {
        element.press(forDuration: 0.5)

        return self
    }

    /// Удерживает касание по указанным координатам компонента на время распознования жеста по умолчанию.
    ///
    /// - Parameters:
    ///   - x: Относительная координата по горизонтали.
    ///   - y: Относительная координата по вертикали.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func longPress(x: CGFloat, y: CGFloat) -> Self {
        element
            .coordinate(withNormalizedOffset: CGVector(dx: x, dy: y))
            .press(forDuration: 0.5)

        return self
    }
    #endif
}
