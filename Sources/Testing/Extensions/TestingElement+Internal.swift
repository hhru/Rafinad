import XCTest

extension TestingElement {

    @discardableResult
    internal func perform(
        action: () -> Void,
        limit: Int = 16,
        until condition: (Self) -> Bool
    ) -> Self {
        var count = 0

        while !condition(self), count < limit {
            action()

            count += 1
        }

        return self
    }

    @discardableResult
    internal func perform(
        action: () -> Void,
        limit: Int = 16,
        until condition: () -> Bool
    ) -> Self {
        perform(action: action, limit: limit) { _ in
            condition()
        }
    }
}
