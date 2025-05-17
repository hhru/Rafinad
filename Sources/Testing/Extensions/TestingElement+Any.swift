import XCTest

#if !DOCUMENTATION
import Rafinad
#endif

extension TestingElement where Accessibility: AnyAccessibility {

    /// Уточняет конкретный тип компонента с неизвестным типом.
    ///
    /// - Parameter type: Тип компонента.
    /// - Returns: Экземпляр тестируемого компонента.
    public subscript<Wrapped: ViewAccessibility>(_ type: Wrapped.Type) -> TestingElement<Wrapped> {
        TestingElement<Wrapped>(element: element)
    }
}
