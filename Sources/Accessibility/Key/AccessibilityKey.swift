import SwiftUI

/// Accessibility-ключ UI-компонента для его поиска в тестах.
///
/// Позволяет установить key-path поля из accessibility-схемы в качестве идентификатора компонента.
/// Это в свою очередь позволяет находить эти компоненты в UI-тестах, используя обертку ``TestingElement``.
///
/// Accessibility-ключ устанавливает стандартный accessibility-идентификатор компонента таким,
/// каким является сама запись key-path с полным названием типа, но без символа `\`.
/// Например, если установить key-path `\MyComponentAccessibility.Nested.title` в качестве accessibility-ключа,
/// то фактическим идентификатором компонента будет строка `"MyComponentAccessibility.Nested.title"`.
///
/// Поэтому в иерархии одновременно могут находиться несколько компонентов с одинаковыми идентификаторами,
/// в этом случае их уникальность гарантируется за счет их расположения в самой иерархии,
/// так как ``TestingElement`` будет искать компоненты по уровням их вложенности, следуя по полному пути в key-path.
///
/// Исключением являются только списки компонентов, так как они расположены на одном уровне в иерархии.
/// Поэтому в тестах элемент списка можно получить либо через индекс, либо через уточняющую строку,
/// если она предварительно установлена вместе с accessibility-ключом.
///
///
/// ## Использование в SwiftUI
///
/// Чтобы установить accessibility-ключ для компонента в SwiftUI, достаточно использовать метод `accessibilityKey(_:)`,
/// передав в него key-path поля из accessibility-схемы.
///
/// Также элементы списка можно уточнять дополнительной строкой, используя опциональный параметр `item`.
/// Этот параметр доступен, только если в качестве accessibility-ключа используется key-path массива.
///
/// ``` swift
/// // Accessibility-схема компонента
/// class TagsAccessibility: ViewAccessibility {
///
///     // Обычный текстовый UI-компонент
///     let title = TextAccessibility()
///
///     // Массив текстовых UI-компонентов
///     let items = [TextAccessibility]()
/// }
///
/// struct Tags: View {
///
///     let title: String
///     let items: [String]
///
///     var body: some View {
///         VStack(alignment: .leading, spacing: 12) {
///             Text(title)
///                 .font(.title2)
///                 // Установка ключа для обычного поля из accessibility-схемы
///                 .accessibilityKey(\TagsAccessibility.title)
///
///             HStack(spacing: 8) {
///                 ForEach(items, id: \.self) { item in
///                     Text(item)
///                         .font(.subheadline)
///                         .padding(8)
///                         .background(.quinary)
///                         .clipShape(.rect(cornerRadius: 8))
///                         // Установка ключа для массива из accessibility-схемы с его уточнением
///                         .accessibilityKey(\TagsAccessibility.items, item: item)
///                 }
///             }
///         }
///         .frame(maxWidth: .infinity, alignment: .leading)
///         // Создание accessibility-контейнера, чтобы находить стек в тестах
///         .accessibilityElement(children: .contain)
///     }
/// }
/// ```
///
/// > Important: SwiftUI исключает контейнеры (`HStack`, `VStack`, `Group` и т.д.) из иерархии accessibility-элементов,
/// при этом установленный снаружи идентификатор заменяет идентификаторы их внутренних компонентов.
/// Поэтому, если компонент отображает несколько элементов через стек или другой контейнер,
/// то для доступа  к нему в тестах следует создать accessibility-элемент самостоятельно,
/// используя модификатор `.accessibilityElement(children: .contain)`.
///
///
/// ## Использование в UIKit
///
/// Чтобы установить accessibility-ключ для компонента в UIKit, достаточно использовать свойство `accessibilityKey`,
/// передав в него key-path поля из accessibility-схемы.
///
/// Также элементы списка можно уточнять дополнительной строкой, используя опциональный параметр `item`.
/// Этот параметр доступен, только если в качестве accessibility-ключа используется key-path массива.
///
/// ``` swift
/// // Accessibility-схема компонента
/// class MyComponentAccessibility: ViewAccessibility {
///
///     // Обычный текстовый UI-компонент
///     let title = TextAccessibility()
///
///     // Массив текстовых UI-компонентов
///     let tags = [TextAccessibility]()
/// }
///
/// class MyComponentView: UIView {
///
///     let titleLabel = UILabel()
///     let tagsView = UIStackView()
///
///     func updateTitle(with title: String) {
///         titleLabel.text = title
///
///         // Установка ключа для обычного поля из accessibility-схемы
///         titleLabel.accessibilityKey = .keyPath(\MyComponentAccessibility.title)
///     }
///
///     func updateTags(with tags: [String]) {
///         tagsView
///             .arrangedSubviews
///             .forEach { $0.removeFromSuperview() }
///
///         tags.forEach { tag in
///             let tagLabel = UILabel()
///
///             tagLabel.font = .preferredFont(forTextStyle: .title2)
///             tagLabel.text = tag
///
///             // Установка ключа для массива из accessibility-схемы с его уточнением
///             tagLabel.accessibilityKey = .keyPath(\MyComponentAccessibility.tags, item: tag)
///
///             tagsView.addArrangedSubview(tagLabel)
///         }
///     }
/// }
/// ```
///
///
/// ## Глобальное отключение
///
/// Установку accessibility-ключей можно глобально выключить, например, для Release-конфигураций.
/// Для этого достаточно установить значение `false` для static-флага ``isEnabled``, например:
///
/// ``` swift
/// @main
/// struct ExampleApp: App {
///
///     init() {
///         #if !DEBUG
///             AccessibilityKey.isEnabled = false
///         #endif
///     }
/// }
/// ```
///
///
/// ## See Also
///
/// - ``ViewAccessibility``
/// - ``ScreenAccessibility``
/// - ``TestingElement``
public struct AccessibilityKey: Hashable, Equatable, Sendable {

