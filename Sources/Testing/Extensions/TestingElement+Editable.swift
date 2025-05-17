import XCTest

#if !DOCUMENTATION
import Rafinad
#endif

extension TestingElement where Accessibility: EditableAccessibility {

    /// Введенный текст компонента.
    ///
    /// Равен `nil` в случае, если компонент не найден или имеет некорректный тип.
    public var text: String? {
        element.contentText
    }

    /// Текст-заполнитель компонента, который отображается, когда отсутствует введенный текст.
    ///
    /// Равен `nil` в случае, если компонент не найден или имеет некорректный тип.
    public var placeholder: String? {
        element.contentPlaceholder
    }

    /// Сфокусированное состояние компонента.
    ///
    /// Равно `nil` в случае, если компонент не найден или имеет некорректный тип.
    public var isFocused: Bool? {
        element.isContentFocused
    }

    /// Проверяет, что введенный текст компонента равен указанному.
    ///
    /// - Parameters:
    ///   - text: Введенный текст.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func assert(
        text: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertEqual(
            self.text,
            text,
            file: file,
            line: line
        )

        return self
    }

    /// Проверяет, что текст-заполнитель компонента равен указанному.
    ///
    /// - Parameters:
    ///   - placeholder: Текст-заполнитель.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func assert(
        placeholder: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertEqual(
            self.placeholder,
            placeholder,
            file: file,
            line: line
        )

        return self
    }

    /// Проверяет, что сфокусированное состояние компонента равно указанному.
    ///
    /// - Parameters:
    ///   - isFocused: Сфокусированное состояние.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func assert(
        isFocused: Bool,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertEqual(
            self.isFocused,
            isFocused,
            file: file,
            line: line
        )

        return self
    }

    /// Ждет указанное время, пока введенный текст компонента не станет равен указанному.
    ///
    /// - Parameters:
    ///   - text: Введенный текст.
    ///   - timeout: Время ожидания введенного текста компонента в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForText(
        _ text: String,
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        if !element.wait(for: \.contentText, toEqual: text, timeout: timeout), failing {
            XCTFail(
                "Text of element \(element) was not equal to \(text) within \(timeout) seconds",
                file: file,
                line: line
            )
        }

        return self
    }

    /// Ждет указанное время, пока текст-заполнитель компонента не станет равен указанному.
    ///
    /// - Parameters:
    ///   - placeholder: Текст-заполнитель.
    ///   - timeout: Время ожидания введенного текста компонента в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForPlaceholder(
        _ placeholder: String,
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        if !element.wait(for: \.contentPlaceholder, toEqual: placeholder, timeout: timeout), failing {
            XCTFail(
                "Placeholder of element \(element) was not equal to \(placeholder) within \(timeout) seconds",
                file: file,
                line: line
            )
        }

        return self
    }

    /// Ждет указанное время, пока компонент не получит фокус.
    ///
    /// - Parameters:
    ///   - timeout: Время ожидания фокуса компонента в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForFocused(
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        if !element.wait(for: \.isContentFocused, toEqual: true, timeout: timeout), failing {
            XCTFail(
                "Element \(element) was not focused within \(timeout) seconds",
                file: file,
                line: line
            )
        }

        return self
    }

    /// Ждет указанное время, пока компонент не потеряет фокус.
    ///
    /// - Parameters:
    ///   - timeout: Время ожидания потери фокуса с компонента в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForUnfocused(
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        if !element.wait(for: \.isContentFocused, toEqual: false, timeout: timeout), failing {
            XCTFail(
                "Element \(element) was not unfocused within \(timeout) seconds",
                file: file,
                line: line
            )
        }

        return self
    }

    /// Вводит указанный текст с клавиатуры.
    ///
    /// - Parameter text: Вводимый текст.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func typeText(_ text: String) -> Self {
        element.typeText(text)

        return self
    }

    /// Сабмитит введенную строку текста с помощью кнопки клавиатуры.
    ///
    /// В случае однострочных полей применяется сабмит всего текста, так как она состоит только из 1 строки.
    /// В случае многострочных полей применяется сабмит последней строки текста с переходом на следующую строку.
    ///
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func submitByKeyboard() -> Self {
        typeText("\n")
    }

    /// Очищает введенный текст с помощью клавиатуры.
    ///
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func clearByKeyboard() -> Self {
        guard let text, !text.isEmpty else {
            return self
        }

        let deleteText = String(
            repeating: XCUIKeyboardKey.delete.rawValue,
            count: text.count
        )

        return typeText(deleteText)
    }
}

extension XCUIElement {

    private var content: XCUIElement? {
        guard exists else {
            return nil
        }

        let contentTypes: [XCUIElement.ElementType] = [
            .textField,
            .textView,
            .secureTextField,
            .searchField
        ]

        if contentTypes.contains(elementType) {
            return self
        }

        let subpredicates = contentTypes
            .map { $0.rawValue }
            .map { NSPredicate(format: "elementType == %lu", $0) }

        let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: subpredicates)

        let child = children(matching: .any)
            .matching(predicate)
            .firstMatch

        return child.exists ? child : nil
    }

    fileprivate var contentText: String? {
        content?
            .value
            .flatMap { $0 as? String }
    }

    fileprivate var contentPlaceholder: String? {
        content.map { $0.placeholderValue ?? "" }
    }

    fileprivate var isContentFocused: Bool? {
        content?.value(forKey: "hasKeyboardFocus") as? Bool ?? false
    }
}
