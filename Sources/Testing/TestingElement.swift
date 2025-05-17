import XCTest

#if !DOCUMENTATION
@_exported @_spi(Private) import Rafinad
#endif

/// Тестируемое представление UI-компонента или экрана.
///
/// `TestingElement` оборачивает объект `XCUIElement` и предоставляет удобные механизмы
/// для доступа к компонентам в его иерархии и выполнения действий над ними,
/// используя accessibility-схему в качестве источника данных о структуре и возможностях.
///
/// `TestingElement` повторяет структуру свойств accessibility-схемы и при обращении к ним
/// создает соответствующие тестируемые представления дочерних компонентов,
/// используя механизм Key-Path Dynamic Member Lookup.
/// При этом если свойство accessibility-схемы имеет тип ``ViewAccessibility`` или его наследников,
/// то `TestingElement` будет пытаться найти для него объект `XCUIElement` в иерархии,
/// поэтому это свойство обязательно должно быть установлено в качестве accessibility-ключа в самом компоненте.
///
/// Кроме получения дочерних компонентов, `TestingElement` предоставляет набор методов и свойств
/// для проверки и выполнения действий с самим тестируемым компонентом.
/// Этот набор зависит от базового класса его accessibility-схемы и протоколов дополнительных возможностей.
///
///
/// ## Тестируемое представление экрана
///
/// В подавляющем большинстве случаев, чтобы получить тестируемое представление экрана,
/// достаточно вызвать метод `screen(of:)` объекта `XCUIApplication`,
/// передав тип accessibility-схемы искомого экрана, который наследует класс ``ScreenAccessibility``, например:
///
/// ``` swift
/// // Accessibility-схема экрана пользователя
/// class UserAccessibility: ScreenAccessibility {
///
///     let name = TextAccessibility()
///     let position = TextAccessibility()
/// }
///
/// func testUserScreen() {
///     let application = XCUIApplication()
///
///     application.launch()
///
///     application
///         .screen(of: UserAccessibility.self) // получение экрана
///         .position // получение компонента должности пользователя
///         .waitForExistence() // ожидание появления компонента должности
///         .assert(text: "iOS Developer") // проверка текста должности
/// }
/// ```
///
/// В этом примере тестируемое представление экрана будет использовать объект `XCUIApplication`
/// для поиска и получения дочерних компонентов, используя их accessibility-ключи.
///
/// Если же в иерархии приложения одновременно может отображаться два или более одинаковых экрана,
/// например, в разных окнах `UIWindow`, то для получения тестируемого представления определенного из них
/// следует предварительно уточнить объект `XCUIElement`, например:
///
/// ``` swift
/// func testUserScreen() {
///     let application = XCUIApplication()
///
///     application.launch()
///
///     application
///         .windows
///         .element(boundBy: 1) // уточнение окна приложения
///         .screen(of: UserAccessibility.self) // получение экрана
///         .position // получение компонента должности пользователя
///         .waitForExistence() // ожидание появления компонента должности
///         .assert(text: "iOS Developer") // проверка текста должности
/// }
/// ```
///
///
/// ## Тестируемое представление компонента
///
/// В иерархии одновременно может находиться несколько компонентов с одинаковыми идентификаторами,
/// их уникальность гарантируется только за счет их расположения в самой иерархии.
/// Поэтому тестируемые представления для них рекомендуется получать через
/// экземпляр `TestingElement` их родителя, начиная цепочку с экземпляра самого экрана,
/// как показано в предыдущем примере.
///
/// Однако в целях миграции или отладки экземпляр `TestingElement` для компонента может быть создан самостоятельно.
/// Для этого достаточно вызвать метод `view(of:)` предварительно найденного объекта `XCUIElement`,
/// передав в него тип accessibility-схемы, который соответствует классу ``ViewAccessibility``, например:
///
/// ``` swift
/// // Accessibility-схема компонента
/// class CellAccessibility: ViewAccessibility {
///
///     let title = TextAccessibility()
///     let subtitle = TextAccessibility()
/// }
///
/// func testUserPosition() {
///     let application = XCUIApplication()
///
///     application.launch()
///
///     let cell = application
///         .otherElements["CellIdentifier"] // поиск ячейки через стандартный идентификатор
///         .firstMatch
///         .view(of: CellAccessibility.self) // получение компонента ячейки
///
///     cell
///         .assert(isExist: true) // проверка наличия компонента
///         .subtitle // получение компонента подзаголовка
///         .waitForText("iOS Developer") // ожидание текста подзаголовка
/// }
/// ```
///
///
/// ## Компоненты со списками
///
/// Если свойство в accessibility-схеме имеет тип массива, то при обращении к нему через экземпляр `TestingElement`
/// будет получено тестируемое представление списка в виде экземпляра ``TestingList``,
/// которое можно использовать для проверки количества элементов или получения этих элементов
/// по их индексу или уточняющей строке, например:
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
/// > Important: Чтобы получать элементы списка по уточняющей строке в тестах,
/// эта строка должна быть предварительно установлена вместе с accessibility-ключом (см. ``AccessibilityKey``).
///
///
/// ## Компоненты неизвестного типа
///
/// Если свойство в accessibility-схеме имеет тип ``AnyAccessibility``,
/// то при обращении к нему через экземпляр `TestingElement` будут доступны только базовые действия,
/// актуальные для любых компонентов. Чтобы иметь полный набор действий и доступ к внутренней иерархии,
/// необходимо уточнить конкретный тип accessibility-схемы тестируемого компонента, например:
///
/// ``` swift
/// // Accessibility-схема компонента с контентом неизвестного типа
/// class AvatarAccessibility: ViewAccessibility {
///
///     let image = ImageAccessibility()
///     let placeholder = AnyAccessibility()
/// }
///
/// // Проверка в тестах без уточнения конкретного типа
/// avatar
///     .placeholder // без уточнения типа доступны только общие действия
///     .waitForExistence() // базовое действие ожидания появления компонента
///
/// // Проверка в тестах с уточнением конкретного типа
/// avatar
///     .placeholder[ImageAccessibility.self] // уточнение конкретного типа
///     .waitForExistence() // базовое действие ожидания появления компонента
///     .assert(label: "Placeholder") // специфичная проверка метки изображения
/// ```
///
///
/// ## See Also
///
/// - ``ViewAccessibility``
/// - ``ScreenAccessibility``
/// - ``AccessibilityKey``
/// - ``TestingList``
@MainActor
@dynamicMemberLookup
public struct TestingElement<Accessibility: AnyObject>: Testing {

