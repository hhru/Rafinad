import XCTest

#if !DOCUMENTATION
import Rafinad
#endif

extension TestingElement where Accessibility: TextAccessibility {

    /// Текст компонента.
    ///
    /// Равен `nil` в случае, если компонент не найден или имеет некорректный тип.
    public var text: String? {
        element.contentText
    }

    /// Проверяет, что текст компонента равен указанному.
    ///
    /// - Parameters:
    ///   - text: Текст компонента.
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

    /// Ждет указанное время, пока текст компонента не станет равен указанному.
    ///
    /// - Parameters:
    ///   - text: Текст компонента.
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
}

extension XCUIElement {

    private var content: XCUIElement? {
        guard exists else {
            return nil
        }

        if elementType == .staticText {
            return self
        }

        let child = children(matching: .staticText).firstMatch

        return child.exists
            ? child
            : nil
    }

    fileprivate var contentText: String? {
        content?.label
    }
}
