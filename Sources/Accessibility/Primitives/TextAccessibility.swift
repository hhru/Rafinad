import Foundation

/// Accessibility-схема стандартного текстового UI-компонента.
///
/// `TextAccessibility` наследует базовый класс ``ViewAccessibility``
/// и используется в accessibility-схеме для объявления полей компонентов,
/// которые реализуются через стандартные `Text` в SwiftUI и `UILabel` в UIKit.
///
/// На стороне тестов для экземпляра ``TestingElement`` с типом `TextAccessibility`
/// доступны дополнительные поля, с помощью которых можно обрабатывать текст компонента:
/// - `text`: Текст компонента.
/// - `assert(text:)`: Проверяет, что текст компонента равен указанному.
/// - `waitForText(_:)`: Ждет указанное время, пока текст компонента не станет равен указанному.
///
/// > Tip: Актуальный список полей доступен в документации ``TestingElement``.
///
///
/// ## Пример
///
/// ``` swift
/// // Accessibility-схема компонента с текстовой меткой
/// class BadgeAccessibility: ViewAccessibility {
///
///     let label = TextAccessibility()
/// }
///
/// // Проверка текста метки в тесте
/// badge
///     .label
///     .assert(text: "123")
/// ```
///
///
/// ## See Also
///
/// - ``ViewAccessibility``
/// - ``AccessibilityKey``
/// - ``TestingElement``
open class TextAccessibility: ViewAccessibility { }
