import XCTest

#if !DOCUMENTATION
import Rafinad
#endif

#if os(iOS) || os(macOS)
extension TestingElement where Accessibility: SwipeableAccessibility {

    /// Выполняет жест свайпа влево с указанной скоростью.
    ///
    /// - Parameter velocity: Скорость свайпа в пикселях в секуду. Имеет стандартное значение по умолчанию.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func swipeLeft(velocity: XCUIGestureVelocity = .default) -> Self {
        element.swipeLeft(velocity: velocity)

        return self
    }

    /// Выполняет жест свайпа влево с указанной скоростью до тех пор,
    /// пока не будет выполнено условие или количество попыток не превысит лимит.
    ///
    /// - Parameters:
    ///   - velocity: Скорость свайпа в пикселях в секуду. Имеет стандартное значение по умолчанию.
    ///   - limit: Максимальное количество попыток.
    ///   - condition: Замыкание, определяющее условие завершения.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func swipeLeft(
        velocity: XCUIGestureVelocity = .default,
        limit: Int = 16,
        until condition: (Self) -> Bool
    ) -> Self {
        perform(
            action: { swipeLeft(velocity: velocity) },
            limit: limit,
            until: condition
        )
    }

    /// Выполняет жест свайпа влево с указанной скоростью до тех пор,
    /// пока не будет выполнено условие или количество попыток не превысит лимит.
    ///
    /// - Parameters:
    ///   - velocity: Скорость свайпа в пикселях в секуду. Имеет стандартное значение по умолчанию.
    ///   - limit: Максимальное количество попыток.
    ///   - condition: Автозамыкание, определяющее условие завершения.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func swipeLeft(
        velocity: XCUIGestureVelocity = .default,
        limit: Int = 16,
        until condition: @autoclosure () -> Bool
    ) -> Self {
        perform(
            action: { swipeLeft(velocity: velocity) },
            limit: limit,
            until: condition
        )
    }

    /// Выполняет жест свайпа вправо с указанной скоростью.
    ///
    /// - Parameter velocity: Скорость свайпа в пикселях в секуду. Имеет стандартное значение по умолчанию.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func swipeRight(velocity: XCUIGestureVelocity = .default) -> Self {
        element.swipeRight(velocity: velocity)

        return self
    }

    /// Выполняет жест свайпа вправо с указанной скоростью до тех пор,
    /// пока не будет выполнено условие или количество попыток не превысит лимит.
    ///
    /// - Parameters:
    ///   - velocity: Скорость свайпа в пикселях в секуду. Имеет стандартное значение по умолчанию.
    ///   - limit: Максимальное количество попыток.
    ///   - condition: Замыкание, определяющее условие завершения.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func swipeRight(
        velocity: XCUIGestureVelocity = .default,
        limit: Int = 16,
        until condition: (Self) -> Bool
    ) -> Self {
        perform(
            action: { swipeRight(velocity: velocity) },
            limit: limit,
            until: condition
        )
    }

    /// Выполняет жест свайпа вправо с указанной скоростью до тех пор,
    /// пока не будет выполнено условие или количество попыток не превысит лимит.
    ///
    /// - Parameters:
    ///   - velocity: Скорость свайпа в пикселях в секуду. Имеет стандартное значение по умолчанию.
    ///   - limit: Максимальное количество попыток.
    ///   - condition: Автозамыкание, определяющее условие завершения.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func swipeRight(
        velocity: XCUIGestureVelocity = .default,
        limit: Int = 16,
        until condition: @autoclosure () -> Bool
    ) -> Self {
        perform(
            action: { swipeRight(velocity: velocity) },
            limit: limit,
            until: condition
        )
    }

    /// Выполняет жест свайпа вверх с указанной скоростью.
    ///
    /// - Parameter velocity: Скорость свайпа в пикселях в секуду. Имеет стандартное значение по умолчанию.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func swipeUp(velocity: XCUIGestureVelocity = .default) -> Self {
        element.swipeUp(velocity: velocity)

        return self
    }

    /// Выполняет жест свайпа вверх с указанной скоростью до тех пор,
    /// пока не будет выполнено условие или количество попыток не превысит лимит.
    ///
    /// - Parameters:
    ///   - velocity: Скорость свайпа в пикселях в секуду. Имеет стандартное значение по умолчанию.
    ///   - limit: Максимальное количество попыток.
    ///   - condition: Замыкание, определяющее условие завершения.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func swipeUp(
        velocity: XCUIGestureVelocity = .default,
        limit: Int = 16,
        until condition: (Self) -> Bool
    ) -> Self {
        perform(
            action: { swipeUp(velocity: velocity) },
            limit: limit,
            until: condition
        )
    }

    /// Выполняет жест свайпа вверх с указанной скоростью до тех пор,
    /// пока не будет выполнено условие или количество попыток не превысит лимит.
    ///
    /// - Parameters:
    ///   - velocity: Скорость свайпа в пикселях в секуду. Имеет стандартное значение по умолчанию.
    ///   - limit: Максимальное количество попыток.
    ///   - condition: Автозамыкание, определяющее условие завершения.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func swipeUp(
        velocity: XCUIGestureVelocity = .default,
        limit: Int = 16,
        until condition: @autoclosure () -> Bool
    ) -> Self {
        perform(
            action: { swipeUp(velocity: velocity) },
            limit: limit,
            until: condition
        )
    }

    /// Выполняет жест свайпа вниз с указанной скоростью.
    ///
    /// - Parameter velocity: Скорость свайпа в пикселях в секуду. Имеет стандартное значение по умолчанию.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func swipeDown(velocity: XCUIGestureVelocity = .default) -> Self {
        element.swipeDown(velocity: velocity)

        return self
    }

    /// Выполняет жест свайпа вниз с указанной скоростью до тех пор,
    /// пока не будет выполнено условие или количество попыток не превысит лимит.
    ///
    /// - Parameters:
    ///   - velocity: Скорость свайпа в пикселях в секуду. Имеет стандартное значение по умолчанию.
    ///   - limit: Максимальное количество попыток.
    ///   - condition: Замыкание, определяющее условие завершения.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func swipeDown(
        velocity: XCUIGestureVelocity = .default,
        limit: Int = 16,
        until condition: (Self) -> Bool
    ) -> Self {
        perform(
            action: { swipeDown(velocity: velocity) },
            limit: limit,
            until: condition
        )
    }

    /// Выполняет жест свайпа вниз с указанной скоростью до тех пор,
    /// пока не будет выполнено условие или количество попыток не превысит лимит.
    ///
    /// - Parameters:
    ///   - velocity: Скорость свайпа в пикселях в секуду. Имеет стандартное значение по умолчанию.
    ///   - limit: Максимальное количество попыток.
    ///   - condition: Автозамыкание, определяющее условие завершения.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func swipeDown(
        velocity: XCUIGestureVelocity = .default,
        limit: Int = 16,
        until condition: @autoclosure () -> Bool
    ) -> Self {
        perform(
            action: { swipeDown(velocity: velocity) },
            limit: limit,
            until: condition
        )
    }

    /// Выполняет жест перетягивания.
    ///
    /// - Parameters:
    ///   - startOffset: Начальная относительная позиция.
    ///   - finishOffset: Конечная относительная позиция.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func drag(from startOffset: CGVector, to finishOffset: CGVector) -> Self {
        let start = element.coordinate(withNormalizedOffset: startOffset)
        let finish = element.coordinate(withNormalizedOffset: finishOffset)

        start.press(
            forDuration: 0.05,
            thenDragTo: finish
        )

        return self
    }

    /// Выполняет жест перетягивания до тех пор,
    /// пока не будет выполнено условие или количество попыток не превысит лимит.
    ///
    /// - Parameters:
    ///   - startOffset: Начальная относительная позиция.
    ///   - finishOffset: Конечная относительная позиция.
    ///   - limit: Максимальное количество попыток.
    ///   - condition: Замыкание, определяющее условие завершения.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func drag(
        from startOffset: CGVector,
        to finishOffset: CGVector,
        limit: Int = 16,
        until condition: (Self) -> Bool
    ) -> Self {
        perform(
            action: { drag(from: startOffset, to: finishOffset) },
            limit: limit,
            until: condition
        )
    }

    /// Выполняет жест перетягивания до тех пор,
    /// пока не будет выполнено условие или количество попыток не превысит лимит.
    ///
    /// - Parameters:
    ///   - startOffset: Начальная относительная позиция.
    ///   - finishOffset: Конечная относительная позиция.
    ///   - limit: Максимальное количество попыток.
    ///   - condition: Автозамыкание, определяющее условие завершения.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func drag(
        from startOffset: CGVector,
        to finishOffset: CGVector,
        limit: Int = 16,
        until condition: @autoclosure () -> Bool
    ) -> Self {
        perform(
            action: { drag(from: startOffset, to: finishOffset) },
            limit: limit,
            until: condition
        )
    }

    /// Выполняет жест перетягивания с указанной относительной длиной.
    ///
    /// - Parameters:
    ///   - deltaX: Относительная длина по горизонтали.
    ///   - deltaY: Относительная длина по вертикали.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func drag(deltaX: CGFloat, deltaY: CGFloat) -> Self {
        let startOffset = CGVector(
            dx: max(min(0.5 - deltaX * 0.5, 1.0), 0.0),
            dy: max(min(0.5 - deltaY * 0.5, 1.0), 0.0)
        )

        let finishOffset = CGVector(
            dx: max(min(0.5 + deltaX * 0.5, 1.0), 0.0),
            dy: max(min(0.5 + deltaY * 0.5, 1.0), 0.0)
        )

        return drag(from: startOffset, to: finishOffset)
    }

    /// Выполняет жест перетягивания с указанной относительной длиной до тех пор,
    /// пока не будет выполнено условие или количество попыток не превысит лимит.
    ///
    /// - Parameters:
    ///   - deltaX: Относительная длина по горизонтали.
    ///   - deltaY: Относительная длина по вертикали.
    ///   - limit: Максимальное количество попыток.
    ///   - condition: Замыкание, определяющее условие завершения.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func drag(
        deltaX: CGFloat,
        deltaY: CGFloat,
        limit: Int = 16,
        until condition: (Self) -> Bool
    ) -> Self {
        perform(
            action: { drag(deltaX: deltaX, deltaY: deltaY) },
            limit: limit,
            until: condition
        )
    }

    /// Выполняет жест перетягивания с указанной относительной длиной до тех пор,
    /// пока не будет выполнено условие или количество попыток не превысит лимит.
    ///
    /// - Parameters:
    ///   - deltaX: Относительная длина по горизонтали.
    ///   - deltaY: Относительная длина по вертикали.
    ///   - limit: Максимальное количество попыток.
    ///   - condition: Автозамыкание, определяющее условие завершения.
    /// - Returns: Экземпляр тестируемого компонента.
    @discardableResult
    public func drag(
        deltaX: CGFloat,
        deltaY: CGFloat,
        limit: Int = 16,
        until condition: @autoclosure () -> Bool
    ) -> Self {
        perform(
            action: { drag(deltaX: deltaX, deltaY: deltaY) },
            limit: limit,
            until: condition
        )
    }
}
#endif
