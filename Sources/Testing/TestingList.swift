import XCTest

#if !DOCUMENTATION
@_exported @_spi(Private) import Rafinad
#endif

/// Тестируемое представление списка UI-компонентов для использования в тестах.
///
/// `TestingList` предоставляет методы проверки количества элементов в списке
/// и позволяет получить эти элементы по их индексу или уточняющей строке.
///
/// Экземпляр `TestingList` невозможно создать самостоятельно,
/// он может быть получен только при обращении к массиву accessibility-схемы
/// через экземпляр ``TestingElement``, например:
///
/// ``` swift
/// // Accessibility-схема компонента со списком
/// class TagsAccessibility: ViewAccessibility {
///
///     let items = [TextAccessibility]()
/// }
///
/// // Получение и проверка элемента списка по его индексу в тестах
/// tags
///     .items[0] // получение тега по его индексу
///     .assert(text: "iOS") // проверка текста тега
///
/// // Получение и проверка элемента списка по его уточняющей строке в тестах
/// tags
///     .items["iOS"] // получение тега по его уточняющей строке
///     .assert(text: "iOS") // проверка текста тега
/// ```
///
/// Чтобы получать элементы списка по уточняющей строке в тестах,
/// эта строка должна быть предварительно установлена вместе с accessibility-ключом, например:
///
/// ``` swift
/// // Компонент, который отображает список тегов
/// struct Tags: View {
///
///     let items: [String]
///
///     var body: some View {
///         HStack(spacing: 8) {
///             ForEach(items, id: \.self) { tag in
///                 Text(tag)
///                     .font(.subheadline)
///                     .padding(8)
///                     .background(.quinary)
///                     .clipShape(.rect(cornerRadius: 8))
///                     // Установка ключа для элемента списка с его уточнением
///                     .accessibilityKey(\TagsAccessibility.items, item: tag)
///             }
///         }
///         .accessibilityElement(children: .contain)
///     }
/// }
/// ```
///
/// Такое уточнение элемента не требуется, если в тестах достаточно получать элементы списка по их индексу.
///
///
/// ## See Also
///
/// - ``TestingElement``
/// - ``ViewAccessibility``
/// - ``ScreenAccessibility``
/// - ``AccessibilityKey``
@MainActor
public struct TestingList<Accessibility: ViewAccessibility> {

    internal let keyPaths: [AnyKeyPath]

    /// Объект `XCUIElement` родительского UI-компонента.
    public let element: XCUIElement

    /// Количество элементов в списке.
    public var count: Int {
        let subpredicates = keyPaths
            .map { $0.accessibilityIdentifier() }
            .map { NSPredicate(format: "identifier BEGINSWITH[c] %@", $0) }

        let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: subpredicates)

        return element
            .descendants(matching: .any)
            .matching(predicate)
            .count
    }

    /// Индикатор отсутствия элементов в списке.
    public var isEmpty: Bool {
        count == .zero
    }

    /// Проверяет, что количество элементов в списке равно указанному.
    ///
    /// - Parameters:
    ///   - count: Количество элементов списка.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого списка.
    @discardableResult
    public func assert(
        count: Int,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertEqual(
            self.count,
            count,
            file: file,
            line: line
        )

        return self
    }

    /// Проверяет, что индикатор отсутствия элементов в списке равен указанному.
    ///
    /// - Parameters:
    ///   - isEmpty: Индикатор отсутствия элементов списка.
    ///   - file: Файл, в котором должен произойти сбой.
    ///           По умолчанию используется имя файла, в котором был вызван этот метод.
    ///   - line: Номер строки, на которой должен произойти сбой.
    ///           По умолчанию используется номер строки, на которой был вызван этот метод.
    /// - Returns: Экземпляр тестируемого списка.
    @discardableResult
    public func assert(
        isEmpty: Bool,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        XCTAssertEqual(
            self.isEmpty,
            isEmpty,
            file: file,
            line: line
        )

        return self
    }

    /// Получает тестируемый элемент списка по его уточняющей строке.
    ///
    /// - Parameter item: Уточняющая строка элемента.
    /// - Returns: Тестируемый элемент списка.
    public subscript(item: String) -> TestingElement<Accessibility> {
        let subpredicates = keyPaths
            .map { $0.accessibilityIdentifier(item: item) }
            .map { NSPredicate(format: "identifier == %@", $0) }

        let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: subpredicates)

        let element = element
            .descendants(matching: .any)
            .matching(predicate)
            .firstMatch

        return TestingElement(element: element)
    }

    /// Получает тестируемый элемент списка по его индексу.
    ///
    /// - Parameter item: Индекс элемента.
    /// - Returns: Тестируемый элемент списка.
    public subscript(item: Int) -> TestingElement<Accessibility> {
        let subpredicates = keyPaths
            .map { $0.accessibilityIdentifier() }
            .map { NSPredicate(format: "identifier BEGINSWITH[c] %@", $0) }

        let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: subpredicates)

        let element = element
            .descendants(matching: .any)
            .matching(predicate)
            .element(boundBy: item)

        return TestingElement(element: element)
    }
}

extension TestingList: CustomDebugStringConvertible {

    public nonisolated var debugDescription: String {
        element.debugDescription
    }
}
