import Foundation

/// Accessibility-схема стандартного UI-компонента изображений.
///
/// `ImageAccessibility` наследует базовый класс ``ViewAccessibility``
/// и используется в accessibility-схеме для объявления полей компонентов,
/// которые реализуются через стандартные `Image` в SwiftUI и `UIImageView` в UIKit.
///
/// На стороне тестов для экземпляра ``TestingElement`` с типом `ImageAccessibility`
/// доступны дополнительные поля, с помощью которых можно обрабатывать метку изображения:
/// - `label`: Метка изображения.
/// - `assert(label:)`: Проверяет, что метка изображения равна указанной.
/// - `waitForLabel(_:)`: Ждет указанное время, пока метка изображения не станет равна указанной.
///
/// > Tip: Актуальный список полей доступен в документации ``TestingElement``.
///
///
/// ## Пример
///
/// ``` swift
/// // Accessibility-схема компонента с изображением
/// class AvatarAccessibility: ViewAccessibility {
///
///     let image = ImageAccessibility()
/// }
///
/// // Проверка метки изображения в тесте
/// avatar
///     .image
///     .assert(label: "Photo")
/// ```
///
///
/// ## See Also
///
/// - ``ViewAccessibility``
/// - ``AccessibilityKey``
/// - ``TestingElement``
open class ImageAccessibility: ViewAccessibility { }
