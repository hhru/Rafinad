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

    /// Выполняет действие, пока не будет выполнено условие или не истечет время ожидания.
    ///
    /// Условие может проверяться многократно и не должно содержать проверок XCTest или побочных эффектов.
    /// Действие может выполняться многократно, поэтому должно поддерживать безопасный повторный вызов
    /// и не должно содержать проверок XCTest или ожиданий, завершающих тест с ошибкой.
    ///
    /// - Parameters:
    ///   - condition: Условие завершения повторных попыток.
    ///   - timeout: Максимальное время выполнения повторных попыток в секундах.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного выполнения.
    ///   - file: Файл, в котором должен произойти сбой.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///   - action: Повторяемое действие.
    /// - Returns: Экземпляр тестируемого элемента.
    @discardableResult
    public func perform(
        until condition: (Self) -> Bool,
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line,
        action: (Self) -> Void
    ) -> Self {
        if condition(self) {
            return self
        }

        var retryInterval = 0.2
        let timeoutDate = Date(timeIntervalSinceNow: timeout)

        while Date() < timeoutDate {
            action(self)

            guard Date() < timeoutDate else {
                break
            }

            let isConditionSatisfiedAfterAction = condition(self)

            guard Date() < timeoutDate else {
                break
            }

            if isConditionSatisfiedAfterAction {
                return self
            }

            let waitDuration = min(retryInterval, timeoutDate.timeIntervalSinceNow)
            RunLoop.current.run(until: Date(timeIntervalSinceNow: waitDuration))

            guard Date() < timeoutDate else {
                break
            }

            let isConditionSatisfiedAfterWaiting = condition(self)

            guard Date() < timeoutDate else {
                break
            }

            if isConditionSatisfiedAfterWaiting {
                return self
            }

            retryInterval = min(retryInterval * 1.5, 2.0)
        }

        if failing {
            XCTFail(
                "Condition was not satisfied within \(timeout) seconds",
                file: file,
                line: line
            )
        }

        return self
    }

    /// Выполняет действие, пока не будет выполнено условие или не истечет время ожидания.
    ///
    /// Условие может проверяться многократно и не должно содержать проверок XCTest или побочных эффектов.
    /// Действие может выполняться многократно, поэтому должно поддерживать безопасный повторный вызов
    /// и не должно содержать проверок XCTest или ожиданий, завершающих тест с ошибкой.
    ///
    /// - Parameters:
    ///   - condition: Условие завершения повторных попыток.
    ///   - timeout: Максимальное время выполнения повторных попыток в секундах.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного выполнения.
    ///   - file: Файл, в котором должен произойти сбой.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///   - action: Повторяемое действие.
    /// - Returns: Экземпляр тестируемого элемента.
    @discardableResult
    public func perform(
        until condition: () -> Bool,
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line,
        action: () -> Void
    ) -> Self {
        perform(
            until: { _ in condition() },
            timeout: timeout,
            failing: failing,
            file: file,
            line: line,
            action: { _ in action() }
        )
    }

    /// Проверяет условие.
    ///
    /// - Parameters:
    ///   - condition: Автозамыкание, определяющее условие.
    ///   - message: Описание ошибки в случае сбоя.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого элемента.
    @discardableResult
    public func assert(
        _ condition: @autoclosure () -> Bool,
        message: String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertTrue(
            condition(),
            message,
            file: file,
            line: line
        )

        return self
    }

    /// Проверяет, что тестируемый элемент соответствует условию.
    ///
    /// - Parameters:
    ///   - condition: Замыкание, определяющее условие.
    ///   - message: Описание ошибки в случае сбоя.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого элемента.
    @discardableResult
    public func assert(
        _ condition: (Self) -> Bool,
        message: String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        assert(
            condition(self),
            message: message,
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
    ///   - message: Описание ошибки в случае сбоя.
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

        var pollInterval = 0.2
        let timeoutDate = Date(timeIntervalSinceNow: timeout)

        while Date() < timeoutDate {
            let waitDuration = min(pollInterval, timeoutDate.timeIntervalSinceNow)

            RunLoop.current.run(until: Date(timeIntervalSinceNow: waitDuration))

            if condition() {
                return self
            }

            pollInterval = min(pollInterval * 1.5, 2.0)
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
    ///   - message: Описание ошибки в случае сбоя.
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
