import XCTest

#if !DOCUMENTATION
import Rafinad
#endif

extension TestingElement where Accessibility: DisableableAccessibility {

    /// Включенное состояние компонента.
    ///
    /// Равно `nil` в случае, если компонент не найден.
    public var isEnabled: Bool? {
        element.isContentEnabled
    }

    /// Проверяет, что включенное состояние компонента равно указанному.
    ///
    /// - Parameters:
    ///   - isEnabled: Включенное состояние.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func assert(
        isEnabled: Bool,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertEqual(
            self.isEnabled,
            isEnabled,
            file: file,
            line: line
        )

        return self
    }

    /// Ждет указанное время, пока компонент не станет отключенным.
    ///
    /// - Parameters:
    ///   - timeout: Время ожидания отключения компонента в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForDisabled(
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        if !element.wait(for: \.isContentEnabled, toEqual: false, timeout: timeout), failing {
            XCTFail(
                "Element \(element) was not disabled within \(timeout) seconds",
                file: file,
                line: line
            )
        }

        return self
    }

    /// Ждет указанное время, пока компонент не станет включенным.
    ///
    /// - Parameters:
    ///   - timeout: Время ожидания включения компонента в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForEnabled(
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        if !element.wait(for: \.isContentEnabled, toEqual: true, timeout: timeout), failing {
            XCTFail(
                "Element \(element) was not enabled within \(timeout) seconds",
                file: file,
                line: line
            )
        }

        return self
    }
}

extension XCUIElement {

    fileprivate var isContentEnabled: Bool? {
        guard exists else {
            return nil
        }

        if !isEnabled {
            return false
        }

        return children(matching: .any)
            .allElementsBoundByIndex
            .allSatisfy { $0.isEnabled }
    }
}
