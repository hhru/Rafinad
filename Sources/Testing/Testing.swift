import XCTest

/// Вспомогательный протокол общих методов ``TestingElement`` и ``TestingList``.
public protocol Testing { }

extension Testing {

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
        _ condition: @autoclosure () -> Bool,
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
        _ condition: (Self) -> Bool,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        assert(
            condition(self),
            file: file,
            line: line
        )

        return self
    }

    /// Ждет указанное время, пока не выполнится условие.
    ///
    /// - Parameters:
    ///   - condition: Автозамыкание, определяющее условие.
    ///   - timeout: Время ожидания текста компонента в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого элемента.
    @discardableResult
    public func wait(
        for condition: @autoclosure () -> Bool,
        timeout: TimeInterval = 4,
        failing: Bool = true,
        message: String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        if condition() {
            return self
        }

        let timeoutDate = Date(timeIntervalSinceNow: timeout)
        let pollInterval = 0.1

        while Date() < timeoutDate {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: pollInterval))

            if condition() {
                return self
            }
        }

        if failing {
            XCTFail(
                message,
                file: file,
                line: line
            )
        }

        return self
    }

    /// Ждет указанное время, пока не выполнится условие.
    ///
    /// - Parameters:
    ///   - condition: Замыкание, определяющее условие.
    ///   - timeout: Время ожидания текста компонента в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого элемента.
    @discardableResult
    public func wait(
        for condition: (Self) -> Bool,
        timeout: TimeInterval = 4,
        failing: Bool = true,
        message: String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        wait(
            for: condition(self),
            timeout: timeout,
            failing: failing,
            message: message,
            file: file,
            line: line
        )
    }
}
