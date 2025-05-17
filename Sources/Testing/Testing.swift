import XCTest

/// Вспомогательный протокол общих методов ``TestingElement`` и ``TestingList``.
public protocol Testing { }

extension Testing {

    /// Проверяет, что тестируемый элемент соответствует условию.
    ///
    /// - Parameters:
    ///   - condition: Замыкание, определяющее условие.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого элемента.
    @discardableResult
    public func assert(
        condition: (Self) -> Bool,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertTrue(
            condition(self),
            file: file,
            line: line
        )

        return self
    }

    /// Проверяет условие.
    ///
    /// - Parameters:
    ///   - condition: Автозамыкание, определяющее условие.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого элемента.
    @discardableResult
    public func assert(
        condition: @autoclosure () -> Bool,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertTrue(
            condition(),
            file: file,
            line: line
        )

        return self
    }

    /// Выполняет указанное действие в виде замыкания.
    ///
    /// Метод может быть полезен в случаях, когда нужно выполнить действия с дочерними компонентами,
    /// затем продолжить выполнять действия с самим элементом, не прерывая цепочку.
    ///
    /// Например:
    ///
    /// ``` swift
    /// cell
    ///     .perform { $0.title.assert(text: user.fullName) }
    ///     .perform { $0.subtitle.assert(text: user.position) }
    /// ```
    ///
    /// - Parameter action: Действие в виде замыкания.
    /// - Returns: Экземпляр тестируемого элемента.
    @discardableResult
    public func perform(_ action: (Self) -> Void) -> Self {
        action(self)

        return self
    }

    /// Выполняет указанное действие в виде замыкания.
    ///
    /// Метод может быть полезен в случаях, когда нужно выполнить действия с другими элементами,
    /// затем продолжить выполнять действия с самим элементом, не прерывая цепочку.
    ///
    /// Например:
    ///
    /// ``` swift
    /// screen
    ///     .searchField
    ///     .tap()
    ///     .waitForFocused()
    ///     .perform { usersScreen.swipeUp() }
    ///     .waitForUnfocused()
    /// ```
    ///
    /// - Parameter action: Действие в виде замыкания.
    /// - Returns: Экземпляр тестируемого элемента.
    @discardableResult
    public func perform(_ action: () -> Void) -> Self {
        action()

        return self
    }
}
