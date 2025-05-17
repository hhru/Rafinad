import XCTest

#if !DOCUMENTATION
import Rafinad
#endif

extension TestingElement where Accessibility: ScreenAccessibility {

    /// Создает тестируемое представление экрана с заданным объектом `XCUIApplication`.
    ///
    /// - Parameter application: Оборачиваемый объект `XCUIApplication`.
    ///                          По умолчанию используется объект тестируемого приложения.
    public init(application: XCUIApplication = XCUIApplication()) {
        self.init(
            keyPaths: [\Accessibility.self],
            element: application
        )
    }

    /// Создает тестируемое представление экрана с заданным объектом `XCUIElement`.
    ///
    /// - Parameter element: Оборачиваемый объект `XCUIElement`.
    public init(element: XCUIElement) {
        self.init(
            keyPaths: [\Accessibility.self],
            element: element
        )
    }
}

extension XCUIElement {

    /// Создает тестируемое представление экрана с заданным типом его accessibility-схемы.
    ///
    /// - Parameter type: Тип accessibility-схемы экрана.
    /// - Returns: Тестируемое представление экрана.
    public func screen<Screen: ScreenAccessibility>(of type: Screen.Type) -> TestingElement<Screen> {
        TestingElement(element: self)
    }
}
