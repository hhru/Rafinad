import XCTest

#if !DOCUMENTATION
import Rafinad
#endif

extension TestingElement where Accessibility: ImageAccessibility {

    /// Метка изображения.
    ///
    /// Равна `nil` в случае, если компонент не найден или имеет некорректный тип.
    public var label: String? {
        element.contentLabel
    }

    /// Проверяет, что метка изображения равна указанной.
    ///
    /// - Parameters:
    ///   - label: Метка изображения.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func assert(
        label: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertEqual(
            self.label,
            label,
            file: file,
            line: line
        )

        return self
    }

    /// Ждет указанное время, пока метка изображения не станет равна указанной.
    ///
    /// - Parameters:
    ///   - label: Метка изображения.
    ///   - timeout: Время ожидания метки изображения в секундах.
    ///              По умолчанию равен 4 секундам.
    ///   - failing: Флаг, определяющий необходимость сбоя после безуспешного ожидания.
    ///              По умолчанию флаг включен.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func waitForLabel(
        _ label: String,
        timeout: TimeInterval = 4,
        failing: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        if !element.wait(for: \.contentLabel, toEqual: label, timeout: timeout), failing {
            XCTFail(
                "Label of element \(element) was not equal to \(label) within \(timeout) seconds",
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

        if elementType == .image {
            return self
        }

        let child = children(matching: .image).firstMatch

        return child.exists
            ? child
            : nil
    }

    fileprivate var contentLabel: String? {
        content?.label
    }
}
