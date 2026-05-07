import XCTest

#if !DOCUMENTATION
import Rafinad
#endif

extension TestingElement where Accessibility: ViewAccessibility {

    /// Фрейм компонента в системе координат экрана.
    ///
    /// Равна `nil` в случае, если компонент не найден.
    public var frame: CGRect? {
        element.exists
            ? element.frame
            : nil
    }

    /// Наличие компонента.
    public var isExist: Bool {
        element.exists
    }

    /// Проверяет, что фрейм компонента равен указанному.
    ///
    /// - Parameters:
    ///   - frame: Фрейм компонента.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func assert(
        frame: CGRect,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertEqual(
            self.frame,
            frame,
            file: file,
            line: line
        )

        return self
    }

    /// Проверяет, что фрейм компонента находится внутри фрейма другого компонента.
    ///
    /// - Parameters:
    ///   - other: Другой компонент.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func assertFrame<Element: ViewAccessibility>(
        inside other: TestingElement<Element>,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertTrue(
            frame.flatMap { frame in
                other.frame?.contains(frame)
            } ?? false,
            file: file,
            line: line
        )

        return self
    }

    /// Проверяет, что фрейм компонента содержит фрейм другого компонента.
    ///
    /// - Parameters:
    ///   - other: Другой компонент.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func assertFrame<Element: ViewAccessibility>(
        contains other: TestingElement<Element>,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertTrue(
            other.frame.flatMap { otherFrame in
                frame?.contains(otherFrame)
            } ?? false,
            file: file,
            line: line
        )

        return self
    }

    /// Проверяет, что фрейм компонента пересекается с фреймом другого компонента.
    ///
    /// - Parameters:
    ///   - other: Другой компонент.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func assertFrame<Element: ViewAccessibility>(
        intersects other: TestingElement<Element>,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertTrue(
            other.frame.flatMap { otherFrame in
                frame?.intersects(otherFrame)
            } ?? false,
            file: file,
            line: line
        )

        return self
    }

    /// Проверяет, что наличие компонента равно указанному.
    ///
    /// - Parameters:
    ///   - isExist: Наличие компонента.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func assert(
        isExist: Bool,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertEqual(
            self.isExist,
            isExist,
            file: file,
            line: line
        )

        return self
    }

    /// Ждет указанное время, пока фрейм компонента не станет равен указанному.
    ///
    /// - Parameters:
    ///   - frame: Фрейм компонента.
    ///   - timeout: Время ожидания фрейма компонента в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForFrame(
        _ frame: CGRect,
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        wait(
            for: self.frame == frame,
            timeout: timeout,
            failing: failing,
            message: "Frame of element \(element) was not equal to \(frame) within \(timeout) seconds",
            file: file,
            line: line
        )
    }

    /// Ждет указанное время, пока фрейм компонента не станет находиться внутри фрейма другого компонента.
    ///
    /// - Parameters:
    ///   - other: Другой компонент.
    ///   - timeout: Время ожидания фрейма компонента в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForFrame<Element: ViewAccessibility>(
        inside other: TestingElement<Element>,
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        wait(
            for: frame.flatMap { frame in
                other.frame?.contains(frame)
            } ?? false,
            timeout: timeout,
            failing: failing,
            message: "Frame of element \(element) was not inside frame of \(other.element) within \(timeout) seconds",
            file: file,
            line: line
        )
    }

    /// Ждет указанное время, пока фрейм компонента не станет содержать фрейм другого компонента.
    ///
    /// - Parameters:
    ///   - other: Другой компонент.
    ///   - timeout: Время ожидания фрейма компонента в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForFrame<Element: ViewAccessibility>(
        contains other: TestingElement<Element>,
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        wait(
            for: other.frame.flatMap { otherFrame in
                frame?.contains(otherFrame)
            } ?? false,
            timeout: timeout,
            failing: failing,
            message: "Frame of element \(element) did not contain frame of \(other.element) within \(timeout) seconds",
            file: file,
            line: line
        )
    }

    /// Ждет указанное время, пока фрейм компонента не станет пересекаться с фреймом другого компонента.
    ///
    /// - Parameters:
    ///   - other: Другой компонент.
    ///   - timeout: Время ожидания фрейма компонента в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForFrame<Element: ViewAccessibility>(
        intersects other: TestingElement<Element>,
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        wait(
            for: other.frame.flatMap { otherFrame in
                frame?.intersects(otherFrame)
            } ?? false,
            timeout: timeout,
            failing: failing,
            message: "Frame of \(element) did not intersect frame of \(other.element) within \(timeout) seconds",
            file: file,
            line: line
        )
    }

    /// Ждет указанное время, пока компонент не появится.
    ///
    /// - Parameters:
    ///   - timeout: Время ожидания появления компонента в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForExistence(
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        wait(
            for: isExist,
            timeout: timeout,
            failing: failing,
            message: "Element \(element) was not appeared within \(timeout) seconds",
            file: file,
            line: line
        )
    }

    /// Ждет указанное время, пока компонент не исчезнет.
    ///
    /// - Parameters:
    ///   - timeout: Время ожидания исчезновения компонента в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForNonExistence(
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        wait(
            for: !isExist,
            timeout: timeout,
            failing: failing,
            message: "Element \(element) was not disappeared within \(timeout) seconds",
            file: file,
            line: line
        )
    }

    /// Выводит в консоль отладочную информацию.
    ///
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func print() -> Self {
        Swift.print(element.debugDescription)

        return self
    }
}

extension XCUIElement {

    /// Создает тестируемое представление компонента с заданным типом его accessibility-схемы.
    ///
    /// - Parameter type: Тип accessibility-схемы компонента.
    /// - Returns: Тестируемое представление компонента.
    public func view<View: ViewAccessibility>(of type: View.Type) -> TestingElement<View> {
        TestingElement(element: self)
    }
}