    internal let keyPaths: [AnyKeyPath]

    /// Обернутый объект `XCUIElement`.
    public let element: XCUIElement

    /// Получает тестируемое представление дочернего компонента.
    ///
    /// - Parameter keyPath: Key-path дочернего компонента в accessibility-схеме.
    /// - Returns: Экземпляр тестируемого компонента.
    public subscript<Subview: ViewAccessibility>(
        dynamicMember keyPath: KeyPath<Accessibility, Subview>
    ) -> TestingElement<Subview> {
        let keyPaths = keyPaths
            .compactMap { $0.appending(path: keyPath) }
            .appending(\Subview.self)

        let subpredicates = keyPaths
            .map { $0.accessibilityIdentifier() }
            .map { NSPredicate(format: "identifier == %@", $0) }

        let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: subpredicates)

        let subviewElement = element
            .descendants(matching: .any)
            .matching(predicate)
            .firstMatch

        let subviewType = String(reflecting: Subview.self)

        let subviewKeyPaths = subviewType.count { $0 == .dot } > 1
            ? keyPaths
            : [\Subview.self]

        return TestingElement<Subview>(
            keyPaths: subviewKeyPaths,
            element: subviewElement
        )
    }

    /// Получает тестируемое представление дочерней группы компонентов.
    ///
    /// - Parameter keyPath: Key-path дочерней группы компонентов в accessibility-схеме.
    /// - Returns: Экземпляр тестируемой группы компонентов.
    public subscript<Subnode: AnyObject>(
        dynamicMember keyPath: KeyPath<Accessibility, Subnode>
    ) -> TestingElement<Subnode> {
        let subnodeType = String(reflecting: Subnode.self)

        if subnodeType.count(where: { $0 == .dot }) <= 1 {
            return TestingElement<Subnode>(
                keyPaths: [\Subnode.self],
                element: element
            )
        }

        let keyPaths = keyPaths
            .compactMap { $0.appending(path: keyPath) }
            .appending(\Subnode.self)

        return TestingElement<Subnode>(
            keyPaths: keyPaths,
            element: element
        )
    }

    /// Получает тестируемое представление дочернего списка компонентов.
    ///
    /// - Parameter keyPath: Key-path дочернего списка компонентов в accessibility-схеме.
    /// - Returns: Экземпляр тестируемого списка компонентов.
    public subscript<Collection: RangeReplaceableCollection>(
        dynamicMember keyPath: KeyPath<Accessibility, Collection>
    ) -> TestingList<Collection.Element> where Collection.Element: ViewAccessibility {
        let keyPaths = keyPaths.compactMap { $0.appending(path: keyPath) }

        return TestingList<Collection.Element>(
            keyPaths: keyPaths,
            element: element
        )
    }
}

extension TestingElement: CustomDebugStringConvertible {

    public nonisolated var debugDescription: String {
        element.debugDescription
    }
}
