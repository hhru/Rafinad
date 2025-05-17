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

    /// Создает тестируемое представление компонента с заданным объектом `XCUIElement`.
    ///
    /// - Parameter element: Оборачиваемый объект `XCUIElement`.
    public init(element: XCUIElement) {
        self.init(
            keyPaths: [\Accessibility.self],
            element: element
        )
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
    ///   - timeout: Время ожидания текста компонента в секундах.
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
        if !element.wait(for: \.frame, toEqual: frame, timeout: timeout), failing {
            XCTFail(
                "Frame of element \(element) was not equal to \(frame) within \(timeout) seconds",
                file: file,
                line: line
            )
        }

        return self
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
        if !element.waitForExistence(timeout: timeout), failing {
            XCTFail(
                "Element \(element) was not appeared within \(timeout) seconds",
                file: file,
                line: line
            )
        }

        return self
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
        if !element.waitForNonExistence(timeout: timeout), failing {
            XCTFail(
                "Element \(element) was not disappeared within \(timeout) seconds",
                file: file,
                line: line
            )
        }

        return self
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
