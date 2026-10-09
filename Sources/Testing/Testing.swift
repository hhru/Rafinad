import XCTest

/// Вспомогательный протокол общих методов ``TestingElement`` и ``TestingList``.
///
/// ## See Also
///
/// - ``TestingElement``
/// - ``TestingList``
/// - ``TestingOptions``
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
    /// Интервал проверки условия и пауза после успешного ожидания
    /// задаются глобальными настройками ``TestingOptions/current``.
    ///
    /// - Parameters:
    ///   - condition: Автозамыкание, определяющее условие.
    ///   - timeout: Время ожидания в секундах.
    ///              По умолчанию используется ``TestingOptions/waitDefaultTimeout``.
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
        timeout: TimeInterval = TestingOptions.current.waitDefaultTimeout,
        failing: Bool = true,
        message: String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        let options = TestingOptions.current

        if condition() {
            RunLoop.current.run(for: options.waitSettleDelay)

            return self
        }

        var pollInterval = min(options.waitPollInterval, options.waitPollIntervalLimit)
        let timeoutDate = Date(timeIntervalSinceNow: timeout)

        while Date() < timeoutDate {
            RunLoop.current.run(for: min(pollInterval, timeoutDate.timeIntervalSinceNow))

            if condition() {
                RunLoop.current.run(for: options.waitSettleDelay)

                return self
            }

            pollInterval = min(
                pollInterval * options.waitPollIntervalMultiplier,
                options.waitPollIntervalLimit
            )
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
    /// Интервал проверки условия и пауза после успешного ожидания
    /// задаются глобальными настройками ``TestingOptions/current``.
    ///
    /// - Parameters:
    ///   - condition: Замыкание, определяющее условие.
    ///   - timeout: Время ожидания в секундах.
    ///              По умолчанию используется ``TestingOptions/waitDefaultTimeout``.
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
        timeout: TimeInterval = TestingOptions.current.waitDefaultTimeout,
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