    private let content: AccessibilityKeyContent

    /// Итоговый accessibility-идентификатор.
    ///
    /// Вернет `nil`, если отключен глобальный флаг `isEnabled`.
    @MainActor
    public var identifier: String? {
        Self.isEnabled
            ? content.identifier
            : nil
    }

    private init(content: AccessibilityKeyContent) {
        self.content = content
    }
}

extension AccessibilityKey: ViewModifier {

    public func body(content: Content) -> some View {
        if let identifier {
            content.accessibilityIdentifier(identifier)
        } else {
            content
        }
    }
}

extension AccessibilityKey {

    /// Флаг, включающий установку accessibility-идентификаторов.
    ///
    /// По умолчанию имеет значение `true`.
    @MainActor
    public static var isEnabled = true

    /// Создает accessibility-ключ UI-компонента с итоговым идентификатором.
    ///
    /// - Parameter identifier: Итоговый идентификатор.
    /// - Returns: Accessibility-ключ UI-компонента.
    public static func identifier(_ identifier: String) -> Self {
        Self(content: .identifier(identifier))
    }

    /// Создает accessibility-ключ UI-компонента из key-path поля из accessibility-схемы.
    ///
    /// - Parameter keyPath: Key-path поля из accessibility-схемы.
    /// - Returns: Accessibility-ключ UI-компонента.
    public static func keyPath<Root: AnyObject, Value: ViewAccessibility>(
        _ keyPath: KeyPath<Root, Value>
    ) -> Self {
        Self(content: .keyPath(keyPath))
    }

    /// Создает ключ UI-компонента из key-path массива из accessibility-схемы
    /// и уточняющей строки элемента этого массива.
    ///
    /// - Parameters:
    ///   - keyPath: Key-path массива из accessibility-схемы.
    ///   - item: Уточняющая строка элемента массива.
    ///           По умолчанию равен `nil`.
    /// - Returns: Accessibility-ключ UI-компонента.
    public static func keyPath<Root: AnyObject, Value: RangeReplaceableCollection>(
        _ keyPath: KeyPath<Root, Value>,
        item: String? = nil
    ) -> Self where Value.Element: ViewAccessibility {
        Self(content: .keyPath(keyPath, item: item))
    }
}
