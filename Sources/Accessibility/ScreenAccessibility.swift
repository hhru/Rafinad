import Foundation

/// Accessibility-схема экрана.
///
/// `ScreenAccessibility` используется в качестве базового класса вместо ``ViewAccessibility``
/// в случае объявления accessibility-схемы экрана.
///
/// Тесты используют accessibility-схему экрана для создания экземпляра ``TestingElement``,
/// оборачивая корневой объект `XCUIElement`, например, объект `XCUIApplication` тестируемого приложения.
///
///
/// ## Примитивные экраны
///
/// В самом простейшем случае accessibility-схема экрана представляет из себя "плоский" класс,
/// наследующий базовый `ScreenAccessibility`. Каждое свойство в этом классе представляет компонент,
/// который отображается на экране и интересен в тестах, например:
///
/// ``` swift
/// // Простейший экран, который отображает информацию пользователя
/// struct UserView: View {
///
///     let user: User
///
///     var body: some View {
///         VStack(spacing: .zero) {
///             Text(user.fullName)
///                 .font(.largeTitle)
///                 // Установка ключа для имени пользователя
///                 .accessibilityKey(\UserAccessibility.name)
///
///             Text(user.position)
///                 .font(.subheadline)
///                 .foregroundStyle(.secondary)
///                 // Установка ключа для должности пользователя
///                 .accessibilityKey(\UserAccessibility.position)
///                 .padding(.top, 4)
///         }
///         .padding(16)
///     }
/// }
///
/// // Простейшая accessibility-схема экрана пользователя
/// class UserAccessibility: ScreenAccessibility {
///
///     let name = TextAccessibility()
///     let position = TextAccessibility()
/// }
/// ```
///
/// Этот пример демонстрирует простейшую схему экрана, который состоит из 2 элементов.
/// Для всех этих элементов устанавливаются accessibility-ключи из схемы, и они получат идентификаторы,
/// содержащие префикс `UserAccessibility`, следовательно будут ассоциированы с этим экраном в иерархии.
///
///
/// ## Корневой контент экрана
///
/// Кроме составляющих компонентов экрана, в тестах может быть интересен его корневой контент,
/// например, для ожидания появления самого экрана. В этом случае можно добавить вложенный класс,
/// наследующий базовый ``ViewAccessibility``, и объявить в нем внутренние компоненты основного контента.
/// Тогда останется добавить свойство с типом этого класса в accessibility-схему самого экрана
/// и установить accessibility-ключ для него, например:
///
/// ``` swift
/// // Экран пользователя, корневой контент которого нужен в тестах
/// struct UserView: View {
///
///     let user: User
///
///     var body: some View {
///         ScrollView {
///             VStack(spacing: .zero) {
///                 Text(user.fullName)
///                     .font(.largeTitle)
///                     // Установка ключа для имени пользователя
///                     .accessibilityKey(\UserAccessibility.content.name)
///
///                 Text(user.position)
///                     .font(.subheadline)
///                     .foregroundStyle(.secondary)
///                     // Установка ключа для должности пользователя
///                     .accessibilityKey(\UserAccessibility.content.position)
///                     .padding(.top, 4)
///             }
///             .padding(16)
///         }
///         // Установка ключа для корневого контента экрана
///         .accessibilityKey(\UserAccessibility.content)
///     }
/// }
///
/// // Accessibility-схема экрана с вложенным классом для корневого контента
/// class UserAccessibility: ScreenAccessibility {
///
///     class Content: ViewAccessibility, SwipeableAccessibility {
///         let name = TextAccessibility()
///         let position = TextAccessibility()
///     }
///
///     let content = Content()
/// }
/// ```
///
/// Этот пример также демонстрирует использование протокола ``SwipeableAccessibility``
/// во вложенной схеме корневого контента, который наделяет его возможностью выполнять жесты свайпа в тестах.
///
///
/// ## Панель навигации экрана
///
/// На самом деле панель навигации не является частью экрана и в иерархии находится в самом стеке экранов.
/// Тем не менее в тестах удобнее обрабатывать его именно в контексте самого экрана,
/// поэтому его элементы также можно объявить в accessibility-схеме, но они должны располагаться отдельно,
/// либо самостоятельно в корне, либо в отдельном вложенном классе, например:
///
/// ``` swift
/// // Экран пользователя с заголовком и подзаголовком в панели навигации
/// struct UserView: View {
///
///     let user: User
///
///     var body: some View {
///         ScrollView {
///             VStack(spacing: .zero) {
///                 Text(user.fullName)
///                     .font(.largeTitle)
///                     // Установка ключа для имени пользователя
///                     .accessibilityKey(\UserAccessibility.content.name)
///
///                 Text(user.position)
///                     .font(.subheadline)
///                     .foregroundStyle(.secondary)
///                     // Установка ключа для должности пользователя
///                     .accessibilityKey(\UserAccessibility.content.position)
///                     .padding(.top, 4)
///             }
///             .padding(16)
///         }
///         // Установка ключа для корневого контента экрана
///         .accessibilityKey(\UserAccessibility.content)
///         .toolbar {
///             ToolbarItem(placement: .principal) {
///                 VStack(spacing: .zero) {
///                     Text("User")
///                         .font(.headline)
///                         // Установка ключа для заголовка в панели навигации
///                         .accessibilityKey(\UserAccessibility.navigationBar.title)
///
///                     Text("Details")
///                         .font(.subheadline)
///                         .foregroundStyle(.secondary)
///                         // Установка ключа для подзаголовка в панели навигации
///                         .accessibilityKey(\UserAccessibility.navigationBar.subtitle)
///                 }
///             }
///         }
///     }
/// }
///
/// // Accessibility-схема экрана с заголовком и подзаголовком в панели навигации
/// class UserAccessibility: ScreenAccessibility {
///
///     // Без наследования ViewAccessibility
///     class NavigationBar {
///         let title = TextAccessibility()
///         let subtitle = TextAccessibility()
///     }
///
///     class Content: ViewAccessibility, SwipeableAccessibility {
///         let name = TextAccessibility()
///         let position = TextAccessibility()
///     }
///
///     let navigationBar = NavigationBar()
///     let content = Content()
/// }
/// ```
///
/// Вложенный класс `NavigationBar` в этом примере не наследует ``ViewAccessibility``,
/// иначе для его поля `navigationBar` пришлось бы отдельно устанавливать accessibility-ключ,
/// а SwiftUI не поддерживает идентификацию самой панели навигации.
///
///
/// ## See Also
///
/// - ``ViewAccessibility``
/// - ``AccessibilityKey``
/// - ``TestingElement``
open class ScreenAccessibility {

    /// Создает экземпляр accessibility-схемы.
    public required init() { }
}
