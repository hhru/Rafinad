import Foundation

/// Accessibility-схема UI-компонента с неизвестным типом.
///
/// `AnyAccessibility` наследует базовый класс ``ViewAccessibility``
/// и используется в accessibility-схеме для объявления полей компонентов,
/// тип которых заранее неизвестен, например, является generic-типом или типом `AnyView`.
///
/// На стороне тестов для экземпляра ``TestingElement`` с типом `AnyAccessibility`
/// доступен дополнительный сабскрипт, с помощью которого можно уточнить его конкретный тип по месту.
/// Без уточнения типа для этого компонента будет доступен только базовый набор действий.
///
///
/// ## Пример
///
/// ``` swift
/// // Accessibility-схема компонента с контентом неизвестного типа
/// class AvatarAccessibility: ViewAccessibility {
///
///     let image = ImageAccessibility()
///     let placeholder = AnyAccessibility()
/// }
///
/// // Проверка в тесте, что заполнитель отсутствует
/// avatar
///     .placeholder // без уточнения доступны только базовые действия
///     .assert(isExist: false)
///
/// // Проверка метки изображения-заполнителя в тесте
/// avatar
///     .placeholder[ImageAccessibility.self] // уточнение конкретного типа
///     .assert(label: "Placeholder") // специфичная проверка метки
/// ```
///
///
/// ## See Also
///
/// - ``ViewAccessibility``
/// - ``AccessibilityKey``
/// - ``TestingElement``
public final class AnyAccessibility: ViewAccessibility { }
