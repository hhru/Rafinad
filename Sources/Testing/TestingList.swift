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
public struct TestingList<Accessibility: ViewAccessibility>: Testing {

    internal let keyPaths: [AnyKeyPath]

    /// Объект `XCUIElement` родительского UI-компонента.
    public let element: XCUIElement

    /// Количество элементов в списке.
    ///
    /// Равен `nil` в случае, если список не найден или имеет некорректный тип.
    public var count: Int? {
        guard element.exists else {
            return nil
        }

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
    ///
    /// Равен `nil` в случае, если список не найден или имеет некорректный тип.
    public var isEmpty: Bool? {
        count.map { $0 == .zero }
    }

    /// Считает количество элементов, которые соответствуют условию.
    ///
    /// - Parameters predicate: Замыкание, определяющее условие.
    /// - Returns: Количество элементов или `nil`, если список не найден или имеет некорректный тип.
    public func count(where predicate: (TestingElement<Accessibility>) -> Bool) -> Int? {
        guard let count else {
            return nil
        }

        return (0..<count).count { index in
            predicate(self[index])
        }
    }

    /// Определяет наличие элемента в списке, которое соответствует условию.
    ///
    /// - Parameters predicate: Замыкание, определяющее условие.
    /// - Returns: Наличие элемента в списке или `nil`, если список не найден.
    public func contains(where predicate: (TestingElement<Accessibility>) -> Bool) -> Bool? {
        guard let count else {
            return nil
        }

        return (0..<count).contains { index in
            predicate(self[index])
        }
    }

    /// Определяет, что все элементы в списке соответствуют условию.
    ///
    /// Если список пуст, то возвращает `true`.
    ///
    /// - Parameters predicate: Замыкание, определяющее условие.
    /// - Returns: Наличие элемента в списке или `nil`, если список не найден или имеет некорректный тип.
    public func allSatisfy(_ predicate: (TestingElement<Accessibility>) -> Bool) -> Bool? {
        guard let count else {
            return nil
        }

        return (0..<count).allSatisfy { index in
            predicate(self[index])
        }
    }

    /// Получает первый элемент списка, который соответствует условию.
    ///
    /// - Parameters predicate: Замыкание, определяющее условие.
    /// - Returns: Тестируемый элемент списка.
    public func first(where predicate: (TestingElement<Accessibility>) -> Bool) -> TestingElement<Accessibility>? {
        guard let count else {
            return nil
        }

        return (0..<count)
            .lazy
            .map { self[$0] }
            .first { predicate($0) }
    }

    /// Получает последний элемент списка, который соответствует условию.
    ///
    /// - Parameters predicate: Замыкание, определяющее условие.
    /// - Returns: Тестируемый элемент списка.
    public func last(where predicate: (TestingElement<Accessibility>) -> Bool) -> TestingElement<Accessibility>? {
        guard let count else {
            return nil
        }

        return (0..<count)
            .lazy
            .map { self[$0] }
            .last { predicate($0) }
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
