import XCTest

#if !DOCUMENTATION
import Rafinad
#endif

extension TestingElement where Accessibility: SelectableAccessibility {

    /// Выбранное состояние компонента.
    ///
    /// Равно `nil` в случае, если компонент не найден.
    public var isSelected: Bool? {
        element.isContentSelected
    }

    /// Проверяет, что выбранное состояние компонента равно указанному.
    ///
    /// - Parameters:
    ///   - isSelected: Выбранное состояние.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func assert(
        isSelected: Bool,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertEqual(
            self.isSelected,
            isSelected,
            file: file,
            line: line
        )

        return self
    }

    /// Ждет указанное время, пока компонент не станет выбранным.
    ///
    /// - Parameters:
    ///   - timeout: Время ожидания выбора компонента в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForSelected(
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        if !element.wait(for: \.isContentSelected, toEqual: true, timeout: timeout), failing {
            XCTFail(
                "Element \(element) was not selected within \(timeout) seconds",
                file: file,
                line: line
            )
        }

        return self
    }

    /// Ждет указанное время, пока компонент не перестанет быть выбранным.
    ///
    /// - Parameters:
    ///   - timeout: Время ожидания снятия выбора с компонента в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForDeselected(
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        if !element.wait(for: \.isContentSelected, toEqual: false, timeout: timeout), failing {
            XCTFail(
                "Element \(element) was not deselected within \(timeout) seconds",
                file: file,
                line: line
            )
        }

        return self
    }
}

extension XCUIElement {

    fileprivate var isContentSelected: Bool? {
        guard exists else {
            return nil
        }

        if isSelected {
            return true
        }

        let children = children(matching: .any).allElementsBoundByIndex

        if children.isEmpty {
            return false
        }

        return children.allSatisfy { $0.isSelected }
    }
}
